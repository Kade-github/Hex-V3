import argparse
import os
import struct
import subprocess
import sys
import tempfile
from concurrent.futures import ThreadPoolExecutor

import numpy as np
from PIL import Image

Image.MAX_IMAGE_PIXELS = None

ROOT = os.path.dirname(os.path.abspath(__file__))

SKIP_DIRS = {".git", "looks", "fonts", "mods", "concept-or-unused"}

HEADER = 128


def png_size(path):
    with open(path, "rb") as f:
        head = f.read(24)
    return struct.unpack(">II", head[16:24])


def find(root, min_mb, only):
    found = []
    for folder, dirs, files in os.walk(root):
        dirs[:] = [d for d in dirs if d not in SKIP_DIRS]
        for name in files:
            if not name.lower().endswith(".png"):
                continue
            path = os.path.join(folder, name)
            rel = os.path.relpath(path, root).replace(os.sep, "/")
            if only and not any(o.lower() in rel.lower() for o in only):
                continue
            w, h = png_size(path)
            if w * h * 4 < min_mb * 1048576:
                continue
            found.append((path, rel, w, h))
    return sorted(found, key=lambda f: f[1])


def expected_bytes(w, h, opaque):
    blocks = ((w + 3) // 4) * ((h + 3) // 4)
    return HEADER + blocks * (8 if opaque else 16)


def check(path, w, h, opaque):
    with open(path, "rb") as f:
        head = f.read(HEADER)
    magic, size, _, got_h, got_w, _, _, mips = struct.unpack("<4sIIIIIII", head[:32])
    fourcc = head[84:88]
    want = b"DXT1" if opaque else b"DXT5"
    if magic != b"DDS " or size != 124:
        return "not a DDS file"
    if (got_w, got_h) != (w, h):
        return "size %dx%d, wanted %dx%d" % (got_w, got_h, w, h)
    if mips > 1:
        return "has %d mip levels, the game only takes one" % mips
    if fourcc != want:
        return "format %r, wanted %r" % (fourcc, want)
    if os.path.getsize(path) != expected_bytes(w, h, opaque):
        return "%d bytes, wanted %d" % (os.path.getsize(path), expected_bytes(w, h, opaque))
    return None


def psnr(a, b):
    diff = a.astype(np.float32) - b.astype(np.float32)
    mse = float((diff * diff).mean())
    return 99.0 if mse == 0 else 10 * np.log10(255 * 255 / mse)


def target(path, rel, out_dir):
    if out_dir:
        return os.path.join(out_dir, os.path.splitext(rel)[0].replace("/", os.sep) + ".dds")
    return os.path.splitext(path)[0] + ".dds"


def convert(item, force, verify, out_dir):
    path, rel, w, h = item
    out = target(path, rel, out_dir)

    if not force and os.path.exists(out) and os.path.getmtime(out) >= os.path.getmtime(path):
        return (rel, "kept", os.path.getsize(out), w * h * 4, None)

    pixels = np.asarray(Image.open(path).convert("RGBA")).copy()
    opaque = bool(pixels[..., 3].min() == 255)

    # The game treats these textures as premultiplied, the way it leaves a PNG after loading it.
    if not opaque:
        alpha = pixels[..., 3:4].astype(np.uint16)
        pixels[..., :3] = ((pixels[..., :3].astype(np.uint16) * alpha + 127) // 255).astype(np.uint8)

    with tempfile.TemporaryDirectory() as tmp:
        src = os.path.join(tmp, "in.png")
        made = os.path.join(tmp, "out.dds")
        Image.fromarray(pixels, "RGBA").save(src, compress_level=1)

        subprocess.run(
            [
                "magick", src,
                "-define", "dds:compression=dxt5",
                "-define", "dds:mipmaps=0",
                "-define", "dds:cluster-fit=true",
                made,
            ],
            check=True,
        )

        problem = check(made, w, h, False)
        if problem is not None:
            return (rel, "FAILED: " + problem, 0, w * h * 4, None)

        quality = None
        if verify:
            back = np.asarray(Image.open(made).convert("RGBA"))
            quality = psnr(pixels, back[:h, :w])

        with open(made, "rb") as f:
            data = f.read()

    os.makedirs(os.path.dirname(out), exist_ok=True)
    with open(out, "wb") as f:
        f.write(data)

    return (rel, "BC3", len(data), w * h * 4, quality)


def main():
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--root", default=ROOT)
    parser.add_argument("--min-mb", type=float, default=4)
    parser.add_argument("--only", action="append", default=[])
    parser.add_argument("--force", action="store_true")
    parser.add_argument("--clean", action="store_true")
    parser.add_argument("--no-verify", action="store_true")
    parser.add_argument("--jobs", type=int, default=3)
    parser.add_argument("--out", default=None)
    args = parser.parse_args()

    items = find(args.root, args.min_mb, args.only)

    if args.clean:
        gone = 0
        for path, rel, w, h in items:
            out = target(path, rel, args.out)
            if os.path.exists(out):
                os.remove(out)
                gone += 1
        print("Removed %d .dds files." % gone)
        return 0

    print("%d PNGs of %g MB and up under %s" % (len(items), args.min_mb, args.root))

    failed = 0
    raw_total = 0
    dds_total = 0
    worst = None

    with ThreadPoolExecutor(max_workers=max(1, args.jobs)) as pool:
        for rel, what, size, raw, quality in pool.map(lambda i: convert(i, args.force, not args.no_verify, args.out), items):
            if what.startswith("FAILED"):
                failed += 1
            else:
                raw_total += raw
                dds_total += size

            note = "" if quality is None else "  %.1f dB" % quality
            if quality is not None and (worst is None or quality < worst[0]):
                worst = (quality, rel)

            print("%-6s %7.1f MB -> %6.1f MB%s  %s" % (what[:6], raw / 1048576, size / 1048576, note, rel))
            if what.startswith("FAILED"):
                print("       " + what)

    print()
    print("Texture memory for these files: %.0f MB as PNG, %.0f MB as DDS." % (raw_total / 1048576, dds_total / 1048576))
    if worst is not None:
        print("Lowest match to the source: %.1f dB (%s)." % worst)
    if failed:
        print("%d files failed and were left without a .dds." % failed)

    return 1 if failed else 0


if __name__ == "__main__":
    sys.exit(main())

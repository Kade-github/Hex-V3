"""
Generates the LUTs for the characters (week1/week2)
"""

import argparse
import os
import re

import numpy as np
from PIL import Image
from scipy import sparse
from scipy.sparse.linalg import cg

HERE = os.path.dirname(os.path.abspath(__file__))
LOOKS = os.path.join(HERE, '..', 'looks')

CHARACTERS = {
    'hex': {'sunset': 'sunsethex', 'night': 'nighthex',
            'weekend': 'wkhex', 'weekend-dark': 'wkhex-dark', 'weekend-lcdred': 'wkhex-lcdred',
            'weekend-lcdreddark': 'wkhex-lcdreddark'},
    'bf-old': {'sunset': 'sunsetbf', 'night': 'nightbf', 'glitcher': 'glitcherbf',
               'weekend': 'wkbf', 'weekend-dark': 'wkbf-dark', 'weekend-lcdred': 'wkbf-lcdred',
               'weekend-lcdreddark': 'wkbf-lcdreddark'},
    'gf-old': {'sunset': 'sunsetgf', 'night': 'nightgf', 'glitcher': 'glitchergf',
               'weekend': 'wkgf', 'weekend-dark': 'wkgf-dark', 'weekend-lcdred': 'wkgf-lcdred',
               'weekend-lcdreddark': 'wkgf-lcdreddark'},
}

ALL_LOOKS = ['sunset', 'night', 'glitcher', 'weekend', 'weekend-dark', 'weekend-lcdred', 'weekend-lcdreddark']
RECOLORS = None


def recolor_paths(recolor):
    inside = os.path.join(HERE, recolor, recolor)
    if os.path.exists(inside + '.png'):
        return inside + '.png', inside + '.xml'
    if RECOLORS:
        outside = os.path.join(RECOLORS, recolor)
        if os.path.exists(outside + '.png'):
            return outside + '.png', outside + '.xml'
    return None

N = 32
RADII = [3.0, 7.0, 12.0]
DIRS = [(np.cos(a), np.sin(a)) for a in np.linspace(0, 2 * np.pi, 8, endpoint=False)]
GAINS = [1.0, 2.5, 4.0, 6.0, 10.0]


def load(path):
    return np.asarray(Image.open(path).convert('RGBA')).astype(np.float64) / 255.0


def frames(xml_path):
    text = open(xml_path, encoding='utf-8-sig').read()
    out = {}
    for m in re.finditer(r'<SubTexture ([^>]*)/>', text):
        a = dict(re.findall(r'(\w+)="([^"]*)"', m.group(1)))
        out[a['name']] = a
    return out


def frame_canvas(sheet, f):
    x, y, w, h = int(f['x']), int(f['y']), int(f['width']), int(f['height'])
    piece = sheet[y:y + h, x:x + w]
    fw = int(f.get('frameWidth', w))
    fh = int(f.get('frameHeight', h))
    fx = -int(f.get('frameX', 0))
    fy = -int(f.get('frameY', 0))
    out = np.zeros((fh, fw, 4))
    ph, pw = piece.shape[:2]
    out[fy:fy + ph, fx:fx + pw] = piece[:max(0, min(ph, fh - fy)), :max(0, min(pw, fw - fx))]
    return out, (fx, fy, pw, ph)


def rim_weight(alpha, pts, box):
    x0, y0, w, h = box
    total = np.zeros(len(pts))
    for r in RADII:
        for dx, dy in DIRS:
            x = np.round(pts[:, 1] + dx * r).astype(int)
            y = np.round(pts[:, 0] + dy * r).astype(int)
            inside = (x >= x0) & (x < x0 + w) & (y >= y0) & (y < y0 + h)
            total += np.where(inside, alpha[np.clip(y, 0, alpha.shape[0] - 1), np.clip(x, 0, alpha.shape[1] - 1)], 0)
    return np.clip(1 - total / (len(RADII) * len(DIRS)), 0, 1)


def samples(char, recolor):
    fa = frames(os.path.join(HERE, char, f'{char}.xml'))
    png, xml = recolor_paths(recolor)
    fb = frames(xml)
    sa = load(os.path.join(HERE, char, f'{char}.png'))
    sb = load(png)
    names = sorted(set(fa) & set(fb))
    step = max(1, len(names) // 160)
    cs, ys, ws = [], [], []
    for name in names[::step]:
        a, box = frame_canvas(sa, fa[name])
        b, _ = frame_canvas(sb, fb[name])
        if a.shape != b.shape:
            continue
        m = (a[..., 3] > 0.9) & (b[..., 3] > 0.9)
        pts = np.argwhere(m)[::5]
        if len(pts) == 0:
            continue
        ws.append(rim_weight(a[..., 3], pts, box))
        cs.append(a[pts[:, 0], pts[:, 1], :3])
        ys.append(b[pts[:, 0], pts[:, 1], :3])
    return np.concatenate(cs), np.concatenate(ys), np.concatenate(ws)


def tri(colors):
    x = colors * (N - 1)
    i0 = np.minimum(np.floor(x).astype(int), N - 2)
    f = x - i0
    cols, vals = [], []
    for dr in (0, 1):
        for dg in (0, 1):
            for db in (0, 1):
                w = (f[:, 0] if dr else 1 - f[:, 0]) * (f[:, 1] if dg else 1 - f[:, 1]) * (f[:, 2] if db else 1 - f[:, 2])
                cols.append(((i0[:, 0] + dr) * N + (i0[:, 1] + dg)) * N + (i0[:, 2] + db))
                vals.append(w)
    return np.stack(cols, 1), np.stack(vals, 1)


def laplacian():
    idx = np.arange(N ** 3).reshape(N, N, N)
    a, b = [], []
    for axis in range(3):
        a.append(np.take(idx, range(N - 1), axis=axis).ravel())
        b.append(np.take(idx, range(1, N), axis=axis).ravel())
    a = np.concatenate(a)
    b = np.concatenate(b)
    d = sparse.csr_matrix((np.r_[np.ones(len(a)), -np.ones(len(a))], (np.r_[np.arange(len(a)), np.arange(len(a))], np.r_[a, b])), shape=(len(a), N ** 3))
    return d.T @ d


def solve(c, y, w):
    cols, vals = tri(c)
    n = len(c)
    rows = np.repeat(np.arange(n), 8)
    inner = sparse.csr_matrix(((vals * (1 - w)[:, None]).ravel(), (rows, cols.ravel())), shape=(n, N ** 3))
    rim = sparse.csr_matrix(((vals * w[:, None]).ravel(), (rows, cols.ravel())), shape=(n, N ** 3))
    M = sparse.hstack([inner, rim]).tocsr()
    L = laplacian()
    lam = 0.05 * n / N ** 3
    H = (M.T @ M + lam * sparse.block_diag([L, L * 0.3])).tocsr()
    sol = np.zeros((2 * N ** 3, 3))
    for ch in range(3):
        sol[:, ch], _ = cg(H, M.T @ y[:, ch], x0=np.full(2 * N ** 3, y[:, ch].mean()), rtol=1e-6, maxiter=2000)
    return np.clip(sol[:N ** 3], 0, 1).reshape(N, N, N, 3), np.clip(sol[N ** 3:], 0, 1).reshape(N, N, N, 3), M @ sol


def spread(cube):
    x = np.linspace(0, N - 1, 64)
    i0 = np.minimum(np.floor(x).astype(int), N - 2)
    f = x - i0
    out = cube
    for axis in range(3):
        a = np.take(out, i0, axis=axis)
        b = np.take(out, i0 + 1, axis=axis)
        shape = [1, 1, 1, 1]
        shape[axis] = 64
        out = a * (1 - f).reshape(shape) + b * f.reshape(shape)
    return out


def pack(cube):
    img = np.zeros((512, 512, 3), dtype=np.uint8)
    for b in range(64):
        tx, ty = (b % 8) * 64, (b // 8) * 64
        img[ty:ty + 64, tx:tx + 64] = np.round(cube[:, :, b].transpose(1, 0, 2) * 255).astype(np.uint8)
    return img


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('looks', nargs='*', default=ALL_LOOKS, help='which looks to build (default: all)')
    parser.add_argument('--recolors', help='folder with recolored sheets')
    parser.add_argument('--character', action='append', help='only build these characters (default: all)')
    args = parser.parse_args()

    global RECOLORS
    RECOLORS = args.recolors

    os.makedirs(LOOKS, exist_ok=True)
    for char, looks in CHARACTERS.items():
        if args.character and char not in args.character:
            continue
        for look in args.looks:
            recolor = looks.get(look)
            if recolor is None:
                continue
            if recolor_paths(recolor) is None:
                print(f'skipping {char} {look}, no {recolor} sheet')
                continue

            c, y, raw = samples(char, recolor)

            best, best_err = GAINS[0], None
            for gain in GAINS:
                w = np.sqrt(np.clip(raw[::3] * gain, 0, 1))
                _, _, pred = solve(c[::3], y[::3], w)
                err = np.sqrt(((pred - y[::3]) ** 2).mean())
                if best_err is None or err < best_err:
                    best, best_err = gain, err

            cube_in, cube_rim, pred = solve(c, y, np.sqrt(np.clip(raw * best, 0, 1)))
            e = np.abs(pred - y) * 255
            print(f'{char} {look}: gain {best} (set it in CHARACTER_GAIN), off by {np.sqrt((e ** 2).mean()):.1f} / 255 on average, {(e.max(1) > 40).mean() * 100:.1f}% more than 40 off', flush=True)


            Image.fromarray(pack(spread(cube_in))).save(os.path.join(LOOKS, f'{char}-{look}-inner.png'), optimize=True)
            Image.fromarray(pack(spread(cube_rim))).save(os.path.join(LOOKS, f'{char}-{look}-rim.png'), optimize=True)


if __name__ == '__main__':
    main()

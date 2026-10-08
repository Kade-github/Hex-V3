param(
    [string]$Out = '..\..\desktop-build',
    [double]$MinMb = 4,
    [double]$AudioQuality = 5,
    [switch]$KeepAudio,
    [switch]$Zip
)

$ErrorActionPreference = 'Stop'

$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$mods = Split-Path -Parent $here

$maker = Join-Path $here 'make-dds.py'
if (-not (Test-Path $maker)) {
    Write-Error "no make-dds.py at $maker"
}

$skipDirs = @('.git', 'cppia-src', 'cppia-charts', 'concept-or-unused')
$skipFiles = @('build.ps1', 'build-mobile.ps1', 'build-desktop.ps1', 'make-dds.py', 'build.log', '.gitignore')

$compress = @('hex')
$copy = @('hex', 'modchart-engine')

$stage = Join-Path $Out 'mods'
$cache = Join-Path $Out '.dds-cache'
$audioCache = Join-Path $Out '.ogg-cache'

if (Test-Path $stage) { Remove-Item -Recurse -Force $stage }
New-Item -ItemType Directory -Force $stage | Out-Null
New-Item -ItemType Directory -Force $cache | Out-Null
New-Item -ItemType Directory -Force $audioCache | Out-Null

$copied = 0
$oggMade = 0
$oggSmaller = 0
$oggBefore = 0
$oggAfter = 0

foreach ($mod in $copy) {
    $root = Join-Path $mods $mod
    $files = Get-ChildItem -Path $root -Recurse -File -Force

    foreach ($file in $files) {
        $rel = $file.FullName.Substring($root.Length + 1).Replace('\', '/')
        $parts = $rel.Split('/')

        $skip = $false
        foreach ($part in $parts) {
            if ($skipDirs -contains $part) { $skip = $true }
        }
        if ($skip -or ($parts.Length -eq 1 -and $skipFiles -contains $parts[0])) { continue }

        if ($file.Extension -ieq '.dds') { continue }

        $target = Join-Path (Join-Path $stage $mod) $rel
        New-Item -ItemType Directory -Force (Split-Path -Parent $target) | Out-Null

        if ($file.Extension -ieq '.ogg' -and -not $KeepAudio) {
            $cached = Join-Path (Join-Path $audioCache $mod) $rel
            $stampFile = "$cached.stamp"
            $stamp = "$($file.Length)|$($file.LastWriteTimeUtc.Ticks)|$AudioQuality"

            $fresh = (Test-Path $cached) -and (Test-Path $stampFile) -and ((Get-Content $stampFile -Raw).Trim() -eq $stamp)
            if (-not $fresh) {
                New-Item -ItemType Directory -Force (Split-Path -Parent $cached) | Out-Null
                & ffmpeg -v error -y -i $file.FullName -map 0:a:0 -map_metadata 0 -c:a libvorbis -q:a $AudioQuality $cached
                if ($LASTEXITCODE -ne 0 -or -not (Test-Path $cached)) {
                    Write-Error "ffmpeg failed on $mod/$rel"
                }
                [System.IO.File]::WriteAllText($stampFile, $stamp)
                $oggMade++
            }

            $oggBefore += $file.Length
            $smaller = (Get-Item $cached).Length
            if ($smaller -lt $file.Length * 0.9) {
                Copy-Item $cached $target -Force
                $oggSmaller++
                $oggAfter += $smaller
            }
            else {
                Copy-Item $file.FullName $target -Force
                $oggAfter += $file.Length
            }
            $copied++
            continue
        }

        Copy-Item $file.FullName $target -Force
        $copied++
    }
}

$ddsCount = 0
$ddsBytes = 0
$pngBytes = 0

foreach ($mod in $compress) {
    $root = Join-Path $mods $mod
    $made = Join-Path $cache $mod

    & python $maker --root $root --out $made --min-mb $MinMb
    if ($LASTEXITCODE -ne 0) { Write-Error "make-dds failed on $mod" }

    if (-not (Test-Path $made)) { continue }

    foreach ($file in (Get-ChildItem -Path $made -Recurse -File -Filter '*.dds')) {
        $rel = $file.FullName.Substring((Resolve-Path $made).Path.Length + 1)
        $source = Join-Path $root ([System.IO.Path]::ChangeExtension($rel, 'png'))

        if (-not (Test-Path $source)) { continue }

        $target = Join-Path (Join-Path $stage $mod) $rel
        $stagedPng = [System.IO.Path]::ChangeExtension($target, 'png')
        if (-not (Test-Path $stagedPng)) { continue }

        Copy-Item $file.FullName $target -Force
        $pngBytes += (Get-Item $stagedPng).Length
        Remove-Item -Force $stagedPng
        $ddsCount++
        $ddsBytes += $file.Length
    }
}

Write-Host ("Copied {0} files. {1} png ({2:N1} MB) were replaced by dds ({3:N1} MB)." -f $copied, $ddsCount, ($pngBytes / 1MB), ($ddsBytes / 1MB))
if (-not $KeepAudio) {
    Write-Host ("Audio: {0} of the ogg files were re-encoded smaller at quality {1} ({2} encoded this run). {3:N1} MB became {4:N1} MB." -f $oggSmaller, $AudioQuality, $oggMade, ($oggBefore / 1MB), ($oggAfter / 1MB))
}
Write-Host "Staged $stage"

if ($Zip) {
    $zipPath = Join-Path $Out 'HexDesktop.zip'
    if (Test-Path $zipPath) { Remove-Item -Force $zipPath }
    & (Join-Path $env:SystemRoot 'System32\tar.exe') -a -c -f $zipPath -C $Out mods
    if ($LASTEXITCODE -ne 0) { Write-Error 'zip failed' }
    Write-Host "Wrote $zipPath"
}

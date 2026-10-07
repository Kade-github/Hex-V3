param(
    [string]$Out = '..\..\mobile-build',
    [string]$BlockSize = '8x8',
    [string]$Quality = 'medium',
    [switch]$Zip
)

$ErrorActionPreference = 'Stop'

$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$mods = Split-Path -Parent $here

$GameRoot = 'F:\Funkin2\Funkin-secret' # this is my game root, but put in yours

$encoder = Join-Path $GameRoot '.haxelib\astc-compressor\git\plugins\Windows\x64\astcenc-sse2.exe'
if (-not (Test-Path $encoder)) {
    Write-Error "no astcenc at $encoder"
}

$skipDirs = @('.git', 'cppia-src', 'cppia-charts', 'concept-or-unused')
$skipFiles = @('build.ps1', 'build-mobile.ps1', 'build.log', '.gitignore')

$compress = @('hex')
$copy = @('hex', 'modchart-engine')

$keepPng = @(
    'gameplay/looks/',
    'gameplay/notestyles/',
    'gameplay/songs/',
    'ui/fonts/',
    '_polymod_icon.png'
)

function Test-KeepPng([string]$rel) {
    if ((Split-Path -Leaf $rel) -like 'icon-*.png') { return $true }
    foreach ($keep in $keepPng) {
        if ($keep.EndsWith('/')) {
            if ($rel.StartsWith($keep)) { return $true }
        }
        elseif ($rel -eq $keep) { return $true }
    }
    return $false
}

$stage = Join-Path $Out 'mods'
$cache = Join-Path $Out '.astc-cache'

if (Test-Path $stage) { Remove-Item -Recurse -Force $stage }
New-Item -ItemType Directory -Force $stage | Out-Null
New-Item -ItemType Directory -Force $cache | Out-Null

$made = 0
$reused = 0
$kept = 0
$pngBytes = 0
$astcBytes = 0

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

        $target = Join-Path (Join-Path $stage $mod) $rel
        New-Item -ItemType Directory -Force (Split-Path -Parent $target) | Out-Null

        $isPng = $file.Extension -ieq '.png'
        if (-not $isPng -or $compress -notcontains $mod -or (Test-KeepPng $rel)) {
            Copy-Item $file.FullName $target -Force
            if ($isPng) { $kept++ }
            continue
        }

        $cached = Join-Path (Join-Path $cache $mod) ([System.IO.Path]::ChangeExtension($rel, 'astc'))
        $stampFile = "$cached.stamp"
        $stamp = "$($file.Length)|$($file.LastWriteTimeUtc.Ticks)|$BlockSize|$Quality"

        $fresh = (Test-Path $cached) -and (Test-Path $stampFile) -and ((Get-Content $stampFile -Raw).Trim() -eq $stamp)
        if (-not $fresh) {
            New-Item -ItemType Directory -Force (Split-Path -Parent $cached) | Out-Null
            & $encoder -cl $file.FullName $cached $BlockSize "-$Quality" -silent
            if ($LASTEXITCODE -ne 0 -or -not (Test-Path $cached)) {
                Write-Error "astcenc failed on $mod/$rel"
            }
            [System.IO.File]::WriteAllText($stampFile, $stamp)
            $made++
            Write-Host "astc $mod/$rel"
        }
        else {
            $reused++
        }

        Copy-Item $cached ([System.IO.Path]::ChangeExtension($target, 'astc')) -Force
        $pngBytes += $file.Length
        $astcBytes += (Get-Item $cached).Length
    }
}

Write-Host ("Compressed {0}, reused {1}, kept {2} as png. {3:N1} MB of png became {4:N1} MB of astc." -f $made, $reused, $kept, ($pngBytes / 1MB), ($astcBytes / 1MB))
Write-Host "Staged $stage"

if ($Zip) {
    $zipPath = Join-Path $Out 'HexMobile.zip'
    if (Test-Path $zipPath) { Remove-Item -Force $zipPath }
    & (Join-Path $env:SystemRoot 'System32\tar.exe') -a -c -f $zipPath -C $Out mods
    if ($LASTEXITCODE -ne 0) { Write-Error 'zip failed' }
    Write-Host "Wrote $zipPath"
}

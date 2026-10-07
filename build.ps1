param(
    [string]$GameRoot
)

$ErrorActionPreference = 'Stop'

$here = Split-Path -Parent $MyInvocation.MyCommand.Path

$GameRoot = 'F:\Funkin2\Funkin-secret'

$builder = Join-Path $GameRoot 'scripts\cppia\build_cppia.ps1'
if (-not (Test-Path $builder)) {
    Write-Error "no root"
}

$sdk = Join-Path $GameRoot 'sdk\windows\release'
$staged = $null
if (Test-Path (Join-Path $sdk 'export_classes.info')) {
    $staged = Join-Path ([System.IO.Path]::GetTempPath()) 'hex-menus-sdk'
    New-Item -ItemType Directory -Force $staged | Out-Null
    Copy-Item (Join-Path $sdk 'cppia.hxml') (Join-Path $staged 'cppia.hxml') -Force

    $info = Get-Content (Join-Path $sdk 'export_classes.info')
    $have = @{}
    foreach ($line in $info) { $have[$line] = $true }
    $extra = @()
    foreach ($kind in @('JsonParser', 'JsonWriter')) {
        for ($n = 0; $n -lt 1024; $n++) {
            $line = "class $($kind)_$n"
            if (-not $have.ContainsKey($line)) { $extra += $line }
        }
    }
    $utf8 = New-Object System.Text.UTF8Encoding($false)
    [System.IO.File]::WriteAllText((Join-Path $staged 'export_classes.info'), (($info + $extra) -join "`n") + "`n", $utf8)
}

$argv = @()
if ($staged) { $argv += @('--sdk', $staged) }
$argv += @($GameRoot, (Join-Path $here 'cppia-src'), (Join-Path $here 'ui\scripts\menus\HexMenus.cppia'))

& $builder @argv

# ─────────────────────────────────────────────────────────────────────────────
# Khmer Lunar Calendar – Windows build + Inno Setup installer (one command)
# Run from the project root:
#   .\installer\windows\build_windows_installer.ps1
# ─────────────────────────────────────────────────────────────────────────────
$ErrorActionPreference = "Stop"

$ISCC_PATHS = @(
  "$env:LOCALAPPDATA\Programs\Inno Setup 6\ISCC.exe",
  "C:\Program Files (x86)\Inno Setup 6\ISCC.exe",
  "C:\Program Files\Inno Setup 6\ISCC.exe"
)

Write-Host "══════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "  Khmer Lunar Calendar – Windows Installer" -ForegroundColor Cyan
Write-Host "══════════════════════════════════════════════" -ForegroundColor Cyan

# ── 1. Find ISCC ─────────────────────────────────────────────────────────────
$ISCC = $null
foreach ($p in $ISCC_PATHS) {
  if (Test-Path $p) { $ISCC = $p; break }
}
if (-not $ISCC) {
  Write-Host "✗  Inno Setup not found. Install from: https://jrsoftware.org/isdl.php" -ForegroundColor Red
  exit 1
}
Write-Host "✓  Found Inno Setup: $ISCC" -ForegroundColor Green

# ── 2. Flutter build ─────────────────────────────────────────────────────────
Write-Host ""
Write-Host "▶  flutter clean..." -ForegroundColor Yellow
flutter clean

Write-Host "▶  flutter pub get..." -ForegroundColor Yellow
flutter pub get

Write-Host "▶  flutter build windows..." -ForegroundColor Yellow
flutter build windows

$EXE = "build\windows\x64\runner\Release\khmer_lunar_app.exe"
if (-not (Test-Path $EXE)) {
  Write-Host "✗  Build failed – exe not found at: $EXE" -ForegroundColor Red
  exit 1
}
Write-Host "✓  Build complete" -ForegroundColor Green

# ── 3. Compile installer ─────────────────────────────────────────────────────
Write-Host ""
Write-Host "▶  Compiling installer..." -ForegroundColor Yellow
New-Item -ItemType Directory -Force -Path "dist\windows" | Out-Null

& $ISCC "installer\windows\khmer_lunar_setup.iss"
if ($LASTEXITCODE -ne 0) {
  Write-Host "✗  Inno Setup compilation failed" -ForegroundColor Red
  exit 1
}

# ── 4. Report ─────────────────────────────────────────────────────────────────
$Installer = Get-Item "dist\windows\KhmerLunarCalendar-1.0.0-Setup.exe"
$SizeMB    = [math]::Round($Installer.Length / 1MB, 2)

Write-Host ""
Write-Host "══════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "  ✓  Done! Installer ready:" -ForegroundColor Green
Write-Host "     $($Installer.FullName)" -ForegroundColor White
Write-Host "     Size: ${SizeMB} MB" -ForegroundColor White
Write-Host "══════════════════════════════════════════════" -ForegroundColor Cyan

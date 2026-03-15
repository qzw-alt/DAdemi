# CLI-Anything Test Script (Simplified)
Write-Host "CLI-Anything Environment Test" -ForegroundColor Cyan
Write-Host "==============================" -ForegroundColor Cyan

# Test PowerShell
Write-Host "`n[Test 1] PowerShell: OK" -ForegroundColor Green

# Test Git
try {
    $git = Get-Command git -ErrorAction Stop
    Write-Host "[Test 2] Git: OK - $($git.Source)" -ForegroundColor Green
} catch {
    Write-Host "[Test 2] Git: NOT FOUND" -ForegroundColor Yellow
}

# Test FFmpeg
try {
    $ffmpeg = Get-Command ffmpeg -ErrorAction Stop
    Write-Host "[Test 3] FFmpeg: OK - Video processing ready" -ForegroundColor Green
} catch {
    Write-Host "[Test 3] FFmpeg: NOT FOUND (Install: winget install Gyan.FFmpeg)" -ForegroundColor Yellow
}

# Test Python
try {
    $python = Get-Command python -ErrorAction Stop
    $ver = python --version 2>&1
    Write-Host "[Test 4] Python: OK - $ver" -ForegroundColor Green
} catch {
    Write-Host "[Test 4] Python: NOT FOUND" -ForegroundColor Yellow
}

# Test Workspace
$ws = "C:\Users\$env:USERNAME\.openclaw\workspace"
if (Test-Path $ws) {
    Write-Host "[Test 5] Workspace: OK - $ws" -ForegroundColor Green
} else {
    Write-Host "[Test 5] Workspace: NOT FOUND" -ForegroundColor Red
}

Write-Host "`n==============================" -ForegroundColor Cyan
Write-Host "Test complete!" -ForegroundColor Green

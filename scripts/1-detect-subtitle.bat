@echo off
echo ============================================
echo Video Subtitle Remover - Detection
echo ============================================
echo.

if "%~1"=="" (
    echo Usage: Drag video file onto this batch file
echo.
    pause
    exit /b 1
)

echo File: %~1
echo.
echo Detecting subtitles...
echo.

C:\ffmpeg\bin\ffmpeg.exe -i "%~1" 2>&1 | findstr "Subtitle"

if %errorlevel% equ 0 (
    echo.
    echo [OK] Soft subtitle track found!
    echo Use "2-remove-soft-subtitle.bat" to remove it
echo.
) else (
    echo.
    echo [Warning] No soft subtitle track found
echo It may be hardcoded subtitle
echo Use "3-blur-subtitle.bat" or "4-crop-subtitle.bat"
echo.
)

pause

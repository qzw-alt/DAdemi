@echo off
echo ============================================
echo Remove Soft Subtitle
echo ============================================
echo.

if "%~1"=="" (
    echo Usage: Drag video file onto this batch file
echo.
    pause
    exit /b 1
)

set "input=%~1"
set "output=%~dpn1_no-subtitle%~x1"

echo Input: %input%
echo Output: %output%
echo.
echo Processing...

C:\ffmpeg\bin\ffmpeg.exe -i "%input%" -map 0:v:0 -map 0:a:0 -c:v copy -c:a copy -sn -y "%output%"

if exist "%output%" (
    echo.
    echo [OK] Done!
    echo Output: %output%
) else (
    echo.
    echo [Error] Failed
)

echo.
pause

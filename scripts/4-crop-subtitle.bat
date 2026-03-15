@echo off
echo ============================================
echo Crop Subtitle Area
echo ============================================
echo.
echo This will crop bottom 20%% and resize back
echo.

if "%~1"=="" (
    echo Usage: Drag video file onto this batch file
echo.
    pause
    exit /b 1
)

set "input=%~1"
set "output=%~dpn1_cropped%~x1"

echo Input: %input%
echo Output: %output%
echo.
echo Processing...
echo.

C:\ffmpeg\bin\ffmpeg.exe -i "%input%" -vf "crop=iw:ih*0.8:0:0,scale=iw:ih" -c:a copy -y "%output%"

if exist "%output%" (
    echo.
    echo [OK] Done!
    echo Output: %output%
    echo.
    echo Note: Aspect ratio may change slightly
) else (
    echo.
    echo [Error] Failed
)

echo.
pause

@echo off
echo ============================================
echo Blur Subtitle Area
echo ============================================
echo.
echo This will blur bottom 20%% area of video
echo.

if "%~1"=="" (
    echo Usage: Drag video file onto this batch file
echo.
    pause
    exit /b 1
)

set "input=%~1"
set "output=%~dpn1_blurred%~x1"

echo Input: %input%
echo Output: %output%
echo.
echo Processing... This may take a few minutes
echo.

C:\ffmpeg\bin\ffmpeg.exe -i "%input%" -vf "split[original][toBlur];[toBlur]crop=iw:ih*0.22:0:ih*0.78,boxblur=lr=15:lp=5[blurred];[original][blurred]overlay=0:H-h*0.22" -c:a copy -y "%output%"

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

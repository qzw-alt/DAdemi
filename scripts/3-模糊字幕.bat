@echo off
chcp 65001 > nul
title 视频去字幕工具 - 模糊字幕

if "%~1"=="" (
    echo 用法: 将视频文件拖拽到此批处理文件上
    echo.
    pause
    exit /b 1
)

echo.
echo ===========================================
echo    模糊底部字幕区域
echo ===========================================
echo.
echo ⚠️  此操作将模糊视频底部20%%区域
echo.

set "input=%~1"
set "output=%~dpn1_blurred%~x1"

echo 输入: %input%
echo 输出: %output%
echo.
echo 正在处理（可能需要几分钟）...

C:\ffmpeg\bin\ffmpeg.exe -i "%input%" -vf "split[original][toBlur];[toBlur]crop=iw:ih*0.22:0:ih*0.78,boxblur=lr=15:lp=5[blurred];[original][blurred]overlay=0:H-h*0.22" -c:a copy -y "%output%" 2>nul

if exist "%output%" (
    echo.
    echo ✅ 完成！
    echo    输出文件: %output%
) else (
    echo.
    echo ❌ 处理失败
)

echo.
pause

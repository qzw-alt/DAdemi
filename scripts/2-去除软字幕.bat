@echo off
chcp 65001 > nul
title 视频去字幕工具 - 去除软字幕

if "%~1"=="" (
    echo 用法: 将视频文件拖拽到此批处理文件上
    echo.
    pause
    exit /b 1
)

echo.
echo ===========================================
echo    去除软字幕
echo ===========================================
echo.

set "input=%~1"
set "output=%~dpn1_no-subtitle%~x1"

echo 输入: %input%
echo 输出: %output%
echo.
echo 正在处理...

C:\ffmpeg\bin\ffmpeg.exe -i "%input%" -map 0:v:0 -map 0:a:0 -c:v copy -c:a copy -sn -y "%output%" 2>nul

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

@echo off
chcp 65001 > nul
title 视频去字幕工具 - 检测

if "%~1"=="" (
    echo 用法: 将视频文件拖拽到此批处理文件上
    echo.
    pause
    exit /b 1
)

echo.
echo ===========================================
echo    视频字幕检测
echo ===========================================
echo.
echo 文件: %~1
echo.

C:\ffmpeg\bin\ffmpeg.exe -i "%~1" 2>&1 | findstr "Stream.*Subtitle"

if %errorlevel% equ 0 (
    echo.
    echo ✅ 发现软字幕轨道！
    echo    可使用 "去除软字幕.bat" 去除
) else (
    echo.
    echo ⚠️  未发现软字幕轨道
    echo    可能是硬字幕（烧录进画面）
    echo    可使用 "模糊字幕.bat" 或 "裁剪字幕.bat" 处理
)

echo.
pause

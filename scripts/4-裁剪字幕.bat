@echo off
chcp 65001 > nul
title 视频去字幕工具 - 裁剪字幕

if "%~1"=="" (
    echo 用法: 将视频文件拖拽到此批处理文件上
    echo.
    pause
    exit /b 1
)

echo.
echo ===========================================
echo    裁剪字幕区域
echo ===========================================
echo.
echo ⚠️  此操作将裁剪视频底部20%%区域
echo    然后缩放回原尺寸
echo.

set "input=%~1"
set "output=%~dpn1_cropped%~x1"

echo 输入: %input%
echo 输出: %output%
echo.
echo 正在处理...

C:\ffmpeg\bin\ffmpeg.exe -i "%input%" -vf "crop=iw:ih*0.8:0:0,scale=iw:ih" -c:a copy -y "%output%" 2>nul

if exist "%output%" (
    echo.
    echo ✅ 完成！
    echo    输出文件: %output%
    echo.
    echo ⚠️  注意: 画面比例可能略有变化
) else (
    echo.
    echo ❌ 处理失败
)

echo.
pause

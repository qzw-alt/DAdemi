@echo off
chcp 65001 > nul
echo.
echo ===========================================
echo    CLI-Anything 功能演示（Windows版）
echo ===========================================
echo.
echo 这个演示展示了 CLI-Anything 如何控制本地软件
echo.

REM 检查 FFmpeg
where ffmpeg > nul 2>&1
if %errorlevel% neq 0 (
    echo [状态] FFmpeg: 未安装
    echo.
    echo 安装方法:
    echo   方法1: winget install Gyan.FFmpeg
    echo   方法2: 手动下载 https://ffmpeg.org/download.html
    echo   方法3: 解压到 C:\ffmpeg 并添加到 PATH
    echo.
    echo 安装后重新运行此脚本
    pause
    exit /b 1
)

echo [状态] FFmpeg: 已安装 ✓
ffmpeg -version 2>&1 | findstr "ffmpeg version" | head -1
echo.

REM 创建测试目录
set TESTDIR=%USERPROFILE%\.openclaw\workspace\video-demo
if not exist "%TESTDIR%" mkdir "%TESTDIR%"

echo [步骤1] 生成测试视频...
ffmpeg -f lavfi -i testsrc=duration=5:size=640x360:rate=30 -pix_fmt yuv420p -y "%TESTDIR%\test-video.mp4" 2> nul
if exist "%TESTDIR%\test-video.mp4" (
    echo ✓ 测试视频已生成: %TESTDIR%\test-video.mp4
) else (
    echo ✗ 生成失败
)
echo.

echo [步骤2] 提取缩略图...
ffmpeg -ss 00:00:02 -i "%TESTDIR%\test-video.mp4" -vframes 1 -q:v 2 -y "%TESTDIR%\thumbnail.jpg" 2> nul
if exist "%TESTDIR%\thumbnail.jpg" (
    echo ✓ 缩略图已生成: %TESTDIR%\thumbnail.jpg
) else (
    echo ✗ 生成失败
)
echo.

echo [步骤3] 转码为480p...
ffmpeg -i "%TESTDIR%\test-video.mp4" -vf "scale=854:480" -c:v libx264 -preset fast -crf 23 -c:a aac -b:a 128k -y "%TESTDIR%\video-480p.mp4" 2> nul
if exist "%TESTDIR%\video-480p.mp4" (
    echo ✓ 480p版本已生成: %TESTDIR%\video-480p.mp4
) else (
    echo ✗ 生成失败
)
echo.

echo [步骤4] 生成GIF...
ffmpeg -i "%TESTDIR%\test-video.mp4" -vf "fps=10,scale=320:-1:flags=lanczos" -loop 0 -y "%TESTDIR%\animation.gif" 2> nul
if exist "%TESTDIR%\animation.gif" (
    echo ✓ GIF已生成: %TESTDIR%\animation.gif
) else (
    echo ✗ 生成失败
)
echo.

echo ===========================================
echo 演示完成！
echo ===========================================
echo.
echo 生成的文件:
dir "%TESTDIR%" /b
echo.
echo CLI-Anything 可以自动化以上所有操作！
echo.
pause

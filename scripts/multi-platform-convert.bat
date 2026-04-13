@echo off
chcp 65001 > nul
echo.
echo ===========================================
echo    多平台视频分发 - 一键转码工具
echo ===========================================
echo.

set SOURCE_VIDEO=%1
if "%SOURCE_VIDEO%"=="" (
    echo 用法: multi-platform-convert.bat "视频文件路径"
    echo 例如: multi-platform-convert.bat "C:\Videos\my-video.mp4"
    pause
    exit /b 1
)

if not exist "%SOURCE_VIDEO%" (
    echo 错误: 找不到视频文件 %SOURCE_VIDEO%
    pause
    exit /b 1
)

set PROJECT_DIR=C:\Users\%USERNAME%\Videos\Multi-Platform-Distribution
set PLATFORMS_DIR=%PROJECT_DIR%\02-Platforms
set THUMBS_DIR=%PROJECT_DIR%\03-Thumbnails

REM 提取文件名（不含扩展名）
for %%F in ("%SOURCE_VIDEO%") do set FILENAME=%%~nF

echo 源视频: %SOURCE_VIDEO%
echo 文件名: %FILENAME%
echo.

REM 创建目录
echo [步骤1/7] 创建项目目录...
mkdir "%PLATFORMS_DIR%\TikTok" 2>nul
mkdir "%PLATFORMS_DIR%\Instagram-Reels" 2>nul
mkdir "%PLATFORMS_DIR%\Instagram-Feed" 2>nul
mkdir "%PLATFORMS_DIR%\Facebook" 2>nul
mkdir "%PLATFORMS_DIR%\Twitter" 2>nul
mkdir "%THUMBS_DIR%\TikTok" 2>nul
mkdir "%THUMBS_DIR%\Instagram-Reels" 2>nul
mkdir "%THUMBS_DIR%\Instagram-Feed" 2>nul
mkdir "%THUMBS_DIR%\Facebook" 2>nul
mkdir "%THUMBS_DIR%\Twitter" 2>nul
echo 完成
echo.

REM 1. TikTok (9:16)
echo [步骤2/7] 生成 TikTok 版本 (9:16 竖屏)...
C:\ffmpeg\bin\ffmpeg.exe -i "%SOURCE_VIDEO%" -vf "scale=1080:1920:force_original_aspect_ratio=increase,crop=1080:1920:(in_w-1080)/2:(in_h-1920)/2,setsar=1" -c:v libx264 -preset fast -crf 23 -c:a aac -b:a 128k -r 30 -y "%PLATFORMS_DIR%\TikTok\%FILENAME%_TikTok.mp4" 2>nul
if exist "%PLATFORMS_DIR%\TikTok\%FILENAME%_TikTok.mp4" (
    echo ✅ TikTok 版本完成
) else (
    echo ❌ TikTok 版本失败
)
echo.

REM 2. Instagram Reels (9:16)
echo [步骤3/7] 生成 Instagram Reels 版本 (9:16 竖屏)...
C:\ffmpeg\bin\ffmpeg.exe -i "%SOURCE_VIDEO%" -vf "scale=1080:1920:force_original_aspect_ratio=increase,crop=1080:1920:(in_w-1080)/2:(in_h-1920)/2,setsar=1" -c:v libx264 -preset fast -crf 23 -c:a aac -b:a 128k -r 30 -y "%PLATFORMS_DIR%\Instagram-Reels\%FILENAME%_Reels.mp4" 2>nul
if exist "%PLATFORMS_DIR%\Instagram-Reels\%FILENAME%_Reels.mp4" (
    echo ✅ Instagram Reels 版本完成
) else (
    echo ❌ Instagram Reels 版本失败
)
echo.

REM 3. Instagram Feed (4:5)
echo [步骤4/7] 生成 Instagram Feed 版本 (4:5 竖屏)...
C:\ffmpeg\bin\ffmpeg.exe -i "%SOURCE_VIDEO%" -vf "scale=1080:1350:force_original_aspect_ratio=increase,crop=1080:1350:(in_w-1080)/2:(in_h-1350)/2,setsar=1" -c:v libx264 -preset fast -crf 23 -c:a aac -b:a 128k -r 30 -y "%PLATFORMS_DIR%\Instagram-Feed\%FILENAME%_Feed.mp4" 2>nul
if exist "%PLATFORMS_DIR%\Instagram-Feed\%FILENAME%_Feed.mp4" (
    echo ✅ Instagram Feed 版本完成
) else (
    echo ❌ Instagram Feed 版本失败
)
echo.

REM 4. Facebook (16:9)
echo [步骤5/7] 生成 Facebook 版本 (16:9 横屏)...
C:\ffmpeg\bin\ffmpeg.exe -i "%SOURCE_VIDEO%" -vf "scale=1280:720:force_original_aspect_ratio=decrease,pad=1280:720:(ow-iw)/2:(oh-ih)/2,setsar=1" -c:v libx264 -preset fast -crf 23 -c:a aac -b:a 128k -r 30 -y "%PLATFORMS_DIR%\Facebook\%FILENAME%_Facebook.mp4" 2>nul
if exist "%PLATFORMS_DIR%\Facebook\%FILENAME%_Facebook.mp4" (
    echo ✅ Facebook 版本完成
) else (
    echo ❌ Facebook 版本失败
)
echo.

REM 5. Twitter/X (16:9)
echo [步骤6/7] 生成 Twitter/X 版本 (16:9 横屏)...
C:\ffmpeg\bin\ffmpeg.exe -i "%SOURCE_VIDEO%" -vf "scale=1280:720:force_original_aspect_ratio=decrease,pad=1280:720:(ow-iw)/2:(oh-ih)/2,setsar=1" -c:v libx264 -preset fast -crf 23 -c:a aac -b:a 128k -r 30 -y "%PLATFORMS_DIR%\Twitter\%FILENAME%_Twitter.mp4" 2>nul
if exist "%PLATFORMS_DIR%\Twitter\%FILENAME%_Twitter.mp4" (
    echo ✅ Twitter/X 版本完成
) else (
    echo ❌ Twitter/X 版本失败
)
echo.

REM 6. 生成封面
echo [步骤7/7] 生成各平台封面...
C:\ffmpeg\bin\ffmpeg.exe -i "%SOURCE_VIDEO%" -ss 00:00:03 -vframes 1 -vf "scale=1080:1920:force_original_aspect_ratio=increase,crop=1080:1920,setsar=1" -y "%THUMBS_DIR%\TikTok\%FILENAME%_TikTok.jpg" 2>nul
C:\ffmpeg\bin\ffmpeg.exe -i "%SOURCE_VIDEO%" -ss 00:00:03 -vframes 1 -vf "scale=1080:1920:force_original_aspect_ratio=increase,crop=1080:1920,setsar=1" -y "%THUMBS_DIR%\Instagram-Reels\%FILENAME%_Reels.jpg" 2>nul
C:\ffmpeg\bin\ffmpeg.exe -i "%SOURCE_VIDEO%" -ss 00:00:03 -vframes 1 -vf "scale=1080:1350:force_original_aspect_ratio=increase,crop=1080:1350,setsar=1" -y "%THUMBS_DIR%\Instagram-Feed\%FILENAME%_Feed.jpg" 2>nul
C:\ffmpeg\bin\ffmpeg.exe -i "%SOURCE_VIDEO%" -ss 00:00:03 -vframes 1 -vf "scale=1280:720:force_original_aspect_ratio=decrease,pad=1280:720:(ow-iw)/2:(oh-ih)/2,setsar=1" -y "%THUMBS_DIR%\Facebook\%FILENAME%_Facebook.jpg" 2>nul
C:\ffmpeg\bin\ffmpeg.exe -i "%SOURCE_VIDEO%" -ss 00:00:03 -vframes 1 -vf "scale=1280:720:force_original_aspect_ratio=decrease,pad=1280:720:(ow-iw)/2:(oh-ih)/2,setsar=1" -y "%THUMBS_DIR%\Twitter\%FILENAME%_Twitter.jpg" 2>nul
echo ✅ 封面生成完成
echo.

echo ===========================================
echo 多平台转码完成！
echo ===========================================
echo.
echo 📁 输出目录: %PLATFORMS_DIR%
echo.
echo 📱 生成的文件:
dir /s /b "%PLATFORMS_DIR%\*.mp4" | findstr /v "\."
echo.
echo 🖼️ 生成的封面:
dir /s /b "%THUMBS_DIR%\*.jpg" | findstr /v "\."
echo.
echo 📝 下一步:
echo   1. 检查各平台版本是否符合要求
echo   2. 上传到 TikTok / Instagram / Facebook / Twitter
echo   3. 根据平台调整标题和标签
echo.
pause

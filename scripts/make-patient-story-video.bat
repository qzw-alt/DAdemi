@echo off
echo ===========================================
echo    患者故事视频 - 自动化制作脚本
echo ===========================================
echo.

set PROJECT_DIR=C:\Users\%USERNAME%\Videos\Patient-Story-Michael
set RAW_DIR=%PROJECT_DIR%\01-Raw-Footage
set EDITED_DIR=%PROJECT_DIR%\02-Edited
set FINAL_DIR=%PROJECT_DIR%\04-Final

REM 检查素材目录
if not exist "%RAW_DIR%\*.mp4" (
    echo [错误] 没有找到素材文件！
    echo.
    echo 请先完成以下步骤：
    echo 1. 访问 https://www.pexels.com 或 https://pixabay.com
    echo 2. 搜索关键词：hospital patient, doctor consultation, medical
    echo 3. 下载 10-15 个视频片段
    echo 4. 放到文件夹：%RAW_DIR%
    echo.
    echo 详细指南见：video-production-plan-patient-story.md
    pause
    exit /b 1
)

echo [步骤1/5] 创建项目目录...
mkdir "%EDITED_DIR%" 2>nul
mkdir "%FINAL_DIR%" 2>nul
echo 完成
echo.

echo [步骤2/5] 批量转码素材为 1080p...
setlocal enabledelayedexpansion
set count=0
for %%F in ("%RAW_DIR%\*.mp4") do (
    set /a count+=1
    echo   处理 [!count!] %%~nF ...
    C:\ffmpeg\bin\ffmpeg.exe -i "%%F" -vf "scale=1920:1080:force_original_aspect_ratio=decrease,pad=1920:1080:(ow-iw)/2:(oh-ih)/2,setsar=1" -c:v libx264 -preset fast -crf 23 -c:a aac -b:a 128k -r 30 -y "%EDITED_DIR%\clip_!count!_%%~nF.mp4" 2>nul
)
echo 完成 - 处理了 %count% 个文件
echo.

echo [步骤3/5] 生成视频片段列表...
(echo # This is a comment) > "%PROJECT_DIR%\filelist.txt"
for %%F in ("%EDITED_DIR%\clip_*.mp4") do (
    echo file '%%F' >> "%PROJECT_DIR%\filelist.txt"
)
echo 完成
echo.

echo [步骤4/5] 合并所有片段...
C:\ffmpeg\bin\ffmpeg.exe -f concat -safe 0 -i "%PROJECT_DIR%\filelist.txt" -c copy -y "%FINAL_DIR%\patient-story-raw.mp4" 2>nul
if exist "%FINAL_DIR%\patient-story-raw.mp4" (
    echo 完成 - 已生成：%FINAL_DIR%\patient-story-raw.mp4
) else (
    echo 错误：合并失败
)
echo.

echo [步骤5/5] 生成 YouTube 封面缩略图...
C:\ffmpeg\bin\ffmpeg.exe -i "%FINAL_DIR%\patient-story-raw.mp4" -ss 00:00:03 -vframes 1 -vf "scale=1280:720" -y "%FINAL_DIR%\thumbnail-youtube.jpg" 2>nul
if exist "%FINAL_DIR%\thumbnail-youtube.jpg" (
    echo 完成 - 已生成：%FINAL_DIR%\thumbnail-youtube.jpg
)
echo.

echo ===========================================
echo 制作完成！
echo ===========================================
echo.
echo 输出文件：
echo   - %FINAL_DIR%\patient-story-raw.mp4
echo   - %FINAL_DIR%\thumbnail-youtube.jpg
echo.
echo 下一步：
echo   1. 用剪辑软件（剪映/PR）添加字幕和配音
echo   2. 添加背景音乐
echo   3. 导出最终版本
echo   4. 上传到 YouTube
echo.
pause

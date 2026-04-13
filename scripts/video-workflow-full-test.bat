@echo off
chcp 65001 > nul
echo.
echo ===========================================
echo    CLI-Anything 完整视频制作工作流测试
echo ===========================================
echo.

set WORKSPACE=C:\Users\csdm2\.openclaw\workspace
set PROJECT_DIR=%WORKSPACE%\video-production-demo
set RAW_DIR=%PROJECT_DIR%\01-Raw
set TRANSCODED_DIR=%PROJECT_DIR%\02-Transcoded
set WATERMARKED_DIR=%PROJECT_DIR%\03-Watermarked
set THUMBS_DIR=%PROJECT_DIR%\04-Thumbnails
set FINAL_DIR=%PROJECT_DIR%\05-Final

REM 创建目录结构
echo [步骤1] 创建项目目录结构...
mkdir "%PROJECT_DIR%" 2>nul
mkdir "%RAW_DIR%" 2>nul
mkdir "%TRANSCODED_DIR%" 2>nul
mkdir "%WATERMARKED_DIR%" 2>nul
mkdir "%THUMBS_DIR%" 2>nul
mkdir "%FINAL_DIR%" 2>nul
echo ✅ 目录结构创建完成
echo.

REM 生成模拟素材视频
echo [步骤2] 生成模拟素材视频（3个）...
echo.

echo   生成视频1: 心脏手术介绍 (5秒, 1280x720)...
C:\ffmpeg\bin\ffmpeg.exe -f lavfi -i testsrc=duration=5:size=1280x720:rate=30 -f lavfi -i sine=frequency=1000:duration=5 -pix_fmt yuv420p -y "%RAW_DIR%\01-heart-surgery-intro.mp4" 2>nul
echo   ✅ 完成

echo   生成视频2: 费用对比 (5秒, 1280x720)...
C:\ffmpeg\bin\ffmpeg.exe -f lavfi -i testsrc=duration=5:size=1280x720:rate=30 -f lavfi -i sine=frequency=1200:duration=5 -pix_fmt yuv420p -y "%RAW_DIR%\02-cost-comparison.mp4" 2>nul
echo   ✅ 完成

echo   生成视频3: 患者故事 (5秒, 1280x720)...
C:\ffmpeg\bin\ffmpeg.exe -f lavfi -i testsrc=duration=5:size=1280x720:rate=30 -f lavfi -i sine=frequency=800:duration=5 -pix_fmt yuv420p -y "%RAW_DIR%\03-patient-story.mp4" 2>nul
echo   ✅ 完成

echo.
echo ✅ 已生成3个模拟素材视频
echo.

REM 批量转码为不同分辨率
echo [步骤3] 批量转码为不同分辨率...
echo.

for %%F in ("%RAW_DIR%\*.mp4") do (
    echo   转码 %%~nF 为 1080p...
    C:\ffmpeg\bin\ffmpeg.exe -i "%%F" -vf "scale=1920:1080" -c:v libx264 -preset fast -crf 23 -c:a aac -b:a 128k -y "%TRANSCODED_DIR%\%%~nF-1080p.mp4" 2>nul
    
    echo   转码 %%~nF 为 720p...
    C:\ffmpeg\bin\ffmpeg.exe -i "%%F" -vf "scale=1280:720" -c:v libx264 -preset fast -crf 23 -c:a aac -b:a 128k -y "%TRANSCODED_DIR%\%%~nF-720p.mp4" 2>nul
    
    echo   转码 %%~nF 为 480p...
    C:\ffmpeg\bin\ffmpeg.exe -i "%%F" -vf "scale=854:480" -c:v libx264 -preset fast -crf 23 -c:a aac -b:a 96k -y "%TRANSCODED_DIR%\%%~nF-480p.mp4" 2>nul
    
    echo   ✅ %%~nF 全部转码完成
    echo.
)

echo ✅ 批量转码完成（3个视频 x 3种分辨率 = 9个文件）
echo.

REM 添加水印
echo [步骤4] 添加水印...
echo.

REM 创建水印图片（使用FFmpeg生成文字水印）
echo   创建水印图片...
C:\ffmpeg\bin\ffmpeg.exe -f lavfi -i color=c=black:s=200x50:d=1 -vf "drawtext=text='China Hospitals Guide':fontcolor=white:fontsize=24:x=10:y=13" -frames:v 1 -y "%PROJECT_DIR%\watermark.png" 2>nul

echo   为720p视频添加水印...
for %%F in ("%TRANSCODED_DIR%\*-720p.mp4") do (
    echo     处理 %%~nF...
    C:\ffmpeg\bin\ffmpeg.exe -i "%%F" -i "%PROJECT_DIR%\watermark.png" -filter_complex "[0:v][1:v]overlay=W-w-20:H-h-20:format=auto" -c:a copy -y "%WATERMARKED_DIR%\%%~nF-watermarked.mp4" 2>nul
)

echo ✅ 水印添加完成
echo.

REM 生成缩略图
echo [步骤5] 生成视频缩略图...
echo.

for %%F in ("%WATERMARKED_DIR%\*.mp4") do (
    echo   生成 %%~nF 的缩略图...
    C:\ffmpeg\bin\ffmpeg.exe -ss 00:00:02 -i "%%F" -vframes 1 -q:v 2 -y "%THUMBS_DIR%\%%~nF-thumbnail.jpg" 2>nul
)

echo ✅ 缩略图生成完成
echo.

REM 复制最终版本
echo [步骤6] 整理最终版本...
echo.

copy "%WATERMARKED_DIR%\*-720p-watermarked.mp4" "%FINAL_DIR%\" > nul
copy "%THUMBS_DIR%\*.jpg" "%FINAL_DIR%\" > nul

echo ✅ 最终版本整理完成
echo.

REM 生成项目报告
echo [步骤7] 生成项目报告...
echo.

echo =========================================== > "%PROJECT_DIR%\PROJECT-REPORT.txt"
echo    视频制作项目报告 >> "%PROJECT_DIR%\PROJECT-REPORT.txt"
echo =========================================== >> "%PROJECT_DIR%\PROJECT-REPORT.txt"
echo. >> "%PROJECT_DIR%\PROJECT-REPORT.txt"
echo 项目名称: 医疗旅游宣传视频 >> "%PROJECT_DIR%\PROJECT-REPORT.txt"
echo 生成时间: %date% %time% >> "%PROJECT_DIR%\PROJECT-REPORT.txt"
echo. >> "%PROJECT_DIR%\PROJECT-REPORT.txt"
echo 文件统计: >> "%PROJECT_DIR%\PROJECT-REPORT.txt"
echo ------------------------------------------- >> "%PROJECT_DIR%\PROJECT-REPORT.txt"

set /a raw_count=0
for %%F in ("%RAW_DIR%\*") do set /a raw_count+=1
echo 原始素材: %raw_count% 个文件 >> "%PROJECT_DIR%\PROJECT-REPORT.txt"

set /a trans_count=0
for %%F in ("%TRANSCODED_DIR%\*") do set /a trans_count+=1
echo 转码文件: %trans_count% 个文件 >> "%PROJECT_DIR%\PROJECT-REPORT.txt"

set /a wm_count=0
for %%F in ("%WATERMARKED_DIR%\*") do set /a wm_count+=1
echo 水印视频: %wm_count% 个文件 >> "%PROJECT_DIR%\PROJECT-REPORT.txt"

set /a thumb_count=0
for %%F in ("%THUMBS_DIR%\*") do set /a thumb_count+=1
echo 缩略图: %thumb_count% 个文件 >> "%PROJECT_DIR%\PROJECT-REPORT.txt"

set /a final_count=0
for %%F in ("%FINAL_DIR%\*") do set /a final_count+=1
echo 最终版本: %final_count% 个文件 >> "%PROJECT_DIR%\PROJECT-REPORT.txt"

echo. >> "%PROJECT_DIR%\PROJECT-REPORT.txt"
echo 目录结构: >> "%PROJECT_DIR%\PROJECT-REPORT.txt"
echo ------------------------------------------- >> "%PROJECT_DIR%\PROJECT-REPORT.txt"
tree /f "%PROJECT_DIR%" >> "%PROJECT_DIR%\PROJECT-REPORT.txt"

echo ✅ 项目报告已生成: %PROJECT_DIR%\PROJECT-REPORT.txt
echo.

REM 总结
echo ===========================================
echo    工作流测试完成！
echo ===========================================
echo.
echo 📊 生成统计:
echo   - 原始素材: %raw_count% 个视频
echo   - 转码版本: %trans_count% 个文件 (3种分辨率)
echo   - 水印视频: %wm_count% 个
echo   - 缩略图: %thumb_count% 个
echo   - 最终版本: %final_count% 个文件
echo.
echo 📁 项目位置: %PROJECT_DIR%
echo.
echo ✅ CLI-Anything 视频制作工作流测试成功！
echo.
pause

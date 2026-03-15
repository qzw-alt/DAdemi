@echo off
chcp 65001 > nul
echo.
echo ===========================================
echo    TikTok 15秒完整版 - 制作脚本
echo ===========================================
echo.

set OUTDIR=C:\Users\csdm2\Videos\Patient-Story-Michael\完整版
set FINAL=C:\Users\csdm2\Videos\Patient-Story-Michael\04-Final

mkdir "%OUTDIR%" 2>nul
mkdir "%FINAL%" 2>nul

echo [步骤1/4] 生成场景1: 美国账单 (0-4秒)...
C:\ffmpeg\bin\ffmpeg.exe -f lavfi -i "color=c=#FF4444:s=1080x1920:d=4" -vf "drawtext=text='🇺🇸 US Hospital':fontsize=80:fontcolor=white:x=(w-text_w)/2:y=300:enable='between(t\,0\,4)',drawtext=text='$50,000':fontsize=150:fontcolor=yellow:x=(w-text_w)/2:y=500:enable='between(t\,0\,4)',drawtext=text='💸💸💸':fontsize=100:fontcolor=white:x=(w-text_w)/2:y=750:enable='between(t\,0\,4)'" -pix_fmt yuv420p -y "%OUTDIR%\scene1_us.mp4" 2>nul
echo ✅ 场景1完成
echo.

echo [步骤2/4] 生成场景2: 飞中国 (4-8秒)...
C:\ffmpeg\bin\ffmpeg.exe -f lavfi -i "color=c=#FF8C00:s=1080x1920:d=4" -vf "drawtext=text='✈️ Fly to China':fontsize=80:fontcolor=white:x=(w-text_w)/2:y=300:enable='between(t\,0\,4)',drawtext=text='Same Surgery':fontsize=100:fontcolor=white:x=(w-text_w)/2:y=500:enable='between(t\,0\,4)',drawtext=text='💰 $8,000':fontsize=140:fontcolor=#00FF00:x=(w-text_w)/2:y=700:enable='between(t\,0\,4)'" -pix_fmt yuv420p -y "%OUTDIR%\scene2_china.mp4" 2>nul
echo ✅ 场景2完成
echo.

echo [步骤3/4] 生成场景3: 节省金额 (8-12秒)...
C:\ffmpeg\bin\ffmpeg.exe -f lavfi -i "color=c=#FFD700:s=1080x1920:d=4" -vf "drawtext=text='🎉 YOU SAVE':fontsize=90:fontcolor=white:x=(w-text_w)/2:y=300:enable='between(t\,0\,4)',drawtext=text='$42,000!':fontsize=180:fontcolor=#FF0000:x=(w-text_w)/2:y=550:enable='between(t\,0\,4)',drawtext=text='Same Quality!':fontsize=80:fontcolor=white:x=(w-text_w)/2:y=800:enable='between(t\,0\,4)'" -pix_fmt yuv420p -y "%OUTDIR%\scene3_save.mp4" 2>nul
echo ✅ 场景3完成
echo.

echo [步骤4/4] 生成场景4: CTA (12-15秒)...
C:\ffmpeg\bin\ffmpeg.exe -f lavfi -i "color=c=#FF6B35:s=1080x1920:d=3" -vf "drawtext=text='🏥 China Hospitals Guide':fontsize=70:fontcolor=white:x=(w-text_w)/2:y=400:enable='between(t\,0\,3)',drawtext=text='Free Consultation':fontsize=90:fontcolor=yellow:x=(w-text_w)/2:y=600:enable='between(t\,0\,3)',drawtext=text='👉 Link in Bio 👈':fontsize=80:fontcolor=white:x=(w-text_w)/2:y=800:enable='between(t\,0\,3)'" -pix_fmt yuv420p -y "%OUTDIR%\scene4_cta.mp4" 2>nul
echo ✅ 场景4完成
echo.

echo [合并] 添加转场效果...
(echo file '%OUTDIR%\scene1_us.mp4') > "%OUTDIR%\list.txt"
(echo file '%OUTDIR%\scene2_china.mp4') >> "%OUTDIR%\list.txt"
(echo file '%OUTDIR%\scene3_save.mp4') >> "%OUTDIR%\list.txt"
(echo file '%OUTDIR%\scene4_cta.mp4') >> "%OUTDIR%\list.txt"

C:\ffmpeg\bin\ffmpeg.exe -f concat -safe 0 -i "%OUTDIR%\list.txt" -vf "fade=st=3:d=0.5:alpha=1, fade=st=7:d=0.5:alpha=1, fade=st=11:d=0.5:alpha=1" -c:a copy -y "%FINAL%\TikTok-15s-完整版.mp4" 2>nul

echo.
echo ===========================================
echo 制作完成!
echo ===========================================
echo.
if exist "%FINAL%\TikTok-15s-完整版.mp4" (
    echo ✅ 文件生成成功!
    echo 📁 位置: %FINAL%\TikTok-15s-完整版.mp4
    for %%F in ("%FINAL%\TikTok-15s-完整版.mp4") do echo 📊 大小: %%~zF 字节
) else (
    echo ❌ 生成失败
)
echo.
pause

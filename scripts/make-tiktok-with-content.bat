@echo off
echo ===========================================
echo    TikTok 15秒完整版 - 素材合成
echo ===========================================
echo.

set FFMPEG=C:\ffmpeg\bin\ffmpeg.exe
set SOURCE=D:\Patient-Story-Michael\01-Raw-Footage
set OUTPUT=C:\Users\csdm2\Videos\Patient-Story-Michael\04-Final
set TEMP=C:\Users\csdm2\Videos\Patient-Story-Michael\02-Edited

mkdir "%OUTPUT%" 2>nul
mkdir "%TEMP%" 2>nul

echo [步骤1/5] 处理场景1: 患者疼痛 (0-4秒)...
%FFMPEG% -i "%SOURCE%\�� TikTok �ϲ��� middle aged man knee pain TikTok ���� (2).mp4" -t 4 -vf "scale=1080:1920:force_original_aspect_ratio=decrease,pad=1080:1920:(ow-iw)/2:(oh-ih)/2,drawtext=text='US Hospital Bill':fontsize=70:fontcolor=white:x=(w-text_w)/2:y=200,drawtext=text='$50,000':fontsize=120:fontcolor=yellow:x=(w-text_w)/2:y=400" -c:a copy -y "%TEMP%\scene1.mp4" 2>nul
echo ok

echo [步骤2/5] 处理场景2: 飞中国 (4-8秒)...
%FFMPEG% -i "%SOURCE%\�� TikTok �ϲ��� middle aged man knee pain TikTok ����.mp4" -ss 0 -t 4 -vf "scale=1080:1920:force_original_aspect_ratio=decrease,pad=1080:1920:(ow-iw)/2:(oh-ih)/2,drawtext=text='Fly to China':fontsize=70:fontcolor=white:x=(w-text_w)/2:y=200,drawtext=text='$8,000 Only':fontsize=110:fontcolor=#00FF00:x=(w-text_w)/2:y=400" -c:a copy -y "%TEMP%\scene2.mp4" 2>nul
echo ok

echo [步骤3/5] 处理场景3: 节省费用 (8-12秒)...
%FFMPEG% -i "%SOURCE%\�� TikTok �ϲ��� middle aged man knee pain TikTok ���� (1).mp4" -ss 10 -t 4 -vf "scale=1080:1920:force_original_aspect_ratio=decrease,pad=1080:1920:(ow-iw)/2:(oh-ih)/2,drawtext=text='YOU SAVE':fontsize=80:fontcolor=white:x=(w-text_w)/2:y=200,drawtext=text='$42,000':fontsize=150:fontcolor=red:x=(w-text_w)/2:y=400" -c:a copy -y "%TEMP%\scene3.mp4" 2>nul
echo ok

echo [步骤4/5] 处理场景4: CTA (12-15秒)...
%FFMPEG% -i "%SOURCE%\�� TikTok �ϲ��� middle aged man knee pain TikTok ���� (3).mp4" -ss 20 -t 3 -vf "scale=1080:1920:force_original_aspect_ratio=decrease,pad=1080:1920:(ow-iw)/2:(oh-ih)/2,drawtext=text='ChinaHospitalsGuide.com':fontsize=60:fontcolor=white:x=(w-text_w)/2:y=300,drawtext=text='FREE Consultation':fontsize=90:fontcolor=yellow:x=(w-text_w)/2:y=500" -c:a copy -y "%TEMP%\scene4.mp4" 2>nul
echo ok

echo [步骤5/5] 合并所有场景...
(echo file '%TEMP%\scene1.mp4') > "%TEMP%\list.txt"
(echo file '%TEMP%\scene2.mp4') >> "%TEMP%\list.txt"
(echo file '%TEMP%\scene3.mp4') >> "%TEMP%\list.txt"
(echo file '%TEMP%\scene4.mp4') >> "%TEMP%\list.txt"

%FFMPEG% -f concat -safe 0 -i "%TEMP%\list.txt" -c copy -y "%OUTPUT%\TikTok-15s-有内容版.mp4" 2>nul

echo.
echo ===========================================
if exist "%OUTPUT%\TikTok-15s-有内容版.mp4" (
    echo 制作完成!
    echo 输出: %OUTPUT%\TikTok-15s-有内容版.mp4
) else (
    echo 制作失败
)
echo ===========================================
pause

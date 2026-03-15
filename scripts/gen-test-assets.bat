@echo off
echo ===========================================
echo    生成30秒测试版素材
echo ===========================================
echo.

set RAW_DIR=C:\Users\csdm2\Videos\Patient-Story-Michael\01-Raw-Footage
mkdir "%RAW_DIR%" 2>nul

echo [1/4] 医院外景...
C:\ffmpeg\bin\ffmpeg.exe -f lavfi -i "color=c=#2c3e50:s=1920x1080:d=5" -vf "drawtext=text='HOSPITAL':fontsize=80:fontcolor=white:x=(w-text_w)/2:y=(h-text_h)/2" -pix_fmt yuv420p -y "%RAW_DIR%\01-hospital.mp4" 2>nul
echo ok

echo [2/4] 账单特写...
C:\ffmpeg\bin\ffmpeg.exe -f lavfi -i "color=c=#e74c3c:s=1920x1080:d=5" -vf "drawtext=text='$50,000':fontsize=100:fontcolor=white:x=(w-text_w)/2:y=(h-text_h)/2" -pix_fmt yuv420p -y "%RAW_DIR%\02-bill.mp4" 2>nul
echo ok

echo [3/4] 患者场景...
C:\ffmpeg\bin\ffmpeg.exe -f lavfi -i "color=c=#34495e:s=1920x1080:d=10" -vf "drawtext=text='Michael, 52 - Knee Pain':fontsize=60:fontcolor=white:x=100:y=100" -pix_fmt yuv420p -y "%RAW_DIR%\03-patient.mp4" 2>nul
echo ok

echo [4/4] 等待时间...
C:\ffmpeg\bin\ffmpeg.exe -f lavfi -i "color=c=#7f8c8d:s=1920x1080:d=10" -vf "drawtext=text='3 MONTHS WAIT':fontsize=80:fontcolor=#e74c3c:x=(w-text_w)/2:y=(h-text_h)/2" -pix_fmt yuv420p -y "%RAW_DIR%\04-waiting.mp4" 2>nul
echo ok

echo.
echo ===========================================
echo Done!
echo ===========================================
dir /b "%RAW_DIR%\*.mp4"

# 30秒测试版 - 快速制作脚本
# 使用FFmpeg生成模拟素材+配音

$projectDir = "C:\Users\csdm2\Videos\Patient-Story-Michael"
$rawDir = "$projectDir\01-Raw-Footage"
$editDir = "$projectDir\02-Edited"
$finalDir = "$projectDir\04-Final"
$ffmpeg = "C:\ffmpeg\bin\ffmpeg.exe"

# 创建目录
New-Item -ItemType Directory -Path $editDir -Force | Out-Null
New-Item -ItemType Directory -Path $finalDir -Force | Out-Null

Write-Host "🎬 制作30秒测试版" -ForegroundColor Cyan
Write-Host "==================" -ForegroundColor Cyan

# 场景1: 美国医院外景 (0:00-0:05, 5秒)
Write-Host "`n[场景1/4] 生成美国医院外景..." -ForegroundColor Yellow
& $ffmpeg -f lavfi -i "sine=frequency=0:duration=5" `
    -f lavfi -i "color=c=#2c3e50:s=1920x1080:d=5" `
    -vf "drawtext=text='HOSPITAL':fontsize=80:fontcolor=white:x=(w-text_w)/2:y=(h-text_h)/2,drawtext=text='Medical Center':fontsize=40:fontcolor=#ecf0f1:x=(w-text_w)/2:y=(h-text_h)/2+60" `
    -pix_fmt yuv420p -y "$rawDir\01-hospital-exterior.mp4" 2> nul
Write-Host "✅ 完成"

# 场景2: 账单特写 (0:05-0:10, 5秒)
Write-Host "`n[场景2/4] 生成账单特写..." -ForegroundColor Yellow
& $ffmpeg -f lavfi -i "sine=frequency=0:duration=5" `
    -f lavfi -i "color=c=#e74c3c:s=1920x1080:d=5" `
    -vf "drawtext=text='TOTAL: $50,000':fontsize=100:fontcolor=white:x=(w-text_w)/2:y=(h-text_h)/2,drawtext=text='Out-of-pocket: $15,000':fontsize=50:fontcolor=#ffeaa7:x=(w-text_w)/2:y=(h-text_h)/2+80" `
    -pix_fmt yuv420p -y "$rawDir\02-medical-bill.mp4" 2> nul
Write-Host "✅ 完成"

# 场景3: 痛苦的患者 (0:10-0:20, 10秒)
Write-Host "`n[场景3/4] 生成患者场景..." -ForegroundColor Yellow
& $ffmpeg -f lavfi -i "sine=frequency=0:duration=10" `
    -f lavfi -i "color=c=#34495e:s=1920x1080:d=10" `
    -vf "drawtext=text='Michael, 52':fontsize=60:fontcolor=white:x=100:y=100,drawtext=text='Knee Pain...':fontsize=40:fontcolor=#bdc3c7:x=100:y=180" `
    -pix_fmt yuv420p -y "$rawDir\03-patient-pain.mp4" 2> nul
Write-Host "✅ 完成"

# 场景4: 等待/预约系统 (0:20-0:30, 10秒)
Write-Host "`n[场景4/4] 生成等待场景..." -ForegroundColor Yellow
& $ffmpeg -f lavfi -i "sine=frequency=0:duration=10" `
    -f lavfi -i "color=c=#7f8c8d:s=1920x1080:d=10" `
    -vf "drawtext=text='WAITING TIME':fontsize=70:fontcolor=white:x=(w-text_w)/2:y=200,drawtext=text='3 MONTHS':fontsize=100:fontcolor=#e74c3c:x=(w-text_w)/2:y=350" `
    -pix_fmt yuv420p -y "$rawDir\04-waiting-room.mp4" 2> nul
Write-Host "✅ 完成"

Write-Host "`n==================" -ForegroundColor Cyan
Write-Host "模拟素材生成完成!" -ForegroundColor Green

# 显示生成的文件
Write-Host "`n生成的素材:" -ForegroundColor Yellow
Get-ChildItem $rawDir -Filter "*.mp4" | ForEach-Object {
    Write-Host "  - $($_.Name)" -ForegroundColor Gray
}

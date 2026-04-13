# 多平台视频分发方案

> 一个视频 → 自动适配 → 全平台发布
> 目标平台：TikTok / Facebook / Twitter(X) / Instagram
> 使用 CLI-Anything 自动化处理

---

## 各平台视频规格要求

| 平台 | 比例 | 分辨率 | 时长 | 格式 | 特点 |
|------|------|--------|------|------|------|
| **TikTok** | 9:16 竖屏 | 1080x1920 | 15s-3min | MP4 | 移动端，快节奏 |
| **Instagram Feed** | 4:5 竖屏 | 1080x1350 | 3-60s | MP4 | 方形或竖屏 |
| **Instagram Reels** | 9:16 竖屏 | 1080x1920 | 15-90s | MP4 | 类似TikTok |
| **Facebook** | 16:9 横屏 | 1280x720 | 不限 | MP4 | 支持横屏 |
| **Twitter/X** | 16:9 横屏 | 1280x720 | 2min20s | MP4 | 横屏为主 |

---

## 分发策略

### 方案A：一源多输出（推荐）

**原始视频**（16:9 横屏，YouTube版本）
```
         ├─→ TikTok: 智能裁剪为 9:16（保留中心区域）
         ├─→ Instagram Reels: 9:16 竖屏
         ├─→ Instagram Feed: 4:5 竖屏
         ├─→ Facebook: 16:9 横屏（原始或压缩）
         └─→ Twitter/X: 16:9 横屏
```

### 方案B：分别制作
- 横屏版（YouTube + Facebook + Twitter）
- 竖屏版（TikTok + Instagram Reels）

---

## 自动化处理脚本

### 1. 创建项目结构

```powershell
$project = "C:\Users\$env:USERNAME\Videos\Multi-Platform-Distribution"
$source = "$project\01-Source"           # 原始视频
$platforms = "$project\02-Platforms"     # 各平台版本
$thumbnails = "$project\03-Thumbnails"   # 各平台封面

# 创建目录
New-Item -ItemType Directory -Path $source -Force
New-Item -ItemType Directory -Path $platforms -Force
New-Item -ItemType Directory -Path $thumbnails -Force

# 平台子目录
@("TikTok", "Instagram-Feed", "Instagram-Reels", "Facebook", "Twitter") | ForEach-Object {
    New-Item -ItemType Directory -Path "$platforms\$_" -Force
    New-Item -ItemType Directory -Path "$thumbnails\$_" -Force
}
```

### 2. 批量转码脚本

```powershell
param(
    [Parameter(Mandatory=$true)]
    [string]$InputVideo
)

$ffmpeg = "C:\ffmpeg\bin\ffmpeg.exe"
$baseName = [System.IO.Path]::GetFileNameWithoutExtension($InputVideo)
$platforms = "C:\Users\$env:USERNAME\Videos\Multi-Platform-Distribution\02-Platforms"

Write-Host "🎬 开始多平台转码: $baseName" -ForegroundColor Cyan
Write-Host "================================" -ForegroundColor Cyan

# 1. TikTok (9:16, 1080x1920) - 智能裁剪中心区域
Write-Host "`n📱 TikTok (9:16 竖屏)..." -ForegroundColor Yellow
& $ffmpeg -i $InputVideo `
    -vf "scale=1080:1920:force_original_aspect_ratio=increase,crop=1080:1920:(in_w-1080)/2:(in_h-1920)/2,setsar=1" `
    -c:v libx264 -preset fast -crf 23 `
    -c:a aac -b:a 128k `
    -r 30 `
    -y "$platforms\TikTok\${baseName}_TikTok.mp4" 2> nul
Write-Host "   ✅ 完成" -ForegroundColor Green

# 2. Instagram Reels (9:16, 1080x1920)
Write-Host "`n📸 Instagram Reels (9:16 竖屏)..." -ForegroundColor Yellow
& $ffmpeg -i $InputVideo `
    -vf "scale=1080:1920:force_original_aspect_ratio=increase,crop=1080:1920:(in_w-1080)/2:(in_h-1920)/2,setsar=1" `
    -c:v libx264 -preset fast -crf 23 `
    -c:a aac -b:a 128k `
    -r 30 `
    -y "$platforms\Instagram-Reels\${baseName}_Reels.mp4" 2> nul
Write-Host "   ✅ 完成" -ForegroundColor Green

# 3. Instagram Feed (4:5, 1080x1350)
Write-Host "`n📷 Instagram Feed (4:5 竖屏)..." -ForegroundColor Yellow
& $ffmpeg -i $InputVideo `
    -vf "scale=1080:1350:force_original_aspect_ratio=increase,crop=1080:1350:(in_w-1080)/2:(in_h-1350)/2,setsar=1" `
    -c:v libx264 -preset fast -crf 23 `
    -c:a aac -b:a 128k `
    -r 30 `
    -y "$platforms\Instagram-Feed\${baseName}_Feed.mp4" 2> nul
Write-Host "   ✅ 完成" -ForegroundColor Green

# 4. Facebook (16:9, 1280x720)
Write-Host "`n📘 Facebook (16:9 横屏)..." -ForegroundColor Yellow
& $ffmpeg -i $InputVideo `
    -vf "scale=1280:720:force_original_aspect_ratio=decrease,pad=1280:720:(ow-iw)/2:(oh-ih)/2,setsar=1" `
    -c:v libx264 -preset fast -crf 23 `
    -c:a aac -b:a 128k `
    -r 30 `
    -y "$platforms\Facebook\${baseName}_Facebook.mp4" 2> nul
Write-Host "   ✅ 完成" -ForegroundColor Green

# 5. Twitter/X (16:9, 1280x720)
Write-Host "`n🐦 Twitter/X (16:9 横屏)..." -ForegroundColor Yellow
& $ffmpeg -i $InputVideo `
    -vf "scale=1280:720:force_original_aspect_ratio=decrease,pad=1280:720:(ow-iw)/2:(oh-ih)/2,setsar=1" `
    -c:v libx264 -preset fast -crf 23 `
    -c:a aac -b:a 128k `
    -r 30 `
    -y "$platforms\Twitter\${baseName}_Twitter.mp4" 2> nul
Write-Host "   ✅ 完成" -ForegroundColor Green

Write-Host "`n================================" -ForegroundColor Cyan
Write-Host "🎉 多平台转码完成！" -ForegroundColor Green

# 显示结果
Write-Host "`n输出文件:" -ForegroundColor Yellow
Get-ChildItem $platforms -Recurse -Filter "*.mp4" | ForEach-Object {
    $size = [math]::Round($_.Length / 1MB, 2)
    Write-Host "  $($_.FullName.Replace($platforms, '')) - ${size}MB" -ForegroundColor Gray
}
```

### 3. 生成多平台封面

```powershell
param(
    [Parameter(Mandatory=$true)]
    [string]$InputVideo
)

$ffmpeg = "C:\ffmpeg\bin\ffmpeg.exe"
$thumbnails = "C:\Users\$env:USERNAME\Videos\Multi-Platform-Distribution\03-Thumbnails"
$baseName = [System.IO.Path]::GetFileNameWithoutExtension($InputVideo)

Write-Host "🖼️ 生成多平台封面..." -ForegroundColor Cyan

# TikTok封面 (9:16, 1080x1920)
& $ffmpeg -i $InputVideo -ss 00:00:03 -vframes 1 `
    -vf "scale=1080:1920:force_original_aspect_ratio=increase,crop=1080:1920,setsar=1" `
    -y "$thumbnails\TikTok\${baseName}_TikTok.jpg" 2> nul

# Instagram Reels封面 (9:16)
& $ffmpeg -i $InputVideo -ss 00:00:03 -vframes 1 `
    -vf "scale=1080:1920:force_original_aspect_ratio=increase,crop=1080:1920,setsar=1" `
    -y "$thumbnails\Instagram-Reels\${baseName}_Reels.jpg" 2> nul

# Instagram Feed封面 (4:5, 1080x1350)
& $ffmpeg -i $InputVideo -ss 00:00:03 -vframes 1 `
    -vf "scale=1080:1350:force_original_aspect_ratio=increase,crop=1080:1350,setsar=1" `
    -y "$thumbnails\Instagram-Feed\${baseName}_Feed.jpg" 2> nul

# Facebook封面 (16:9, 1280x720)
& $ffmpeg -i $InputVideo -ss 00:00:03 -vframes 1 `
    -vf "scale=1280:720:force_original_aspect_ratio=decrease,pad=1280:720:(ow-iw)/2:(oh-ih)/2,setsar=1" `
    -y "$thumbnails\Facebook\${baseName}_Facebook.jpg" 2> nul

# Twitter封面 (16:9, 1280x720)
& $ffmpeg -i $InputVideo -ss 00:00:03 -vframes 1 `
    -vf "scale=1280:720:force_original_aspect_ratio=decrease,pad=1280:720:(ow-iw)/2:(oh-ih)/2,setsar=1" `
    -y "$thumbnails\Twitter\${baseName}_Twitter.jpg" 2> nul

Write-Host "✅ 所有平台封面生成完成！" -ForegroundColor Green
```

### 4. 一键分发脚本

```powershell
# multi-platform-publish.ps1
# 一键发布到所有平台（需要配置各平台API）

param(
    [string]$VideoDir = "C:\Users\$env:USERNAME\Videos\Multi-Platform-Distribution\02-Platforms"
)

$platforms = @{
    "TikTok" = @{
        Enabled = $true
        Video = "$VideoDir\TikTok\*.mp4"
        Title = "How I saved $40,000 on surgery in China 🇨🇳 #medicaltourism #china #healthcare"
    }
    "Instagram-Reels" = @{
        Enabled = $true
        Video = "$VideoDir\Instagram-Reels\*.mp4"
        Caption = "My medical journey to China 💰 Saved thousands!\n\n#MedicalTourism #ChinaHealthcare #Savings"
    }
    "Instagram-Feed" = @{
        Enabled = $true
        Video = "$VideoDir\Instagram-Feed\*.mp4"
        Caption = "Full story on my profile! Link in bio 👆"
    }
    "Facebook" = @{
        Enabled = $true
        Video = "$VideoDir\Facebook\*.mp4"
        Title = "My Medical Tourism Experience in China"
        Description = "Sharing my real experience of getting surgery in China and saving over $40,000. Full story in the video!"
    }
    "Twitter" = @{
        Enabled = $true
        Video = "$VideoDir\Twitter\*.mp4"
        Text = "Just posted my full medical tourism story on YouTube. TL;DR: Saved $40K+ and got better care than in the US 🏥🇨🇳"
    }
}

Write-Host "📤 多平台发布清单" -ForegroundColor Cyan
Write-Host "==================" -ForegroundColor Cyan

foreach ($platform in $platforms.GetEnumerator()) {
    $name = $platform.Key
    $config = $platform.Value
    
    if ($config.Enabled) {
        Write-Host "`n📱 $name" -ForegroundColor Yellow
        Write-Host "   视频: $($config.Video)"
        if ($config.Title) { Write-Host "   标题: $($config.Title)" }
        if ($config.Caption) { Write-Host "   文案: $($config.Caption)" }
        if ($config.Text) { Write-Host "   文字: $($config.Text)" }
        
        # 这里可以接入各平台的API进行自动发布
        # 目前只是模拟，实际需要配置API keys
        Write-Host "   ⏳ 准备发布..." -ForegroundColor Gray
    }
}

Write-Host "`n==================" -ForegroundColor Cyan
Write-Host "准备就绪！等待API配置后自动发布" -ForegroundColor Green
```

---

## 使用流程

### 第一步：准备原始视频
1. 制作或下载一个 **16:9 横屏** 视频（YouTube版本）
2. 放入 `01-Source` 文件夹

### 第二步：运行转码脚本
```powershell
.\convert-to-all-platforms.ps1 -InputVideo "C:\Users\...\01-Source\my-video.mp4"
```

### 第三步：生成封面
```powershell
.\generate-thumbnails.ps1 -InputVideo "C:\Users\...\01-Source\my-video.mp4"
```

### 第四步：上传到各平台
- 手动上传到各平台，或使用脚本（需API配置）

---

## 文件夹结构

```
Multi-Platform-Distribution/
├── 01-Source/                  # 原始视频（16:9横屏）
│   └── my-video.mp4
├── 02-Platforms/               # 各平台版本
│   ├── TikTok/                 # 9:16竖屏
│   ├── Instagram-Reels/        # 9:16竖屏
│   ├── Instagram-Feed/         # 4:5竖屏
│   ├── Facebook/               # 16:9横屏
│   └── Twitter/                # 16:9横屏
├── 03-Thumbnails/              # 各平台封面
│   ├── TikTok/
│   ├── Instagram-Reels/
│   ├── Instagram-Feed/
│   ├── Facebook/
│   └── Twitter/
└── publish-log.txt             # 发布记录
```

---

## 快速开始

```powershell
# 1. 创建项目
.\setup-multi-platform-project.ps1

# 2. 放入原始视频到 01-Source/

# 3. 一键转码所有平台
.\convert-to-all-platforms.ps1 -InputVideo "01-Source\video.mp4"

# 4. 生成所有封面
.\generate-thumbnails.ps1 -InputVideo "01-Source\video.mp4"

# 5. 手动上传到各平台，或使用API自动发布
```

---

**一个视频 → 五大平台 → 全自动处理！**

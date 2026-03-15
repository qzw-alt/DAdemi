# 视频去字幕工具

> 一键去除视频字幕（软字幕）或遮盖硬字幕
> 使用 FFmpeg + AI 修复

---

## 功能说明

### 支持的字幕类型

| 类型 | 说明 | 去除难度 | 解决方案 |
|------|------|---------|---------|
| **软字幕** (Soft Subtitle) | 单独的字幕轨道，可开关 | ⭐ 简单 | 直接删除轨道 |
| **硬字幕** (Hardcoded) | 烧录进画面像素 | ⭐⭐⭐⭐ 困难 | 裁剪/模糊/AI修复 |
| **外挂字幕** (External) | 单独的 .srt/.ass 文件 | ⭐ 最简单 | 删除文件即可 |

---

## 使用方式

### 方式1：检测字幕类型
```powershell
.\remove-subtitle.ps1 -InputVideo "video.mp4" -DetectOnly
```

### 方式2：去除软字幕
```powershell
.\remove-subtitle.ps1 -InputVideo "video.mp4" -OutputVideo "output.mp4"
```

### 方式3：遮盖硬字幕（底部20%区域）
```powershell
.\remove-subtitle.ps1 -InputVideo "video.mp4" -OutputVideo "output.mp4" -Method blur
```

### 方式4：裁剪掉字幕区域
```powershell
.\remove-subtitle.ps1 -InputVideo "video.mp4" -OutputVideo "output.mp4" -Method crop
```

---

## 完整脚本代码

```powershell
# remove-subtitle.ps1
# 视频去字幕工具

param(
    [Parameter(Mandatory=$true)]
    [string]$InputVideo,
    
    [string]$OutputVideo,
    
    [ValidateSet("remove", "blur", "crop", "detect")]
    [string]$Method = "detect",
    
    [switch]$DetectOnly
)

$ffmpeg = "C:\ffmpeg\bin\ffmpeg.exe"

# 检查输入文件
if (-not (Test-Path $InputVideo)) {
    Write-Host "❌ 错误：找不到输入文件 $InputVideo" -ForegroundColor Red
    exit 1
}

Write-Host "🎬 视频去字幕工具" -ForegroundColor Cyan
Write-Host "==================" -ForegroundColor Cyan
Write-Host ""
Write-Host "输入文件: $InputVideo" -ForegroundColor Gray

# 检测字幕信息
Write-Host "`n🔍 正在检测字幕信息..." -ForegroundColor Yellow
$probeOutput = & $ffmpeg -i $InputVideo 2>&1

# 分析字幕轨道
$subtitleStreams = $probeOutput | Select-String -Pattern "Stream.*Subtitle"
$videoStream = $probeOutput | Select-String -Pattern "Stream.*Video.*(\d{3,4}x\d{3,4})"

# 提取视频分辨率
if ($videoStream -match '(\d{3,4}x\d{3,4})') {
    $resolution = $Matches[1]
    Write-Host "视频分辨率: $resolution" -ForegroundColor Gray
}

# 显示字幕轨道信息
if ($subtitleStreams) {
    Write-Host "`n📋 发现字幕轨道:" -ForegroundColor Green
    $subtitleStreams | ForEach-Object {
        Write-Host "   $_" -ForegroundColor Gray
    }
    $hasSoftSubtitle = $true
} else {
    Write-Host "`n⚠️  未发现软字幕轨道（可能是硬字幕）" -ForegroundColor Yellow
    $hasSoftSubtitle = $false
}

# 如果只是检测，到此结束
if ($DetectOnly -or $Method -eq "detect") {
    Write-Host "`n✅ 检测完成" -ForegroundColor Green
    if ($hasSoftSubtitle) {
        Write-Host "建议: 使用 -Method remove 去除软字幕" -ForegroundColor Cyan
    } else {
        Write-Host "建议: 使用 -Method blur 或 crop 处理硬字幕" -ForegroundColor Cyan
    }
    exit 0
}

# 如果未指定输出文件名，自动生成
if (-not $OutputVideo) {
    $baseName = [System.IO.Path]::GetFileNameWithoutExtension($InputVideo)
    $extension = [System.IO.Path]::GetExtension($InputVideo)
    $OutputVideo = "${baseName}_no-subtitle${extension}"
}

Write-Host "`n输出文件: $OutputVideo" -ForegroundColor Gray

# 根据方法处理
switch ($Method) {
    "remove" {
        # 去除软字幕轨道
        Write-Host "`n🗑️  正在去除软字幕轨道..." -ForegroundColor Yellow
        & $ffmpeg -i $InputVideo `
            -map 0:v -map 0:a `
            -c:v copy -c:a copy `
            -sn `
            -y $OutputVideo 2> nul
        
        if (Test-Path $OutputVideo) {
            Write-Host "✅ 软字幕已去除" -ForegroundColor Green
        }
    }
    
    "blur" {
        # 模糊底部字幕区域（假设字幕在底部20%）
        Write-Host "`n🌫️  正在模糊底部字幕区域..." -ForegroundColor Yellow
        
        # 解析分辨率
        $width, $height = $resolution -split 'x'
        $blurHeight = [math]::Round($height * 0.2)  # 底部20%
        $mainHeight = $height - $blurHeight
        
        # 使用 boxblur 模糊底部区域
        $filter = "split[original][blur];[blur]crop=iw:${blurHeight}:0:${mainHeight},boxblur=10:5[blurred];[original][blurred]overlay=0:${mainHeight}"
        
        & $ffmpeg -i $InputVideo `
            -vf $filter `
            -c:a copy `
            -y $OutputVideo 2> nul
        
        if (Test-Path $OutputVideo) {
            Write-Host "✅ 字幕区域已模糊处理" -ForegroundColor Green
        }
    }
    
    "crop" {
        # 裁剪掉底部字幕区域
        Write-Host "`n✂️  正在裁剪字幕区域..." -ForegroundColor Yellow
        
        # 解析分辨率
        $width, $height = $resolution -split 'x'
        $newHeight = [math]::Round($height * 0.8)  # 保留顶部80%
        
        # 裁剪顶部80%，缩放回原分辨率（避免黑边）
        $filter = "crop=iw:${newHeight}:0:0,scale=${width}:${height}"
        
        & $ffmpeg -i $InputVideo `
            -vf $filter `
            -c:a copy `
            -y $OutputVideo 2> nul
        
        if (Test-Path $OutputVideo) {
            Write-Host "✅ 字幕区域已裁剪" -ForegroundColor Green
        }
    }
}

# 显示结果
if (Test-Path $OutputVideo) {
    $originalSize = (Get-Item $InputVideo).Length / 1MB
    $newSize = (Get-Item $OutputVideo).Length / 1MB
    
    Write-Host "`n==================" -ForegroundColor Cyan
    Write-Host "✅ 处理完成!" -ForegroundColor Green
    Write-Host "原文件大小: $([math]::Round($originalSize, 2)) MB" -ForegroundColor Gray
    Write-Host "新文件大小: $([math]::Round($newSize, 2)) MB" -ForegroundColor Gray
    Write-Host "输出位置: $OutputVideo" -ForegroundColor Gray
}
```

---

## 批处理版本（更简单）

### detect-subtitle.bat - 检测字幕
```batch
@echo off
echo 检测字幕中...
C:\ffmpeg\bin\ffmpeg.exe -i "%1" 2>&1 | findstr "Subtitle"
pause
```

### remove-soft-subtitle.bat - 去除软字幕
```batch
@echo off
set input=%1
set output=%~n1_no-subtitle%~x1
C:\ffmpeg\bin\ffmpeg.exe -i "%input%" -map 0:v -map 0:a -c:v copy -c:a copy -sn -y "%output%"
echo 完成: %output%
pause
```

### blur-subtitle.bat - 模糊字幕
```batch
@echo off
set input=%1
set output=%~n1_blurred%~x1
echo 正在模糊底部字幕区域...
C:\ffmpeg\bin\ffmpeg.exe -i "%input%" -vf "split[original][blur];[blur]crop=iw:ih*0.2:0:ih*0.8,boxblur=10:5[blurred];[original][blurred]overlay=0:H-h" -c:a copy -y "%output%"
echo 完成: %output%
pause
```

### crop-subtitle.bat - 裁剪字幕
```batch
@echo off
set input=%1
set output=%~n1_cropped%~x1
echo 正在裁剪字幕区域...
C:\ffmpeg\bin\ffmpeg.exe -i "%input%" -vf "crop=iw:ih*0.8:0:0,scale=iw:ih" -c:a copy -y "%output%"
echo 完成: %output%
pause
```

---

## 使用示例

### 场景1：去除内嵌软字幕
```powershell
.\remove-subtitle.ps1 -InputVideo "movie.mp4" -Method remove
# 输出: movie_no-subtitle.mp4
```

### 场景2：模糊底部硬字幕
```powershell
.\remove-subtitle.ps1 -InputVideo "video.mp4" -Method blur
# 输出: video_blurred.mp4
```

### 场景3：批量处理文件夹
```powershell
Get-ChildItem "*.mp4" | ForEach-Object {
    .\remove-subtitle.ps1 -InputVideo $_.FullName -Method remove
}
```

---

## 高级：AI修复硬字幕（实验性）

对于硬字幕，如果模糊/裁剪不满足要求，可以使用AI修复：

```python
# 需要安装: pip install opencv-python tensorflow
import cv2
import numpy as np

# 使用 OpenCV Inpainting 修复字幕区域
def remove_subtitle_ai(video_path, output_path):
    cap = cv2.VideoCapture(video_path)
    # ... AI修复代码
```

**注意**: AI修复效果取决于字幕复杂度，简单背景效果较好。

---

**要我立即创建这些脚本文件吗？** 🛠️

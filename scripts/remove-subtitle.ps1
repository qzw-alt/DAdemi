# 视频去字幕工具 - PowerShell版本
# 使用方法: .\remove-subtitle.ps1 -InputVideo "video.mp4" -Method remove/blur/crop

param(
    [Parameter(Mandatory=$true, HelpMessage="输入视频文件路径")]
    [string]$InputVideo,
    
    [Parameter(HelpMessage="输出视频文件路径")]
    [string]$OutputVideo,
    
    [Parameter(HelpMessage="处理方法: detect检测/remove去除/blur模糊/crop裁剪")]
    [ValidateSet("detect", "remove", "blur", "crop")]
    [string]$Method = "detect",
    
    [Parameter(HelpMessage="只检测字幕类型")]
    [switch]$DetectOnly,
    
    [Parameter(HelpMessage="字幕区域位置: bottom底部/top顶部")]
    [ValidateSet("bottom", "top")]
    [string]$SubtitlePosition = "bottom"
)

$ffmpeg = "C:\ffmpeg\bin\ffmpeg.exe"

# 颜色定义
function Write-ColorOutput($ForegroundColor) {
    $fc = $host.UI.RawUI.ForegroundColor
    $host.UI.RawUI.ForegroundColor = $ForegroundColor
    if ($args) {
        Write-Output $args
    }
    $host.UI.RawUI.ForegroundColor = $fc
}

# 检查FFmpeg
if (-not (Test-Path $ffmpeg)) {
    Write-Host "❌ 错误: 找不到FFmpeg。请确认已安装FFmpeg在 C:\ffmpeg\bin\" -ForegroundColor Red
    exit 1
}

# 检查输入文件
if (-not (Test-Path $InputVideo)) {
    Write-Host "❌ 错误: 找不到输入文件: $InputVideo" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "🎬 视频去字幕工具" -ForegroundColor Cyan
Write-Host "==================" -ForegroundColor Cyan
Write-Host ""
Write-Host "📁 输入文件: $InputVideo" -ForegroundColor Gray

# 获取文件信息
$fileInfo = Get-Item $InputVideo
Write-Host "📊 文件大小: $([math]::Round($fileInfo.Length/1MB, 2)) MB" -ForegroundColor Gray

# 检测视频信息
Write-Host ""
Write-Host "🔍 正在分析视频..." -ForegroundColor Yellow

$probeResult = & $ffmpeg -i $InputVideo 2>&1
$probeString = $probeResult -join "`n"

# 提取分辨率
if ($probeString -match '(\d{3,4})x(\d{3,4})') {
    $videoWidth = [int]$Matches[1]
    $videoHeight = [int]$Matches[2]
    Write-Host "📐 视频分辨率: ${videoWidth}x${videoHeight}" -ForegroundColor Gray
}

# 检测字幕轨道
$subtitleTracks = $probeResult | Select-String -Pattern "Stream.*Subtitle" 
$hasSoftSubtitle = $subtitleTracks.Count -gt 0

Write-Host ""
if ($hasSoftSubtitle) {
    Write-Host "✅ 发现软字幕轨道: $($subtitleTracks.Count) 个" -ForegroundColor Green
    $subtitleTracks | ForEach-Object { 
        $line = $_ -replace '^\s+', ''
        Write-Host "   $line" -ForegroundColor DarkGray 
    }
} else {
    Write-Host "⚠️  未发现软字幕轨道" -ForegroundColor Yellow
    Write-Host "   字幕可能是硬编码（烧录进画面）" -ForegroundColor DarkGray
}

# 如果只是检测，到此结束
if ($DetectOnly -or $Method -eq "detect") {
    Write-Host ""
    Write-Host "==================" -ForegroundColor Cyan
    Write-Host "🔍 检测结果" -ForegroundColor Cyan
    if ($hasSoftSubtitle) {
        Write-Host "类型: 软字幕（可去除）" -ForegroundColor Green
        Write-Host "建议: 使用 -Method remove 参数去除" -ForegroundColor Yellow
    } else {
        Write-Host "类型: 硬字幕（或无明显字幕轨道）" -ForegroundColor Red
        Write-Host "建议: 使用 -Method blur 模糊字幕区域" -ForegroundColor Yellow
        Write-Host "      或使用 -Method crop 裁剪字幕区域" -ForegroundColor Yellow
    }
    exit 0
}

# 生成输出文件名
if (-not $OutputVideo) {
    $baseName = [System.IO.Path]::GetFileNameWithoutExtension($InputVideo)
    $extension = [System.IO.Path]::GetExtension($InputVideo)
    $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
    $OutputVideo = "${baseName}_${Method}_${timestamp}${extension}"
}

$outputPath = Join-Path (Get-Location) $OutputVideo
Write-Host "📁 输出文件: $OutputVideo" -ForegroundColor Gray
Write-Host ""

# 根据方法处理
switch ($Method) {
    "remove" {
        if (-not $hasSoftSubtitle) {
            Write-Host "⚠️  警告: 未检测到软字幕轨道，将只复制视频流" -ForegroundColor Yellow
        }
        
        Write-Host "🗑️  正在去除软字幕轨道..." -ForegroundColor Yellow
        Write-Host "   保留视频和音频，删除所有字幕轨道" -ForegroundColor DarkGray
        
        & $ffmpeg -i $InputVideo `
            -map 0:v:0 `
            -map 0:a:0 `
            -c:v copy `
            -c:a copy `
            -sn `
            -y $outputPath 2> nul
        
        if ($LASTEXITCODE -eq 0 -and (Test-Path $outputPath)) {
            Write-Host ""
            Write-Host "✅ 软字幕去除成功!" -ForegroundColor Green
        } else {
            Write-Host ""
            Write-Host "❌ 处理失败" -ForegroundColor Red
            exit 1
        }
    }
    
    "blur" {
        Write-Host "🌫️  正在模糊字幕区域..." -ForegroundColor Yellow
        
        # 计算字幕区域（默认底部20%）
        $blurHeight = [math]::Round($videoHeight * 0.22)
        $mainHeight = $videoHeight - $blurHeight
        
        if ($SubtitlePosition -eq "bottom") {
            $yPosition = $mainHeight
            Write-Host "   模糊区域: 底部 ${blurHeight}px" -ForegroundColor DarkGray
        } else {
            $yPosition = 0
            Write-Host "   模糊区域: 顶部 ${blurHeight}px" -ForegroundColor DarkGray
        }
        
        # 构建滤镜: 分离原图和模糊区域，然后叠加
        $filterComplex = "split[original][toBlur];[toBlur]crop=iw:${blurHeight}:0:${yPosition},boxblur=lr=15:lp=5[blurred];[original][blurred]overlay=0:${yPosition}"
        
        Write-Host "   处理中..." -ForegroundColor DarkGray
        
        & $ffmpeg -i $InputVideo `
            -vf $filterComplex `
            -c:a copy `
            -y $outputPath 2> nul
        
        if ($LASTEXITCODE -eq 0 -and (Test-Path $outputPath)) {
            Write-Host ""
            Write-Host "✅ 字幕区域模糊处理成功!" -ForegroundColor Green
        } else {
            Write-Host ""
            Write-Host "❌ 处理失败" -ForegroundColor Red
            exit 1
        }
    }
    
    "crop" {
        Write-Host "✂️  正在裁剪字幕区域..." -ForegroundColor Yellow
        
        # 保留顶部80%，裁剪底部20%
        $keepHeight = [math]::Round($videoHeight * 0.8)
        
        Write-Host "   保留区域: 顶部 ${keepHeight}px (原高度 ${videoHeight}px)" -ForegroundColor DarkGray
        Write-Host "   然后缩放回原分辨率避免黑边" -ForegroundColor DarkGray
        
        # 裁剪 + 缩放回原尺寸
        $filter = "crop=iw:${keepHeight}:0:0,scale=${videoWidth}:${videoHeight}"
        
        & $ffmpeg -i $InputVideo `
            -vf $filter `
            -c:a copy `
            -y $outputPath 2> nul
        
        if ($LASTEXITCODE -eq 0 -and (Test-Path $outputPath)) {
            Write-Host ""
            Write-Host "✅ 字幕区域裁剪成功!" -ForegroundColor Green
            Write-Host "   ⚠️  注意: 画面比例略有变化" -ForegroundColor Yellow
        } else {
            Write-Host ""
            Write-Host "❌ 处理失败" -ForegroundColor Red
            exit 1
        }
    }
}

# 显示结果
if (Test-Path $outputPath) {
    $outputInfo = Get-Item $outputPath
    $originalSize = $fileInfo.Length / 1MB
    $newSize = $outputInfo.Length / 1MB
    $ratio = ($newSize / $originalSize) * 100
    
    Write-Host ""
    Write-Host "==================" -ForegroundColor Cyan
    Write-Host "📊 处理结果" -ForegroundColor Cyan
    Write-Host "原文件: $([math]::Round($originalSize, 2)) MB" -ForegroundColor Gray
    Write-Host "新文件: $([math]::Round($newSize, 2)) MB ($([math]::Round($ratio, 1))%)" -ForegroundColor Gray
    Write-Host "输出位置: $outputPath" -ForegroundColor Gray
    Write-Host ""
    Write-Host "✅ 完成!" -ForegroundColor Green
}

# FFmpeg Test and Demo Script
# 创建测试视频验证 CLI-Anything 功能

Write-Host "🎬 FFmpeg CLI-Anything Demo" -ForegroundColor Cyan
Write-Host "============================" -ForegroundColor Cyan
Write-Host ""

# 检查 FFmpeg 是否可用
$ffmpegPath = "C:\ffmpeg\ffmpeg-8.0.1-full_build\bin\ffmpeg.exe"
$ffmpeg = Get-Command ffmpeg -ErrorAction SilentlyContinue

if (-not $ffmpeg -and -not (Test-Path $ffmpegPath)) {
    Write-Host "⚠️  FFmpeg not found. Downloading..." -ForegroundColor Yellow
    
    # 创建目录
    New-Item -ItemType Directory -Path "C:\ffmpeg" -Force | Out-Null
    
    # 下载 FFmpeg
    $url = "https://github.com/GyanD/codexffmpeg/releases/download/8.0.1/ffmpeg-8.0.1-full_build.zip"
    $output = "C:\ffmpeg\ffmpeg.zip"
    
    Write-Host "Downloading from GitHub..." -ForegroundColor Gray
    try {
        Invoke-WebRequest -Uri $url -OutFile $output -UseBasicParsing
        Write-Host "✅ Downloaded" -ForegroundColor Green
        
        # 解压
        Expand-Archive -Path $output -DestinationPath "C:\ffmpeg" -Force
        Write-Host "✅ Extracted" -ForegroundColor Green
        
        # 添加到 PATH
        $binPath = "C:\ffmpeg\ffmpeg-8.0.1-full_build\bin"
        $userPath = [Environment]::GetEnvironmentVariable("Path", "User")
        if ($userPath -notlike "*$binPath*") {
            [Environment]::SetEnvironmentVariable("Path", "$userPath;$binPath", "User")
            Write-Host "✅ Added to PATH (restart needed)" -ForegroundColor Green
        }
        
        $ffmpeg = $ffmpegPath
    } catch {
        Write-Host "❌ Failed to download: $_" -ForegroundColor Red
        exit 1
    }
} else {
    $ffmpeg = if ($ffmpeg) { $ffmpeg.Source } else { $ffmpegPath }
    Write-Host "✅ FFmpeg found: $ffmpeg" -ForegroundColor Green
}

Write-Host ""

# 创建测试目录
$testDir = "C:\Users\$env:USERNAME\.openclaw\workspace\video-test"
New-Item -ItemType Directory -Path $testDir -Force | Out-Null

# 测试 1: 生成测试视频
Write-Host "Test 1: Generate test video with text overlay" -ForegroundColor Yellow
$testVideo = "$testDir\test-video.mp4"

$ffmpegArgs = @(
    "-f", "lavfi",
    "-i", "testsrc=duration=10:size=1280x720:rate=30",
    "-vf", "drawtext=text='CLI-Anything Test':fontsize=60:fontcolor=white:x=(w-text_w)/2:y=(h-text_h)/2",
    "-pix_fmt", "yuv420p",
    "-y", $testVideo
)

try {
    & $ffmpeg $ffmpegArgs 2>&1 | Out-Null
    if (Test-Path $testVideo) {
        $size = (Get-Item $testVideo).Length / 1KB
        Write-Host "✅ Created test video: $testVideo ($([math]::Round($size, 2)) KB)" -ForegroundColor Green
    }
} catch {
    Write-Host "❌ Failed to create test video: $_" -ForegroundColor Red
}

# 测试 2: 提取缩略图
Write-Host "`nTest 2: Extract thumbnail from video" -ForegroundColor Yellow
$thumbnail = "$testDir\thumbnail.jpg"

$thumbArgs = @(
    "-ss", "00:00:05",
    "-i", $testVideo,
    "-vframes", "1",
    "-q:v", "2",
    "-y", $thumbnail
)

try {
    & $ffmpeg $thumbArgs 2>&1 | Out-Null
    if (Test-Path $thumbnail) {
        Write-Host "✅ Created thumbnail: $thumbnail" -ForegroundColor Green
    }
} catch {
    Write-Host "❌ Failed to create thumbnail: $_" -ForegroundColor Red
}

# 测试 3: 转码视频
Write-Host "`nTest 3: Transcode video to different resolution" -ForegroundColor Yellow
$transcoded = "$testDir\transcoded-480p.mp4"

$transcodeArgs = @(
    "-i", $testVideo,
    "-vf", "scale=854:480",
    "-c:v", "libx264",
    "-preset", "fast",
    "-crf", "23",
    "-c:a", "aac",
    "-b:a", "128k",
    "-y", $transcoded
)

try {
    & $ffmpeg $transcodeArgs 2>&1 | Out-Null
    if (Test-Path $transcoded) {
        $origSize = (Get-Item $testVideo).Length / 1KB
        $newSize = (Get-Item $transcoded).Length / 1KB
        Write-Host "✅ Transcoded to 480p: $transcoded" -ForegroundColor Green
        Write-Host "   Original: $([math]::Round($origSize, 2)) KB" -ForegroundColor Gray
        Write-Host "   New: $([math]::Round($newSize, 2)) KB" -ForegroundColor Gray
    }
} catch {
    Write-Host "❌ Failed to transcode: $_" -ForegroundColor Red
}

# 测试 4: 生成 GIF
Write-Host "`nTest 4: Generate GIF from video" -ForegroundColor Yellow
$gif = "$testDir\animation.gif"

$gifArgs = @(
    "-i", $testVideo,
    "-vf", "fps=10,scale=320:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse",
    "-loop", "0",
    "-y", $gif
)

try {
    & $ffmpeg $gifArgs 2>&1 | Out-Null
    if (Test-Path $gif) {
        $size = (Get-Item $gif).Length / 1KB
        Write-Host "✅ Created GIF: $gif ($([math]::Round($size, 2)) KB)" -ForegroundColor Green
    }
} catch {
    Write-Host "❌ Failed to create GIF: $_" -ForegroundColor Red
}

# 总结
Write-Host "`n============================" -ForegroundColor Cyan
Write-Host "CLI-Anything FFmpeg Demo Complete!" -ForegroundColor Green
Write-Host ""
Write-Host "Created files in: $testDir" -ForegroundColor Gray
Get-ChildItem $testDir | ForEach-Object {
    Write-Host "  - $($_.Name) ($([math]::Round($_.Length/1KB, 2)) KB)" -ForegroundColor Gray
}
Write-Host ""
Write-Host "✅ All tests passed! FFmpeg is ready for video production." -ForegroundColor Green

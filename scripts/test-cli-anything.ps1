# CLI-Anything 测试脚本
# 测试本地命令执行和视频处理功能

Write-Host "🧪 CLI-Anything 功能测试" -ForegroundColor Cyan
Write-Host "========================" -ForegroundColor Cyan
Write-Host ""

# 测试 1: 基础命令执行
Write-Host "Test 1: 基础命令执行" -ForegroundColor Yellow
Write-Host "--------------------"

try {
    $result = Get-Date
    Write-Host "✅ PowerShell 运行正常: $result" -ForegroundColor Green
} catch {
    Write-Host "❌ 错误: $_" -ForegroundColor Red
}

Write-Host ""

# 测试 2: 文件操作
Write-Host "Test 2: 文件操作" -ForegroundColor Yellow
Write-Host "----------------"

$testDir = "C:\Users\$env:USERNAME\.openclaw\workspace\test-cli-anything"
$testFile = "$testDir\test.txt"

try {
    # 创建目录
    New-Item -ItemType Directory -Path $testDir -Force | Out-Null
    Write-Host "✅ 创建目录: $testDir" -ForegroundColor Green
    
    # 创建文件
    "CLI-Anything test file" | Out-File -FilePath $testFile -Encoding UTF8
    Write-Host "✅ 创建文件: $testFile" -ForegroundColor Green
    
    # 读取文件
    $content = Get-Content $testFile
    Write-Host "✅ 读取文件内容: $content" -ForegroundColor Green
    
    # 删除测试文件
    Remove-Item $testDir -Recurse -Force
    Write-Host "✅ 清理测试文件" -ForegroundColor Green
} catch {
    Write-Host "❌ 错误: $_" -ForegroundColor Red
}

Write-Host ""

# 测试 3: FFmpeg 检查
Write-Host "Test 3: FFmpeg 视频处理工具" -ForegroundColor Yellow
Write-Host "----------------------------"

try {
    $ffmpeg = Get-Command ffmpeg -ErrorAction Stop
    Write-Host "✅ FFmpeg 已安装: $($ffmpeg.Source)" -ForegroundColor Green
    
    # 获取版本
    $version = & ffmpeg -version 2>&1 | Select-Object -First 1
    Write-Host "   版本: $version" -ForegroundColor Gray
} catch {
    Write-Host "⚠️  FFmpeg 未安装" -ForegroundColor Yellow
    Write-Host "   安装命令: winget install Gyan.FFmpeg" -ForegroundColor Gray
}

Write-Host ""

# 测试 4: Git 检查
Write-Host "Test 4: Git 版本控制" -ForegroundColor Yellow
Write-Host "--------------------"

try {
    $git = Get-Command git -ErrorAction Stop
    Write-Host "✅ Git 已安装: $($git.Source)" -ForegroundColor Green
    
    $version = & git --version
    Write-Host "   版本: $version" -ForegroundColor Gray
} catch {
    Write-Host "⚠️  Git 未安装" -ForegroundColor Yellow
    Write-Host "   安装命令: winget install Git.Git" -ForegroundColor Gray
}

Write-Host ""

# 测试 5: Python 检查（CLI-Anything 需要）
Write-Host "Test 5: Python（CLI-Anything 依赖）" -ForegroundColor Yellow
Write-Host "------------------------------------"

try {
    $python = Get-Command python -ErrorAction Stop
    Write-Host "✅ Python 已安装: $($python.Source)" -ForegroundColor Green
    
    $version = & python --version 2>&1
    Write-Host "   版本: $version" -ForegroundColor Gray
} catch {
    Write-Host "⚠️  Python 未安装" -ForegroundColor Yellow
    Write-Host "   安装命令: winget install Python.Python.3.11" -ForegroundColor Gray
}

Write-Host ""

# 测试 6: 环境变量
Write-Host "Test 6: 环境变量检查" -ForegroundColor Yellow
Write-Host "--------------------"

$vars = @("OPENCLAW_HOME", "WORKSPACE", "Path")
foreach ($var in $vars) {
    $value = [Environment]::GetEnvironmentVariable($var, "User")
    if ($value) {
        if ($value.Length -gt 50) {
            $value = $value.Substring(0, 50) + "..."
        }
        Write-Host "✅ $var = $value" -ForegroundColor Green
    } else {
        Write-Host "⚠️  $var 未设置" -ForegroundColor Yellow
    }
}

Write-Host ""

# 测试 7: 工作目录结构
Write-Host "Test 7: 工作目录结构" -ForegroundColor Yellow
Write-Host "--------------------"

$workspace = "C:\Users\$env:USERNAME\.openclaw\workspace"
$folders = @(
    "memory\hot",
    "memory\warm",
    "skills",
    "scripts"
)

foreach ($folder in $folders) {
    $path = Join-Path $workspace $folder
    if (Test-Path $path) {
        Write-Host "✅ $folder 存在" -ForegroundColor Green
    } else {
        Write-Host "⚠️  $folder 不存在" -ForegroundColor Yellow
    }
}

Write-Host ""

# 总结
Write-Host "========================" -ForegroundColor Cyan
Write-Host "测试完成！" -ForegroundColor Green
Write-Host ""
Write-Host "下一步:" -ForegroundColor Yellow
Write-Host "1. 安装缺失的工具（FFmpeg、Python等）" -ForegroundColor Gray
Write-Host "2. 克隆 CLI-Anything 仓库" -ForegroundColor Gray
Write-Host "3. 运行视频制作工作流" -ForegroundColor Gray

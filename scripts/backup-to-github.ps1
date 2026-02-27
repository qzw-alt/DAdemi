# 德米记忆自动备份脚本
# 运行时间：每天 23:30
# 备份目标：GitHub (qzw-alt/DAdemi)
# 核心文件：MEMORY.md, SOUL.md, AGENTS.md, USER.md, IDENTITY.md, TOOLS.md, SKILL.md

param(
    [switch]$Silent = $false
)

$ErrorActionPreference = "Stop"
$workspace = "C:\Users\csdm2\.openclaw\workspace"
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$dateStr = Get-Date -Format "yyyyMMdd"

# 核心文件列表（必须备份）
$coreFiles = @(
    "MEMORY.md",      # 长期记忆
    "SOUL.md",        # 灵魂/人设文件 ⭐
    "AGENTS.md",      # 工作空间配置
    "USER.md",        # 用户信息
    "IDENTITY.md",    # 身份定义
    "TOOLS.md",       # 工具配置
    "HEARTBEAT.md",   # 心跳任务
    "BOOTSTRAP.md",   # 启动指南
    ".gitignore"      # Git配置
)

function Write-Log {
    param([string]$Message)
    $log = "[$timestamp] $Message"
    if (-not $Silent) { Write-Host $log }
    Add-Content -Path "$workspace\.backup.log" -Value $log -ErrorAction SilentlyContinue
}

try {
    Set-Location $workspace
    
    Write-Log "开始每日备份..."
    
    # 确保核心文件都在跟踪中
    foreach ($file in $coreFiles) {
        if (Test-Path $file) {
            git add $file 2>$null
        }
    }
    
    # 添加 memory 目录所有文件
    if (Test-Path "memory") {
        git add memory/ 2>$null
    }
    
    # 添加 skills_custom 目录
    if (Test-Path "skills_custom") {
        git add skills_custom/ 2>$null
    }
    
    # 添加 scripts 目录
    if (Test-Path "scripts") {
        git add scripts/ 2>$null
    }
    
    # 检查是否有变更
    $status = git status --porcelain 2>$null
    
    if ([string]::IsNullOrWhiteSpace($status)) {
        Write-Log "没有新变更，无需备份"
        exit 0
    }
    
    $changeCount = ($status -split "`n").Count
    Write-Log "发现 $changeCount 个变更文件"
    
    # 提交
    git commit -m "Auto backup: $timestamp [SOUL.md included]" 2>$null | Out-Null
    Write-Log "已提交到本地仓库 (包含 SOUL.md)"
    
    # 推送到 GitHub
    $pushOutput = git push origin main 2>&1
    if ($pushOutput -match "error|fatal") {
        throw "Push failed: $pushOutput"
    }
    
    Write-Log "✅ 备份成功！已推送到 GitHub"
    
} catch {
    Write-Log "❌ 备份失败: $_"
    exit 1
}

# morning-check.ps1
# 医疗旅游项目每日晨检脚本（PowerShell版）

Write-Host ""
Write-Host "🏥 ===========================================" -ForegroundColor Cyan
Write-Host "   Medical Tourism Project - Morning Check" -ForegroundColor Cyan
Write-Host "   $(Get-Date -Format 'yyyy-MM-dd HH:mm')" -ForegroundColor Cyan
Write-Host "   ===========================================" -ForegroundColor Cyan
Write-Host ""

$Workspace = "$env:USERPROFILE\.openclaw\workspace"
$MemoryDir = "$Workspace\memory"
$Today = Get-Date -Format "yyyy-MM-dd"

Write-Host "📅 Today: $Today" -ForegroundColor Yellow
Write-Host "📂 Workspace: $Workspace"
Write-Host ""

# Check memory directory
if (-not (Test-Path $MemoryDir)) {
    Write-Host "[ERROR] Memory directory not found" -ForegroundColor Red
    exit 1
}

Write-Host "🔥 PART 1: Active Tasks" -ForegroundColor Yellow
Write-Host "----------------------------------------"
$HotFile = "$MemoryDir\hot\HOT_MEMORY.md"
if (Test-Path $HotFile) {
    $content = Get-Content $HotFile -Raw
    # Extract tasks
    $tasks = $content | Select-String -Pattern "\- \[.\] (.+)" -AllMatches
    if ($tasks) {
        $tasks.Matches | Select-Object -First 5 | ForEach-Object {
            Write-Host "   $($_.Groups[1].Value)"
        }
    } else {
        Write-Host "   (No active tasks)"
    }
} else {
    Write-Host "   ⚠️ HOT_MEMORY.md not found" -ForegroundColor Red
}
Write-Host ""

Write-Host "⏰ PART 2: Today's Log" -ForegroundColor Yellow
Write-Host "----------------------------------------"
$TodayFile = "$MemoryDir\$Today.md"
if (Test-Path $TodayFile) {
    Write-Host "   ✅ Today's log exists" -ForegroundColor Green
    # Show completed tasks
    $content = Get-Content $TodayFile -Raw
    $completed = $content | Select-String -Pattern "\- \[x\] (.+)" -AllMatches
    if ($completed) {
        Write-Host "   Completed:"
        $completed.Matches | Select-Object -First 3 | ForEach-Object {
            Write-Host "     ✓ $($_.Groups[1].Value)"
        }
    }
    # Show pending tasks
    $pending = $content | Select-String -Pattern "\- \[ \] (.+)" -AllMatches
    if ($pending) {
        Write-Host "   Pending:"
        $pending.Matches | Select-Object -First 3 | ForEach-Object {
            Write-Host "     ☐ $($_.Groups[1].Value)"
        }
    }
} else {
    Write-Host "   ⚠️ Today's log not created" -ForegroundColor Yellow
    Write-Host "   Create at: $TodayFile"
}
Write-Host ""

Write-Host "🚨 PART 3: P0 Urgent Items" -ForegroundColor Yellow
Write-Host "----------------------------------------"
if (Test-Path $HotFile) {
    $content = Get-Content $HotFile -Raw
    $urgent = $content | Select-String -Pattern "P0|URGENT|🔥" -AllMatches
    if ($urgent) {
        $urgent.Matches | ForEach-Object {
            Write-Host "   $($_.Value)" -ForegroundColor Red
        }
    } else {
        Write-Host "   ✅ No P0 urgent items" -ForegroundColor Green
    }
} else {
    Write-Host "   ⚠️ Cannot read HOT_MEMORY.md" -ForegroundColor Red
}
Write-Host ""

Write-Host "📚 PART 4: Knowledge Base" -ForegroundColor Yellow
Write-Host "----------------------------------------"
$KnowledgeFile = "$Workspace\medical-tourism-knowledge-summary.md"
if (Test-Path $KnowledgeFile) {
    $size = (Get-Item $KnowledgeFile).Length
    Write-Host "   ✅ Knowledge summary exists ($size bytes)" -ForegroundColor Green
} else {
    Write-Host "   ❌ Knowledge summary missing" -ForegroundColor Red
}
Write-Host ""

Write-Host "🛠️  PART 5: Skills Check" -ForegroundColor Yellow
Write-Host "----------------------------------------"
$SkillsDir = "$Workspace\skills"
if (Test-Path $SkillsDir) {
    Write-Host "   Installed skills:"
    Get-ChildItem $SkillsDir -Directory | Where-Object { 
        $_.Name -match "web-search|multi-search|tavily|feishu|github" 
    } | ForEach-Object {
        Write-Host "     • $($_.Name)"
    }
} else {
    Write-Host "   ⚠️ Skills directory not found" -ForegroundColor Red
}
Write-Host ""

Write-Host "✅ Morning check complete!" -ForegroundColor Green
Write-Host "============================================"
Write-Host "Next steps:"
Write-Host "1. Handle P0 items if any"
if (-not (Test-Path $TodayFile)) {
    Write-Host "2. ⚠️ CREATE today's log: $TodayFile" -ForegroundColor Yellow
} else {
    Write-Host "2. ✅ Today's log exists" -ForegroundColor Green
}
Write-Host "3. Start working on current tasks"
Write-Host "============================================"

# Log the check
$LogEntry = "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') - Morning check completed"
Add-Content -Path "$MemoryDir\checkin.log" -Value $LogEntry -ErrorAction SilentlyContinue

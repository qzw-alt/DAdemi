# Agent Backup - PowerShell Script
# Complete backup and restore solution for OpenClaw Agent

param(
    [Parameter(Position=0)]
    [string]$Command,
    
    [Parameter(Position=1)]
    [string]$Name
)

# Configuration paths
$OpenClawHome = "$env:USERPROFILE\.openclaw"
$BackupDir = "$env:USERPROFILE\.openclaw\backups"
$WorkspaceDir = "$env:USERPROFILE\.openclaw\workspace"
$ConfigFile = "$env:USERPROFILE\.openclaw\openclaw.json"
$CredentialsDir = "$env:USERPROFILE\.openclaw\credentials"

# Ensure backup directory exists
function Ensure-BackupDir {
    if (-not (Test-Path $BackupDir)) {
        New-Item -ItemType Directory -Path $BackupDir -Force | Out-Null
        Write-Host "[OK] Created backup directory: $BackupDir" -ForegroundColor Green
    }
}

# Get current timestamp
function Get-Timestamp {
    return Get-Date -Format "yyyyMMdd_HHmmss"
}

# Create backup
function Create-Backup {
    param([string]$CustomName = "")
    
    Ensure-BackupDir
    
    $timestamp = Get-Timestamp
    if ([string]::IsNullOrWhiteSpace($CustomName)) {
        $backupName = "backup_$timestamp"
    } else {
        $backupName = "$($CustomName)_$timestamp"
    }
    
    $backupPath = Join-Path $BackupDir $backupName
    
    Write-Host ""
    Write-Host "[INFO] Creating backup: $backupName" -ForegroundColor Cyan
    
    try {
        New-Item -ItemType Directory -Path $backupPath -Force | Out-Null
        New-Item -ItemType Directory -Path "$backupPath\workspace" -Force | Out-Null
        New-Item -ItemType Directory -Path "$backupPath\credentials" -Force | Out-Null
        
        if (Test-Path $WorkspaceDir) {
            Copy-Item -Path "$WorkspaceDir\*" -Destination "$backupPath\workspace" -Recurse -Force
            Write-Host "  [OK] Workspace backed up" -ForegroundColor Green
        }
        
        if (Test-Path $ConfigFile) {
            Copy-Item -Path $ConfigFile -Destination "$backupPath\openclaw.json" -Force
            Write-Host "  [OK] Config backed up" -ForegroundColor Green
        }
        
        if (Test-Path $CredentialsDir) {
            $credFiles = Get-ChildItem -Path $CredentialsDir -Filter "*.json" -ErrorAction SilentlyContinue
            foreach ($file in $credFiles) {
                $content = Get-Content $file.FullName -Raw
                $content = $content -replace '"([^"]*(?:api_key|secret|token)[^"]*)"\s*:\s*"[^"]*"', '"$1": "***REDACTED***"'
                $content | Set-Content -Path "$backupPath\credentials\$($file.Name)"
            }
            Write-Host "  [OK] Credentials backed up (redacted)" -ForegroundColor Green
        }
        
        $backupInfo = @{
            name = $backupName
            createdAt = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
            createdBy = $env:USERNAME
            version = "1.0.0"
        } | ConvertTo-Json
        
        $backupInfo | Set-Content -Path "$backupPath\backup-info.json"
        
        # Compress backup - use .NET directly to avoid path issues
        $zipPath = "$backupPath.zip"
        Add-Type -AssemblyName System.IO.Compression.FileSystem
        [System.IO.Compression.ZipFile]::CreateFromDirectory($backupPath, $zipPath)
        Remove-Item -Path $backupPath -Recurse -Force
        Write-Host "  [OK] Backup compressed" -ForegroundColor Green
        
        Write-Host ""
        Write-Host "[SUCCESS] Backup created!" -ForegroundColor Green
        Write-Host "  Location: $zipPath" -ForegroundColor Gray
        
        return $backupName
    }
    catch {
        Write-Host ""
        Write-Host "[ERROR] Backup failed: $_" -ForegroundColor Red
        return $null
    }
}

# List backups
function List-Backups {
    Ensure-BackupDir
    
    $backups = Get-ChildItem -Path $BackupDir -Filter "*.zip" -ErrorAction SilentlyContinue | Sort-Object LastWriteTime -Descending
    
    if (-not $backups -or $backups.Count -eq 0) {
        Write-Host ""
        Write-Host "[INFO] No backups found" -ForegroundColor Yellow
        return
    }
    
    Write-Host ""
    Write-Host "[INFO] Backup List:" -ForegroundColor Cyan
    Write-Host ("-" * 60)
    
    foreach ($backup in $backups) {
        $sizeMB = [math]::Round($backup.Length / 1MB, 2)
        $date = $backup.LastWriteTime.ToString("yyyy-MM-dd HH:mm")
        $name = $backup.BaseName
        
        Write-Host "  Package: $name" -ForegroundColor White
        Write-Host "    Size: $sizeMB MB | Date: $date" -ForegroundColor Gray
    }
    
    Write-Host ("-" * 60)
    Write-Host "Total: $($backups.Count) backups" -ForegroundColor Gray
}

# Restore backup
function Restore-Backup {
    param([string]$BackupName)
    
    if ([string]::IsNullOrWhiteSpace($BackupName)) {
        Write-Host ""
        Write-Host "[ERROR] Please specify backup name" -ForegroundColor Red
        Write-Host ""
        List-Backups
        return
    }
    
    $zipPath = Join-Path $BackupDir "$BackupName.zip"
    
    if (-not (Test-Path $zipPath)) {
        Write-Host ""
        Write-Host "[ERROR] Backup not found: $BackupName" -ForegroundColor Red
        Write-Host ""
        List-Backups
        return
    }
    
    Write-Host ""
    Write-Host "[WARNING] This will overwrite current configuration!" -ForegroundColor Yellow
    Write-Host "  Backup to restore: $BackupName" -ForegroundColor Cyan
    Write-Host ""
    
    $confirm = Read-Host "Type 'yes' to confirm restore"
    if ($confirm -ne "yes") {
        Write-Host ""
        Write-Host "[CANCELLED]" -ForegroundColor Yellow
        return
    }
    
    try {
        Write-Host ""
        Write-Host "[INFO] Creating safety backup of current state..." -ForegroundColor Gray
        $tempBackup = Create-Backup -CustomName "auto_before_restore"
        
        $extractPath = Join-Path $BackupDir "_restore_temp"
        if (Test-Path $extractPath) {
            Remove-Item -Path $extractPath -Recurse -Force
        }
        
        Expand-Archive -Path $zipPath -DestinationPath $extractPath -Force
        $extractedDir = Get-ChildItem -Path $extractPath -Directory | Select-Object -First 1
        
        if (Test-Path "$($extractedDir.FullName)\workspace") {
            if (Test-Path $WorkspaceDir) {
                Remove-Item -Path $WorkspaceDir -Recurse -Force
            }
            Copy-Item -Path "$($extractedDir.FullName)\workspace" -Destination $WorkspaceDir -Recurse -Force
            Write-Host "  [OK] Workspace restored" -ForegroundColor Green
        }
        
        if (Test-Path "$($extractedDir.FullName)\openclaw.json") {
            Copy-Item -Path "$($extractedDir.FullName)\openclaw.json" -Destination $ConfigFile -Force
            Write-Host "  [OK] Config restored" -ForegroundColor Green
        }
        
        Remove-Item -Path $extractPath -Recurse -Force
        
        Write-Host ""
        Write-Host "[SUCCESS] Restore completed!" -ForegroundColor Green
        Write-Host "  Restart OpenClaw Gateway to apply all changes" -ForegroundColor Yellow
    }
    catch {
        Write-Host ""
        Write-Host "[ERROR] Restore failed: $_" -ForegroundColor Red
    }
}

# Delete backup
function Delete-Backup {
    param([string]$BackupName)
    
    if ([string]::IsNullOrWhiteSpace($BackupName)) {
        Write-Host ""
        Write-Host "[ERROR] Please specify backup name" -ForegroundColor Red
        return
    }
    
    $zipPath = Join-Path $BackupDir "$BackupName.zip"
    
    if (-not (Test-Path $zipPath)) {
        Write-Host ""
        Write-Host "[ERROR] Backup not found: $BackupName" -ForegroundColor Red
        return
    }
    
    Write-Host ""
    $confirm = Read-Host "Delete backup '$BackupName'? (yes/no)"
    if ($confirm -eq "yes") {
        Remove-Item -Path $zipPath -Force
        Write-Host ""
        Write-Host "[DELETED] $BackupName" -ForegroundColor Yellow
    } else {
        Write-Host ""
        Write-Host "[CANCELLED]" -ForegroundColor Gray
    }
}

# Show backup info
function Show-BackupInfo {
    param([string]$BackupName)
    
    if ([string]::IsNullOrWhiteSpace($BackupName)) {
        Write-Host ""
        Write-Host "[ERROR] Please specify backup name" -ForegroundColor Red
        return
    }
    
    $zipPath = Join-Path $BackupDir "$BackupName.zip"
    
    if (-not (Test-Path $zipPath)) {
        Write-Host ""
        Write-Host "[ERROR] Backup not found: $BackupName" -ForegroundColor Red
        return
    }
    
    $extractPath = Join-Path $BackupDir "_info_temp"
    if (Test-Path $extractPath) {
        Remove-Item -Path $extractPath -Recurse -Force
    }
    
    try {
        Expand-Archive -Path $zipPath -DestinationPath $extractPath -Force
        $extractedDir = Get-ChildItem -Path $extractPath -Directory | Select-Object -First 1
        $infoFile = "$($extractedDir.FullName)\backup-info.json"
        
        if (Test-Path $infoFile) {
            $info = Get-Content $infoFile -Raw | ConvertFrom-Json
            Write-Host ""
            Write-Host "[INFO] Backup Information: $BackupName" -ForegroundColor Cyan
            Write-Host ("-" * 40)
            Write-Host "Name: $($info.name)" -ForegroundColor White
            Write-Host "Created: $($info.createdAt)" -ForegroundColor White
            Write-Host "By: $($info.createdBy)" -ForegroundColor White
            Write-Host "Version: $($info.version)" -ForegroundColor White
            Write-Host ("-" * 40)
        } else {
            Write-Host ""
            Write-Host "[WARNING] No info file in this backup" -ForegroundColor Yellow
        }
    }
    catch {
        Write-Host ""
        Write-Host "[ERROR] Cannot read backup info" -ForegroundColor Red
    }
    finally {
        if (Test-Path $extractPath) {
            Remove-Item -Path $extractPath -Recurse -Force -ErrorAction SilentlyContinue
        }
    }
}

# Show help
function Show-Help {
    Write-Host ""
    Write-Host "Agent Backup - OpenClaw Agent Backup Tool" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Usage:" -ForegroundColor White
    Write-Host "  agent-backup command [name]" -ForegroundColor Gray
    Write-Host ""
    Write-Host "Commands:" -ForegroundColor White
    Write-Host "  create [name]  Create new backup" -ForegroundColor Gray
    Write-Host "  list           List all backups" -ForegroundColor Gray
    Write-Host "  restore name   Restore specified backup" -ForegroundColor Gray
    Write-Host "  delete name    Delete specified backup" -ForegroundColor Gray
    Write-Host "  info name      Show backup information" -ForegroundColor Gray
    Write-Host "  help           Show this help" -ForegroundColor Gray
    Write-Host ""
    Write-Host "Examples:" -ForegroundColor White
    Write-Host "  agent-backup create              Create timestamped backup" -ForegroundColor Gray
    Write-Host "  agent-backup create baseline     Create named backup" -ForegroundColor Gray
    Write-Host "  agent-backup list                Show backup list" -ForegroundColor Gray
    Write-Host "  agent-backup restore backup_20240226_120000" -ForegroundColor Gray
    Write-Host ""
}

# Main
if (-not $Command) {
    Show-Help
    exit
}

switch ($Command.ToLower()) {
    "create" { Create-Backup -CustomName $Name }
    "list" { List-Backups }
    "restore" { Restore-Backup -BackupName $Name }
    "delete" { Delete-Backup -BackupName $Name }
    "info" { Show-BackupInfo -BackupName $Name }
    "help" { Show-Help }
    default { Show-Help }
}

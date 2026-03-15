@echo off
chcp 65001 > nul
REM auto-backup.bat
REM 每日自动备份脚本 - 备份workspace到GitHub

echo 🔒 ===========================================
echo    每日自动备份
echo    %date% %time%
echo    ===========================================
echo.

set WORKSPACE=%USERPROFILE%\.openclaw\workspace
set BACKUP_REPO=https://github.com/qzw-alt/DAdemi.git

cd /d %WORKSPACE%

REM 检查Git是否安装
git --version > nul 2>&1
if errorlevel 1 (
    echo ❌ 错误: Git未安装
    exit /b 1
)

REM 检查是否有Git仓库
if not exist ".git" (
    echo 📂 初始化Git仓库...
    git init
    git remote add origin %BACKUP_REPO%
    echo ✅ Git仓库初始化完成
    echo.
)

REM 检查GitHub Token是否有效
git ls-remote %BACKUP_REPO% > nul 2>&1
if errorlevel 1 (
    echo ⚠️  警告: GitHub Token可能已过期
    echo    请找伟烨获取新Token并更新git remote
    echo.
    echo    更新命令:
    echo    git remote set-url origin https://TOKEN@github.com/qzw-alt/DAdemi.git
    echo.
    set BACKUP_STATUS=token_expired
    goto :end
)

REM 显示当前状态
echo 📊 当前Git状态:
git status --short
echo.

REM 添加所有更改
echo 📦 添加更改...
git add .

REM 检查是否有更改要提交
git diff --cached --quiet
if errorlevel 1 (
    echo 📝 提交更改...
    git commit -m "Daily backup: %date% %time%"
    
    echo ☁️  推送到GitHub...
    git push origin main
    
    if errorlevel 1 (
        echo ❌ 推送失败
        set BACKUP_STATUS=push_failed
    ) else (
        echo ✅ 备份成功！
        set BACKUP_STATUS=success
    )
) else (
    echo ℹ️  没有需要备份的更改
    set BACKUP_STATUS=no_changes
)

:end
echo.
echo ----------------------------------------

if "%BACKUP_STATUS%"=="success" (
    echo ✅ 备份完成
    echo    时间: %date% %time%
    echo    位置: %BACKUP_REPO%
) else if "%BACKUP_STATUS%"=="no_changes" (
    echo ℹ️  无需备份（无更改）
) else if "%BACKUP_STATUS%"=="token_expired" (
    echo ⚠️  备份失败: Token过期
    echo    请更新GitHub Token后重试
) else (
    echo ❌ 备份失败
    echo    请检查网络连接和Git配置
)

echo.
echo 💡 提示: 建议每晚23:30运行此脚本
pause

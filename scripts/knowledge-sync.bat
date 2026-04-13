@echo off
chcp 65001 > nul
REM knowledge-sync.bat
REM 医疗旅游知识库同步脚本（Windows版）

echo 🔄 ===========================================
echo    医疗旅游知识库同步
echo    ===========================================
echo.

set REPO_URL=https://github.com/qzw-alt/medical-tourism-notes.git
set LOCAL_PATH=%USERPROFILE%\.openclaw\workspace\medical-tourism-notes

echo 📂 本地路径: %LOCAL_PATH%
echo 🌐 远程仓库: %REPO_URL%
echo.

REM 检查Git是否安装
git --version > nul 2>&1
if errorlevel 1 (
    echo ❌ 错误: Git未安装
    echo 请从 https://git-scm.com/download/win 下载安装
    exit /b 1
)

REM 同步操作
cd /d %USERPROFILE%\.openclaw\workspace

if exist "%LOCAL_PATH%\.git" (
    echo 📂 知识库已存在，执行更新...
    cd /d "%LOCAL_PATH%"
    git pull origin main
    if errorlevel 1 (
        echo ❌ 更新失败
        set SYNC_STATUS=failed
    ) else (
        echo ✅ 更新成功
        set SYNC_STATUS=success
    )
) else (
    echo 📂 知识库不存在，执行克隆...
    
    REM 提示用户输入Token
    echo.
    echo 💡 提示: 需要GitHub Personal Access Token
    echo    请从伟烨处获取最新Token
    echo.
    
    git clone "%REPO_URL%" "%LOCAL_PATH%"
    if errorlevel 1 (
        echo ❌ 克隆失败
        echo 可能原因: 仓库是私有的，需要Token
        set SYNC_STATUS=failed
    ) else (
        echo ✅ 克隆成功
        set SYNC_STATUS=success
    )
)

echo.
echo ----------------------------------------

if "%SYNC_STATUS%"=="success" (
    echo ✅ 同步完成
    echo.
    echo 📊 知识库统计:
    cd /d "%LOCAL_PATH%"
    echo    文件数: 
    dir /s /b | find /c /v ""
    echo    最后提交:
    git log -1 --pretty=format:"%%h - %%s (%%cr)"
    echo.
    echo 💡 建议: 运行晨检脚本查看最新任务
) else (
    echo ❌ 同步失败，请检查:
    echo    - GitHub Token是否有效
    echo    - 网络连接是否正常
    echo    - 仓库地址是否正确
)

echo.

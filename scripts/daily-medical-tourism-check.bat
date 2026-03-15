@echo off
chcp 65001 > nul
REM daily-medical-tourism-check.bat - 修复版
REM 医疗旅游项目每日晨检脚本（Windows纯命令版）

echo.
echo 🏥 ===========================================
echo    医疗旅游项目晨检
echo    %date% %time:~0,8%
echo    ===========================================
echo.

set WORKSPACE=C:\Users\csdm2\.openclaw\workspace
set MEMORY_DIR=%WORKSPACE%\memory
set TODAY=%date:~0,4%-%date:~5,2%-%date:~8,2%

echo 📅 今日日期: %TODAY%
echo 📂 工作目录: %WORKSPACE%
echo.

REM 检查记忆目录
if not exist "%MEMORY_DIR%" (
    echo [错误] 记忆目录不存在
    exit /b 1
)

echo 🔥 第一部分：当前活跃任务
echo ----------------------------------------
if exist "%MEMORY_DIR%\hot\HOT_MEMORY.md" (
    type "%MEMORY_DIR%\hot\HOT_MEMORY.md" | findstr "🔥 \- \[ \*" | findstr /V "---" 2>nul
    if errorlevel 1 echo    (暂无活跃任务)
) else (
    echo    ⚠️ HOT_MEMORY.md 不存在
)
echo.

echo ⏰ 第二部分：今日待办
echo ----------------------------------------
set TODAY_FILE=%MEMORY_DIR%\%TODAY%.md
if exist "%TODAY_FILE%" (
    echo    ✅ 今日日志已创建
    type "%TODAY_FILE%" | findstr "\- \[ \[x\]" 2>nul
    type "%TODAY_FILE%" | findstr "\- \[ \[ \]" 2>nul
) else (
    echo    ⚠️ 今日日志不存在 - 建议立即创建
)
echo.

echo 🚨 第三部分：P0紧急事项
echo ----------------------------------------
if exist "%MEMORY_DIR%\hot\HOT_MEMORY.md" (
    type "%MEMORY_DIR%\hot\HOT_MEMORY.md" | findstr "P0\|紧急\|🔥" 2>nul
    if errorlevel 1 echo    ✅ 暂无P0紧急事项
) else (
    echo    ⚠️ 无法读取HOT_MEMORY.md
)
echo.

echo 📚 第四部分：知识库状态
echo ----------------------------------------
set KNOWLEDGE_FILE=%WORKSPACE%\medical-tourism-knowledge-summary.md
if exist "%KNOWLEDGE_FILE%" (
    echo    ✅ 知识总结已存在
    for %%F in ("%KNOWLEDGE_FILE%") do echo    大小: %%~zF bytes
) else (
    echo    ❌ 知识总结不存在
)
echo.

echo 🛠️ 第五部分：技能检查
echo ----------------------------------------
set SKILLS_DIR=%WORKSPACE%\skills
if exist "%SKILLS_DIR%" (
    echo    已安装技能:
    dir /b "%SKILLS_DIR%" 2>nul | findstr "web-search multi-search tavily feishu github" 
) else (
    echo    ⚠️ 技能目录不存在
)
echo.

echo ✅ 晨检完成！
echo ============================================
echo 下一步建议:
echo 1. 如有P0事项，立即处理
if not exist "%TODAY_FILE%" (
    echo 2. ⚠️ 创建今日日志: %TODAY_FILE%
) else (
    echo 2. ✅ 今日日志已创建
)
echo 3. 开始处理当前任务
echo ============================================

REM 记录检查时间
echo %date% %time:~0,8% - 晨检完成 >> "%MEMORY_DIR%\checkin.log"

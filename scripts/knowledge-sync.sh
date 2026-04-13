#!/bin/bash
# knowledge-sync.sh
# 医疗旅游知识库同步脚本
# 自动从GitHub同步最新知识

REPO_URL="https://github.com/qzw-alt/medical-tourism-notes.git"
LOCAL_PATH="${HOME}/.openclaw/workspace/medical-tourism-notes"
TOKEN_FILE="${HOME}/.openclaw/workspace/.github_token"

echo "🔄 ==========================================="
echo "   医疗旅游知识库同步"
echo "   ==========================================="
echo ""

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# 检查Git是否安装
if ! command -v git &> /dev/null; then
    echo -e "${RED}❌ 错误: Git未安装${NC}"
    exit 1
fi

# 检查Token
if [ -f "${TOKEN_FILE}" ]; then
    TOKEN=$(cat "${TOKEN_FILE}")
    AUTH_URL="https://${TOKEN}@github.com/qzw-alt/medical-tourism-notes.git"
else
    echo -e "${YELLOW}⚠️  未找到GitHub Token文件，使用公开URL${NC}"
    AUTH_URL="${REPO_URL}"
fi

# 同步操作
cd "${HOME}/.openclaw/workspace" || exit 1

if [ -d "${LOCAL_PATH}/.git" ]; then
    echo "📂 知识库已存在，执行更新..."
    cd "${LOCAL_PATH}"
    
    # 保存本地修改（如果有）
    git stash
    
    # 拉取最新
    if git pull origin main; then
        echo -e "${GREEN}✅ 更新成功${NC}"
        SYNC_STATUS="success"
    else
        echo -e "${RED}❌ 更新失败${NC}"
        SYNC_STATUS="failed"
    fi
    
    # 恢复本地修改
    git stash pop 2>/dev/null || true
else
    echo "📂 知识库不存在，执行克隆..."
    if [ -n "${TOKEN}" ]; then
        git clone "${AUTH_URL}" "${LOCAL_PATH}"
    else
        echo -e "${YELLOW}⚠️  需要Token才能克隆私有仓库${NC}"
        exit 1
    fi
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ 克隆成功${NC}"
        SYNC_STATUS="success"
    else
        echo -e "${RED}❌ 克隆失败${NC}"
        SYNC_STATUS="failed"
    fi
fi

# 记录同步日志
LOG_FILE="${HOME}/.openclaw/workspace/memory/knowledge-sync.log"
mkdir -p "$(dirname "${LOG_FILE}")"
echo "$(date '+%Y-%m-%d %H:%M:%S')|${SYNC_STATUS}|$(cd ${LOCAL_PATH} && git log -1 --pretty=format:'%h' 2>/dev/null || echo 'unknown')" >> "${LOG_FILE}"

echo ""
echo "----------------------------------------"

if [ "${SYNC_STATUS}" = "success" ]; then
    echo -e "${GREEN}✅ 同步完成${NC}"
    echo ""
    echo "📊 知识库统计:"
    cd "${LOCAL_PATH}"
    echo "   文件数: $(find . -type f | wc -l)"
    echo "   最后提交: $(git log -1 --pretty=format:'%h - %s (%cr)')"
    echo "   提交者: $(git log -1 --pretty=format:'%an')"
    echo ""
    echo "💡 建议: 运行晨检脚本查看最新任务"
else
    echo -e "${RED}❌ 同步失败，请检查:${NC}"
    echo "   - GitHub Token是否有效"
    echo "   - 网络连接是否正常"
    echo "   - 仓库地址是否正确"
fi

echo ""
echo "📝 同步日志: ${LOG_FILE}"

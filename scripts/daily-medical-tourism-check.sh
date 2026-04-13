#!/bin/bash
# daily-medical-tourism-check.sh
# 医疗旅游项目每日晨检脚本
# 每天早上运行

echo "🏥 ==========================================="
echo "   医疗旅游项目晨检 - $(date '+%Y-%m-%d %H:%M')"
echo "   ==========================================="
echo ""

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

WORKSPACE="${HOME}/.openclaw/workspace"
MEMORY_DIR="${WORKSPACE}/memory"
TODAY=$(date '+%Y-%m-%d')

# 检查文件是否存在
if [ ! -d "${MEMORY_DIR}" ]; then
    echo -e "${RED}❌ 错误: 记忆目录不存在${NC}"
    exit 1
fi

echo -e "${YELLOW}🔥 第一部分：当前活跃任务${NC}"
echo "----------------------------------------"
if [ -f "${MEMORY_DIR}/hot/HOT_MEMORY.md" ]; then
    # 提取活跃任务部分
    awk '/当前活跃任务/,/---/' "${MEMORY_DIR}/hot/HOT_MEMORY.md" | head -20
else
    echo -e "${RED}⚠️  HOT_MEMORY.md 不存在${NC}"
fi
echo ""

echo -e "${YELLOW}⏰ 第二部分：今日待办${NC}"
echo "----------------------------------------"
TODAY_FILE="${MEMORY_DIR}/${TODAY}.md"
if [ -f "${TODAY_FILE}" ]; then
    echo -e "${GREEN}✅ 今日日志已存在${NC}"
    grep -A 20 "今日目标" "${TODAY_FILE}" 2>/dev/null || echo "暂无今日目标"
else
    echo -e "${YELLOW}⚠️  今天还没有创建日志文件${NC}"
    echo "建议立即创建: ${TODAY_FILE}"
fi
echo ""

echo -e "${YELLOW}🚨 第三部分：P0紧急事项${NC}"
echo "----------------------------------------"
if [ -f "${MEMORY_DIR}/hot/HOT_MEMORY.md" ]; then
    grep -A 5 "P0" "${MEMORY_DIR}/hot/HOT_MEMORY.md" | head -10 || echo -e "${GREEN}✅ 暂无P0紧急事项${NC}"
else
    echo -e "${RED}⚠️  无法读取HOT_MEMORY.md${NC}"
fi
echo ""

echo -e "${YELLOW}📚 第四部分：知识库状态${NC}"
echo "----------------------------------------"
KNOWLEDGE_FILE="${WORKSPACE}/medical-tourism-notes/README.md"
if [ -f "${KNOWLEDGE_FILE}" ]; then
    echo -e "${GREEN}✅ 知识库已同步${NC}"
    ls -la "${WORKSPACE}/medical-tourism-notes/" | head -5
else
    echo -e "${RED}❌ 知识库未同步${NC}"
    echo "建议运行: ./knowledge-sync.sh"
fi
echo ""

echo -e "${YELLOW}🛠️  第五部分：技能检查${NC}"
echo "----------------------------------------"
SKILLS_DIR="${WORKSPACE}/skills"
if [ -d "${SKILLS_DIR}" ]; then
    echo -e "${GREEN}已安装技能:${NC}"
    ls -1 "${SKILLS_DIR}" | grep -E "(web-search|multi-search|tavily|feishu)" | head -10
else
    echo -e "${RED}⚠️  技能目录不存在${NC}"
fi
echo ""

echo -e "${GREEN}✅ 晨检完成！${NC}"
echo "============================================"
echo "建议下一步:"
echo "1. 如有P0紧急事项，立即处理"
echo "2. 如今日日志不存在，立即创建"
echo "3. 开始处理当前活跃任务"
echo "============================================"

# 记录检查时间
echo "$(date): 晨检完成" >> "${MEMORY_DIR}/checkin.log"

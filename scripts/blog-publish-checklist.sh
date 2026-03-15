#!/bin/bash
# blog-publish-checklist.sh
# 博客发布前自动检查清单
# 用法: ./blog-publish-checklist.sh <文件路径>

if [ $# -lt 1 ]; then
    echo "用法: $0 <博客文件路径>"
    echo "例: $0 ../medical-tourism-notes/blog/new-article.html"
    exit 1
fi

FILE="$1"

echo "📋 ==========================================="
echo "   博客发布检查清单"
echo "   ==========================================="
echo ""

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# 检查文件是否存在
if [ ! -f "${FILE}" ]; then
    echo -e "${RED}❌ 错误: 文件不存在 ${FILE}${NC}"
    exit 1
fi

echo "📄 检查文件: ${FILE}"
echo ""

# 定义检查项
declare -a CHECKS=(
    "标题包含数字或利益点:title:|Save|vs|How|Guide|2026"
    "有TLDR快速回答框:TLDR|Quick Answer|tl;dr|快速回答"
    "包含成本对比表:cost comparison|价格对比|费用对比|Save \$|vs"
    "有步骤流程:Step 1|步骤|流程|1\\.|2\\.|3\\."
    "FAQ至少3个问题:FAQ|常见问题|Q:|A:"
    "有CTA按钮或链接:contact|Get Started|Learn More|联系我们|立即咨询"
    "有费用免责声明:Disclaimer|免责声明|仅供参考|estimate"
    "年份是2026:2026"
    "医院数量准确:34|hospital"
    "有相关文章链接:Related|相关文章|Read More"
)

PASSED=0
FAILED=0

for check in "${CHECKS[@]}"; do
    IFS=':' read -r name pattern <<< "$check"
    
    if grep -qE "${pattern}" "${FILE}"; then
        echo -e "${GREEN}✅${NC} ${name}"
        ((PASSED++))
    else
        echo -e "${RED}❌${NC} ${name}"
        ((FAILED++))
    fi
done

echo ""
echo "----------------------------------------"
echo "检查结果: ${PASSED} 通过 / ${FAILED} 未通过"
echo ""

if [ ${FAILED} -eq 0 ]; then
    echo -e "${GREEN}🎉 所有检查通过！可以发布${NC}"
    echo ""
    echo "📤 发布步骤:"
    echo "   1. Git commit -m '发布新博客: xxx'"
    echo "   2. Git push"
    echo "   3. 更新博客首页索引"
    echo "   4. 社媒自动分发"
    echo ""
    exit 0
else
    echo -e "${YELLOW}⚠️  有 ${FAILED} 项未通过，请先修复${NC}"
    echo ""
    echo "💡 建议操作:"
    echo "   - 检查模板文件确保结构完整"
    echo "   - 添加缺失的元素"
    echo "   - 重新运行此检查"
    echo ""
    exit 1
fi

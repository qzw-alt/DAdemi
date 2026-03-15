#!/bin/bash
# skill-check.sh
# 技能安装检查与安装脚本

echo "🛠️  ==========================================="
echo "   技能管理检查"
echo "   ==========================================="
echo ""

WORKSPACE="${HOME}/.openclaw/workspace"
SKILLS_DIR="${WORKSPACE}/skills"
REQUIRED_SKILLS=(
    "web-search:网络搜索"
    "multi-search-engine:多引擎搜索"
    "tavily-search:Tavily深度搜索"
    "feishu-doc:飞书文档"
    "github:GitHub操作"
    "frontend-design:前端设计"
    "web-artifacts-builder:React构建"
    "webapp-testing:Web测试"
)

echo "📋 必需技能检查:"
echo "----------------------------------------"

for skill_info in "${REQUIRED_SKILLS[@]}"; do
    IFS=':' read -r skill_name skill_desc <<< "$skill_info"
    
    if [ -d "${SKILLS_DIR}/${skill_name}" ]; then
        echo "✅ ${skill_name} - ${skill_desc}"
    else
        echo "❌ ${skill_name} - ${skill_desc} (未安装)"
    fi
done

echo ""
echo "🔄 可选技能（建议安装）:"
echo "----------------------------------------"

OPTIONAL_SKILLS=(
    "agent-browser:浏览器自动化:P1"
    "humanizer:内容人性化:P2"
)

for skill_info in "${OPTIONAL_SKILLS[@]}"; do
    IFS=':' read -r skill_name skill_desc priority <<< "$skill_info"
    
    if [ -d "${SKILLS_DIR}/${skill_name}" ]; then
        echo "✅ ${skill_name} - ${skill_desc} [${priority}]"
    else
        echo "⏳ ${skill_name} - ${skill_desc} [${priority}] (建议安装)"
    fi
done

echo ""
echo "💡 安装命令示例:"
echo "   openclaw skill install agent-browser"
echo ""

#!/bin/bash
# inquiry-timer.sh
# 询单响应计时器
# 用法: ./inquiry-timer.sh "客户名" "病情"

if [ $# -lt 2 ]; then
    echo "用法: $0 <客户名> <病情简述>"
    echo "例: $0 'John Smith' '心脏搭桥'"
    exit 1
fi

CUSTOMER_NAME="$1"
CONDITION="$2"
START_TIME=$(date '+%Y-%m-%d %H:%M:%S')
START_TIMESTAMP=$(date +%s)

echo "⏱️  ==========================================="
echo "   询单响应计时器启动"
echo "   ==========================================="
echo ""
echo "👤 客户: ${CUSTOMER_NAME}"
echo "🏥 病情: ${CONDITION}"
echo "🕐 开始时间: ${START_TIME}"
echo ""

# 计算截止时间（24小时后）
DEADLINE=$(date -d "+24 hours" '+%Y-%m-%d %H:%M:%S')
DEADLINE_TIMESTAMP=$(date -d "+24 hours" +%s)

# 计算12小时和18小时的提醒时间
REMINDER_12H=$(date -d "+12 hours" '+%H:%M')
REMINDER_18H=$(date -d "+18 hours" '+%H:%M')
REMINDER_23H=$(date -d "+23 hours" '+%H:%M')

echo "📅 截止时间: ${DEADLINE}"
echo ""
echo "⏰ 提醒时间点:"
echo "   12小时后: ${REMINDER_12H}"
echo "   18小时后: ${REMINDER_18H}"
echo "   23小时后: ${REMINDER_23H} (最后1小时警告)"
echo ""

# 保存到计时器日志
TIMER_LOG="${HOME}/.openclaw/workspace/memory/inquiry-timers.log"
mkdir -p "$(dirname "${TIMER_LOG}")"

echo "${START_TIMESTAMP}|${CUSTOMER_NAME}|${CONDITION}|${DEADLINE_TIMESTAMP}|pending" >> "${TIMER_LOG}"

echo "✅ 计时器已启动"
echo ""
echo "💡 提示:"
echo "   - 目标: 24小时内首次响应"
echo "   - 交付: 48小时内定制攻略"
echo "   - 模板: 根据病情选择对应模板"
echo ""

# 显示倒计时（简化版）
echo "🕐 剩余时间统计:"
echo "   (实时更新中...)"

# 后台进程持续监控（可选）
# nohup bash -c "while true; do ... done" &

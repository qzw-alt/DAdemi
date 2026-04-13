# 🎯 医疗旅游知识 - 完整运用计划

> 不只是存储，是系统化运用
> 制定日期：2026-03-15

---

## 第一部分：记忆运用计划

### 📋 目标
将医疗旅游知识库整合到三层记忆系统，实现：
- **快速检索**：10秒内找到所需信息
- **自动更新**：每日/每周/每月维护
- **无缝调用**：工作时自动引用

---

### 🔥 HOT层 - 每日活跃（自动更新）

**更新频率**: 每次会话
**触发条件**: 早晨启动时

#### 读取清单（必须）
```
1. memory/hot/HOT_MEMORY.md - 当前任务
2. memory/warm/WARM_MEMORY.md - 配置偏好
3. memory/2026-03-15.md - 今日工作日志
4. medical-tourism-knowledge-summary.md - 项目速查
```

#### 每日检查项
- [ ] 当前活跃任务清单
- [ ] 今日待办事项
- [ ] 紧急事项（P0）
- [ ] 临时信息/上下文

#### 自动脚本（创建）
```bash
# morning-medical-tourism-check.sh
# 每天早上运行，自动读取并简报

#!/bin/bash
echo "=== 医疗旅游项目晨检 ==="
echo ""
echo "🔥 当前活跃任务:"
grep -A 5 "当前活跃任务" ~/.openclaw/workspace/memory/hot/HOT_MEMORY.md | head -10

echo ""
echo "⏰ 今日待办:"
grep -A 10 "$(date +%Y-%m-%d)" ~/.openclaw/workspace/memory/2026-03-15.md 2>/dev/null || echo "今天还没创建日志"

echo ""
echo "🚨 P0紧急事项:"
grep -A 3 "P0" ~/.openclaw/workspace/memory/hot/HOT_MEMORY.md
```

---

### 🌡️ WARM层 - 稳定配置（每周更新）

**更新频率**: 每周日 或 配置变更时
**触发条件**: 技能安装/偏好变更

#### 内容清单
```
1. 用户偏好（伟烨）
   - 工作风格：想法多、节奏快、晚上6点后黄金时间
   - 沟通偏好：直接、高效、选项式
   - 记忆偏好：详细记录，不压缩

2. 项目配置
   - 医院数量：34家
   - 套餐价格：$30/$299/$899
   - 网站域名：chinahospitalsguide.com
   - 年份基准：2026

3. 工具配置
   - 搜索策略：Multi Search → Tavily
   - 文件命名：医疗旅游_前缀
   - 响应时间：24小时（询单）

4. 模板库位置
   - 牙科攻略：template-dental.md
   - 眼科攻略：template-eye.md
   - 心血管：template-cardiology.md
   - 肿瘤：template-oncology.md
   - 骨科：template-orthopedics.md
   - 中医：template-tcm.md
```

#### 每周维护任务
- [ ] 核对医院数量是否还是34家
- [ ] 检查套餐价格是否有变动
- [ ] 更新SEO关键词库
- [ ] 归档已完成的P0任务

---

### ❄️ COLD层 - 长期归档（每月整理）

**更新频率**: 每月1号
**触发条件**: 周期性归档

#### 归档策略
```
每月1号执行：
1. 读取当月所有 memory/YYYY-MM-DD.md
2. 提取重要决策、教训、数据
3. 更新 MEMORY.md 长期记忆
4. 移动旧日志到 cold/ 文件夹
5. 生成月度总结报告
```

#### 长期保留内容
- 项目里程碑（上线日期、重大更新）
- 关键决策记录（为什么选择标签系统）
- 踩坑记录（已解决的问题）
- 竞争对手变化
- 成功案例（患者故事ROI）

---

## 第二部分：技能管理计划

### 🛠️ 技能清单与用途

| 技能 | 状态 | 用途 | 优先级 |
|------|------|------|--------|
| **web-search** | ✅ 已安装 | 医院/价格/签证信息搜索 | P0 |
| **multi-search-engine** | ✅ 已安装 | 广度搜索竞品/市场 | P0 |
| **tavily-search** | ✅ 已安装 | 深度调研具体数据 | P0 |
| **feishu-doc** | ✅ 已安装 | 写攻略/文档交付 | P0 |
| **frontend-design** | ✅ 已安装 | 网站设计指导 | P1 |
| **web-artifacts-builder** | ✅ 已安装 | React原型/单文件HTML | P1 |
| **webapp-testing** | ✅ 已安装 | 功能测试/截图 | P1 |
| **agent-browser** | ❓ 未安装 | 网站自动化操作 | P2 |
| **github** | ✅ 已安装 | 代码/文件管理 | P1 |
| **social-media-management** | ✅ 已安装 | 社媒内容发布 | P2 |

### 📥 待安装技能（立即执行）

#### 1. agent-browser（P2 → P1）
**用途**: 
- 自动检查网站链接
- 批量截图验证页面
- 自动化表单测试

**安装命令**:
```bash
openclaw skill install agent-browser
```

**配置**:
- 设置默认浏览器：Chrome
- 截图保存路径：~/screenshots/medical-tourism/

#### 2. humanizer（P2）
**用途**:
- 优化AI生成内容，更像人类写作
- 博客文章人性化处理

**安装命令**:
```bash
openclaw skill install humanizer
```

---

### 🔄 工作流程建立

#### 流程1: 询单处理工作流
```
触发: 网站表单提交
     ↓
步骤1: 读取用户填表信息（国家/病情/城市/时间）
     ↓
步骤2: 判断病情类型 → 选择模板
     ↓
步骤3: 搜索最新医院信息/价格（web-search + tavily）
     ↓
步骤4: 填充模板 → 生成定制攻略
     ↓
步骤5: 审核检查（费用免责声明/联系方式/医院数量）
     ↓
步骤6: 发送邮件 + WhatsApp + 记录到Airtable
     ↓
步骤7: 更新今日工作日志
     ↓
步骤8: 设置3天后跟进提醒
```

**预计时间**: 30-45分钟/单

#### 流程2: 博客创作工作流
```
触发: 需要新博客文章
     ↓
步骤1: 关键词研究（multi-search-engine）
     ↓
步骤2: 竞品分析（搜索同类文章）
     ↓
步骤3: 大纲设计（标题/TLDR/对比表/步骤/FAQ/CTA）
     ↓
步骤4: 内容创作（分段写入）
     ↓
步骤5: 人性化优化（humanizer）
     ↓
步骤6: 添加费用免责声明
     ↓
步骤7: 更新博客索引页
     ↓
步骤8: 浏览器测试（agent-browser截图）
     ↓
步骤9: 发布 + 社媒分发
```

**预计时间**: 2-3小时/篇

#### 流程3: 网站维护工作流
```
触发: 需要更新网站（年度/价格/导航）
     ↓
步骤1: 列出所有需要修改的页面
     ↓
步骤2: 批量修改（导航/年份/免责声明）
     ↓
步骤3: 链接检查（agent-browser遍历）
     ↓
步骤4: 移动端测试
     ↓
步骤5: Git提交 + 部署
     ↓
步骤6: 更新检查清单状态
```

**预计时间**: 1-2小时/次

---

### 🤖 自动化脚本库（创建）

#### 脚本1: 每日晨检脚本
```bash
#!/bin/bash
# daily-medical-tourism-check.sh
# 每天早上自动运行

echo "🏥 医疗旅游项目晨检 - $(date)"
echo "================================"

# 读取当前任务
echo "🔥 今日任务:"
cat ~/.openclaw/workspace/memory/hot/HOT_MEMORY.md | grep -A 10 "当前活跃任务"

# 检查是否有紧急询单
echo ""
echo "📧 待处理询单:"
# 这里可以连接Airtable API检查

echo ""
echo "⏰ 今日待办:"
TODAY=$(date +%Y-%m-%d)
if [ -f "~/.openclaw/workspace/memory/${TODAY}.md" ]; then
    cat "~/.openclaw/workspace/memory/${TODAY}.md"
else
    echo "今天还没有创建日志文件"
fi

echo ""
echo "✅ 晨检完成"
```

#### 脚本2: 询单响应计时器
```bash
#!/bin/bash
# inquiry-timer.sh
# 新询单到达时启动

INQUIRY_TIME=$1
CUSTOMER_NAME=$2

echo "⏱️ 询单计时器启动 - ${CUSTOMER_NAME}"
echo "收到时间: ${INQUIRY_TIME}"

# 计算24小时后的截止时间
DEADLINE=$(date -d "${INQUIRY_TIME} + 24 hours" +"%Y-%m-%d %H:%M")
echo "响应截止: ${DEADLINE}"

# 设置提醒（12小时、18小时、23小时）
# 这里可以集成系统提醒
```

#### 脚本3: 博客发布检查清单
```bash
#!/bin/bash
# blog-publish-checklist.sh
# 发布前自动检查

FILE=$1

echo "📋 博客发布检查清单 - ${FILE}"
echo "================================"

checks=(
    "标题包含关键词"
    "有TLDR快速回答框"
    "包含成本对比表"
    "有步骤流程（1,2,3）"
    "FAQ至少3个"
    "有CTA按钮"
    "有费用免责声明"
    "相关文章链接"
    "年份是2026"
    "移动端显示正常"
)

for check in "${checks[@]}"; do
    read -p "✓ ${check}? [y/n] " answer
    if [ "$answer" != "y" ]; then
        echo "❌ 未通过: ${check}"
        exit 1
    fi
done

echo "✅ 所有检查通过，可以发布！"
```

#### 脚本4: 知识库同步脚本
```bash
#!/bin/bash
# knowledge-sync.sh
# 定期从GitHub同步最新知识

REPO_URL="https://github.com/qzw-alt/medical-tourism-notes.git"
LOCAL_PATH="~/.openclaw/workspace/medical-tourism-notes"

echo "🔄 同步医疗旅游知识库..."

if [ -d "${LOCAL_PATH}" ]; then
    cd "${LOCAL_PATH}"
    git pull
else
    git clone "${REPO_URL}" "${LOCAL_PATH}"
fi

# 检查是否有更新
if [ $? -eq 0 ]; then
    echo "✅ 同步完成"
    echo "📅 最后更新: $(date)" >> ~/.openclaw/workspace/memory/knowledge-sync.log
else
    echo "❌ 同步失败"
fi
```

---

## 第三部分：执行检查清单

### 📅 每日必做（5-10分钟）

**早晨启动**:
- [ ] 运行晨检脚本
- [ ] 读取HOT_MEMORY.md
- [ ] 检查是否有待处理询单
- [ ] 创建/更新今日工作日志

**晚上结束**:
- [ ] 更新今日工作日志（完成度）
- [ ] 检查询单响应计时器
- [ ] 更新HOT_MEMORY.md（划掉已完成）
- [ ] Git提交今日变更

### 📅 每周必做（30分钟）

**周日维护**:
- [ ] 更新WARM_MEMORY.md
- [ ] 核对医院数量/套餐价格
- [ ] 归档已完成的P0任务
- [ ] 检查技能是否需要更新
- [ ] 生成本周工作总结

### 📅 每月必做（1小时）

**月初归档**:
- [ ] 读取当月所有日志
- [ ] 提取重要决策到MEMORY.md
- [ ] 移动旧日志到cold/文件夹
- [ ] 生成月度总结
- [ ] 同步知识库到最新版本

---

## 第四部分：快速参考卡片

### 🏥 医院数据速查
```
数量: 34家
主要城市: 北京、上海、深圳、广州
顶级医院:
- 阜外医院（心血管#1）
- 北京协和（综合Top 10全球）
- 上海六院（骨科#2）
```

### 💰 价格速查
```
套餐:
- Starter: $30
- Standard: $299
- Premium: $899

节省比例: 50-80% vs 美国
```

### ⏰ 响应时间SLA
```
询单首次响应: 24小时内
定制攻略交付: 48小时内
邮件序列间隔: 2天
```

### 📝 文件位置速查
```
知识库: medical-tourism-notes/
模板: docs/template-*.md
邮件: docs/email-sequences.md
SOP: docs/sop-inquiry-response.md
WhatsApp: docs/whatsapp-templates.md
```

---

## 第五部分：风险控制

### ⚠️ 常见错误预防

| 风险 | 预防措施 | 检查点 |
|------|----------|--------|
| 费用无免责声明 | 发布前强制检查 | 博客发布检查清单 |
| 年份过时 | 全局搜索替换 | 网站维护工作流 |
| 响应超24小时 | 询单计时器 | 每日检查 |
| 导航不一致 | 批量更新 | 网站维护工作流 |
| 医院数量错误 | 核对34家 | 每周维护 |

### 🚨 紧急处理流程
```
发现问题 → 立即记录 → 评估影响 → 制定修复 → 执行 → 复盘
```

---

## 附录：记忆系统文件结构

```
~/.openclaw/workspace/
├── memory/
│   ├── hot/
│   │   └── HOT_MEMORY.md              # 每日活跃任务
│   ├── warm/
│   │   └── WARM_MEMORY.md             # 稳定配置
│   ├── cold/
│   │   └── (归档的月度日志)
│   ├── 2026-03-15.md                  # 今日日志
│   ├── 2026-03-14.md                  # 昨日日志
│   ├── medical-tourism-knowledge-summary.md  # 项目速查
│   └── knowledge-sync.log             # 同步记录
├── medical-tourism-notes/             # 知识库（GitHub同步）
│   ├── docs/
│   ├── memory/
│   └── skills/
└── scripts/                           # 自动化脚本
    ├── morning-check.sh
    ├── inquiry-timer.sh
    ├── blog-checklist.sh
    └── knowledge-sync.sh
```

---

**下一步立即执行**:
1. ✅ 创建自动化脚本（4个）
2. ⏳ 安装agent-browser技能
3. ⏳ 设置每日晨检定时任务
4. ⏳ 测试询单处理工作流


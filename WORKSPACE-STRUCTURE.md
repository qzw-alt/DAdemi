# 📁 Workspace 目录结构

> 最后整理: 2026-03-15

---

## 🏠 根目录（核心文件）

| 文件 | 说明 |
|------|------|
| `AGENTS.md` | 工作空间规则 |
| `BOOTSTRAP.md` | 启动指南（完成后删除）|
| `DAILY-START-CARD.md` | 每日启动卡 |
| `HEARTBEAT.md` | 触发式待办清单 |
| `IDENTITY.md` | 身份信息 |
| `MEMORY.md` | 长期记忆 |
| `README.md` | 项目说明 |
| `RULES_TAVILY.md` | Tavily使用规则 |
| `SKILL-content-writer.md` | 内容写作技能 |
| `SKILL-seo.md` | SEO技能 |
| `SOUL.md` | 核心人格 |
| `TOOLS.md` | 本地工具笔记 |
| `USER.md` | 用户信息 |

---

## 📂 主要目录

### `archive/` - 归档文件夹
```
archive/
├── old-backups/        # 旧备份文件
└── deprecated-skills/  # 废弃的技能文件
```

### `assets/` - 资源文件
```
assets/
├── images/             # 图片资源
│   ├── kimi_*.png
│   └── og-image.jpg
├── og-image-preview.html
└── restaurant-prototype.html
```

### `docs/` - 文档
```
docs/
├── guides/             # 指南文档
│   ├── CLI-Anything-Install-Report.md
│   ├── medical-tourism-execution-guide.md
│   ├── multi-platform-distribution-guide.md
│   ├── video-subtitle-remover-guide.md
│   └── VSR-INSTALL-GUIDE.md
└── plans/              # 计划文档
    ├── medical-tourism-implementation-plan.md
    ├── video-production-plan-patient-story.md
    └── video-script-patient-story-michael.md
```

### `memory/` - 记忆系统（三层架构）
```
memory/
├── hot/
│   └── HOT_MEMORY.md          # 每日必读
├── warm/
│   └── WARM_MEMORY.md         # 每周回顾
├── 2026-03-15.md              # 每日日志
├── 2026-03-07.md
├── 2026-03-05.md
└── ...
```

### `medical-tourism-notes/` - 医疗旅游知识库
```
medical-tourism-notes/
├── docs/               # 文档
├── data/               # 数据
└── templates/          # 模板
```

### `scripts/` - 自动化脚本
```
scripts/
├── 1-detect-subtitle.bat
├── 2-remove-soft-subtitle.bat
├── 3-blur-subtitle.bat
├── 4-crop-subtitle.bat
├── auto-backup.bat           # 自动备份
├── daily-medical-tourism-check.bat
├── inquiry-timer.sh
├── knowledge-sync.bat
├── morning-check.ps1
└── ...
```

### `skills/` - 技能文件
```
skills/
├── github/
├── feishu-docx-powerwrite/
├── frontend-design/
├── multi-search-engine/
└── ...
```

### `templates/` - 模板文件
```
templates/
└── DAILY-START-CARD-TEMPLATE.md
```

### `temp/` - 临时文件
```
temp/
└── （临时生成的文件，定期清理）
```

---

## 🔧 系统目录（勿动）

```
.clawhub/              # ClawHub配置
.openclaw/             # OpenClaw配置
config/                # 配置文件
node_modules/          # Node依赖
skills_custom/         # 自定义技能
```

---

## 🚀 快速导航

### 每日必用
- 启动卡: `DAILY-START-CARD.md`
- 今日任务: `memory/hot/HOT_MEMORY.md`
- 稳定配置: `memory/warm/WARM_MEMORY.md`

### 医疗旅游项目
- 执行指南: `docs/guides/medical-tourism-execution-guide.md`
- 完整计划: `docs/plans/medical-tourism-implementation-plan.md`
- 知识库: `medical-tourism-notes/`

### 自动化脚本
- 晨检: `scripts/morning-check.ps1`
- 备份: `scripts/auto-backup.bat`
- 同步: `scripts/knowledge-sync.bat`

---

## 📝 维护说明

1. **新文档** → 放入 `docs/guides/` 或 `docs/plans/`
2. **图片资源** → 放入 `assets/images/`
3. **旧文件** → 移入 `archive/`
4. **临时文件** → 使用 `temp/`，定期清理

---

*保持整洁，提高效率！*

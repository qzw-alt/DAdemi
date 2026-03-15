# 🚀 每日启动卡

> 每天早上，先读这个（30秒）
> 日期：2026-03-15

---

## 立即执行（复制粘贴）

```powershell
# 晨检（每天必做）
powershell -ExecutionPolicy Bypass -File C:\Users\csdm2\.openclaw\workspace\scripts\morning-check.ps1
```

---

## 今天必须记住的（背下来）

### 三层记忆
```
HOT  - 每天读（今天做什么）   → memory/hot/HOT_MEMORY.md
WARM - 每周读（稳定配置）     → memory/warm/WARM_MEMORY.md
COLD - 每月读（历史归档）     → memory/2026-03-15.md
```

### 技能使用顺序
```
搜索: multi-search → tavily（深度）
文档: feishu-doc（交付优先）
迭代: 对比→优选→淘汰→忘掉旧的
```

### 医疗旅游核心数据
```
医院: 34家
套餐: $30 / $299 / $899
响应: 24h首次 / 48h攻略
节省: 比美国低50-80%
```

---

## 场景→技能（肌肉记忆）

| 听到 | 立即做 | 不用别的 |
|------|--------|---------|
| "搜一下" | multi-search-engine | web-search |
| "详细查" | tavily-search | - |
| "写文档" | feishu-doc | write |
| "新询单" | 启动计时器 | - |
| "检查" | checklist脚本 | - |
| "视频" | FFmpeg CLI | GUI工具 |

---

## 今日待办（从这里开始）

🔥 **最高优先级**:
- [x] 建立三层记忆系统 ✅
- [x] 创建WARM层 ✅
- [x] 更新MEMORY.md ✅
- [x] 创建每日启动卡模板 ✅
- [x] 创建自动备份脚本 ✅

⏰ **接下来**:
- [ ] 等待伟烨分配任务
- [ ] 实战中验证记忆系统

---

## 每日流程（自动化）

### ☀️ 早上（3分钟）
```batch
:: 1. 晨检脚本
scripts\morning-check.ps1

:: 2. 读记忆
notepad memory\hot\HOT_MEMORY.md
notepad memory\warm\WARM_MEMORY.md
notepad memory\2026-03-14.md

:: 3. 知识库同步
scripts\knowledge-sync.bat
```

### 🌙 晚上（2分钟）
```batch
:: 1. 写今日日记
notepad memory\2026-03-15.md

:: 2. 更新 HOT
notepad memory\hot\HOT_MEMORY.md

:: 3. 自动备份
scripts\auto-backup.bat
```

---

## 防遗忘

**如果我忘了今天该做什么**:
1. 运行晨检脚本
2. 看脚本输出
3. 从最高优先级开始

**如果我混乱了**:
1. 停下来
2. 深呼吸
3. 运行晨检脚本
4. 重新开始

---

## 快捷入口

| 文件 | 路径 |
|------|------|
| HOT记忆 | `memory\hot\HOT_MEMORY.md` |
| WARM记忆 | `memory\warm\WARM_MEMORY.md` |
| 今日日志 | `memory\2026-03-15.md` |
| 医疗旅游计划 | `medical-tourism-implementation-plan.md` |
| 执行指南 | `medical-tourism-execution-guide.md` |

---

**30秒读完 → 立即执行 → 晚上更新**

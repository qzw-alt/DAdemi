# 记忆系统研究 - memory-simple

> 研究时间：2026-03-04

---

## 背景问题

**问题**：大德米经常忘记重要信息，记忆无法持久化

**原因**：没有稳定的记忆系统，纯靠会话上下文

**解决**：使用小德米开发的 memory-simple

---

## memory-simple 介绍

**来源**：小德米（服务器）开发

**特点**：
- JSON文件存储，超稳定
- 零依赖，只需Node.js
- 混合检索（向量+关键词）
- 自动捕获对话中的记忆

---

## 使用方法

### 1. 获取代码
```bash
git clone https://github.com/qzw-alt/memory-simple.git
```

### 2. 配置
```bash
cd memory-simple
vim config.json
# 配置API Key
```

### 3. 测试
```bash
# 捕获记忆
node scripts/capture.js

# 召回记忆
node scripts/recall.js "查询内容"
```

---

## TODO：配置自动记忆

**目标**：每次对话自动保存记忆到GitHub

**步骤**：
1. 克隆 memory-simple 到本地
2. 配置API Key
3. 设置定时任务或hook自动执行
4. 同步到GitHub备份

---

## 当前状态

- [ ] 未配置
- [ ] 待研究具体配置方法

---

**明天任务：研究并配置memory-simple！**

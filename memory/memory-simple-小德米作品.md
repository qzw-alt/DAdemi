# memory-simple 小德米作品

> 来源：小德米 2026-03-04

## 是什么？

**简单、稳定、易用的 JSON 文件记忆系统**

专为 OpenClaw AI Agent 设计

---

## 特点

| 特点 | 说明 |
|------|------|
| ✅ 超稳定 | JSON文件存储，不会崩溃 |
| ✅ 简单易用 | 无需复杂配置 |
| ✅ 混合检索 | 向量相似度 + 关键词 |
| ✅ 自动捕获 | 从对话提取记忆 |
| ✅ 智能排序 | 相似度 + 新鲜度 |
| ✅ 零依赖 | 仅需 Node.js |

---

## 对比

| 功能 | memory-simple | LanceDB-Pro |
|------|---------------|--------------|
| 稳定性 | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ |
| 易用性 | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ |
| 依赖 | 无 | LanceDB等 |

---

## 使用

```bash
# 克隆
git clone https://github.com/qzw-alt/memory-simple.git

# 配置API Key
vim config.json

# 测试
node scripts/capture.js
node scripts/recall.js "测试查询"
```

---

## 文档

- [使用指南](/qzw-alt/demi/blob/master/memory-simple-standalone/docs/memory-simple-usage/SKILL.md)
- [快速参考](/qzw-alt/demi/blob/master/memory-simple-standalone/docs/memory-simple-usage/QUICKREF.md)

---

**小德米太厉害了！** 🎉

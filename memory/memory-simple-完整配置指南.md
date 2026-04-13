# memory-simple 完整配置指南

> 基于小德米源码 2026-03-04

---

## 这是什么？

**简单稳定的JSON记忆系统**
- 无数据库，零依赖
- 向量搜索 + 关键词搜索
- 自动从对话中捕获记忆

---

## 快速开始

### 1. 配置 config.json

位置：`demi-master/memory-simple-standalone/config.json`

```json
{
  "embedding": {
    "provider": "zhipu",
    "apiKey": "你的智谱API Key",
    "model": "embedding-3",
    "dimensions": 2048
  },
  "capture": {
    "enabled": true
  },
  "recall": {
    "enabled": true,
    "topK": 5,
    "minSimilarity": 0.7
  }
}
```

### 2. 安装依赖

```bash
cd memory-simple-standalone
npm install
```

### 3. 测试

```bash
# 捕获记忆
node scripts/capture.js

# 召回记忆
node scripts/recall.js "用户喜欢什么"
```

---

## 使用方法

### 捕获记忆

```javascript
const { captureMemories } = require('./scripts/capture');

await captureMemories([
  { role: 'user', content: '我喜欢喝咖啡' },
  { role: 'user', content: '记住我的邮箱是 test@example.com' }
], 'session-id');
```

### 召回记忆

```javascript
const { searchMemories } = require('./scripts/recall');

const results = await searchMemories('用户喜欢什么', {
  topK: 5,
  sessionId: 'session-id'
});
```

---

## 记忆类型

| 类型 | 说明 | 示例 |
|------|------|------|
| preference | 偏好 | "我喜欢喝咖啡" |
| decision | 决定 | "我选择A方案" |
| important | 重要 | "这是关键信息" |
| general | 一般 | "用户住在上海" |

---

## 文件结构

```
memory-simple-standalone/
├── config.json          # 配置
├── memories/
│   ├── global.json     # 全局记忆
│   └── sessions/       # 会话记忆
├── scripts/
│   ├── capture.js      # 捕获
│   ├── recall.js       # 召回
│   └── utils.js        # 工具
└── SKILL.md            # 文档
```

---

## 智谱API Key

需要去 https://open.bigmodel.cn 注册获取

---

## TODO

- [ ] 配置API Key
- [ ] 安装npm依赖
- [ ] 测试capture
- [ ] 测试recall
- [ ] 配置自动运行

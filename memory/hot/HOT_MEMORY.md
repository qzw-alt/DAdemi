# HOT_MEMORY.md - 火热层（当前任务）

> 每次对话后更新 | 每天早上和晚上必读

---

## 🎯 核心记忆（明天看到立刻知道该做什么）

### 💎 完整工作流（4+2技能组合）
| 技能 | 用途 | 何时用 |
|------|------|--------|
| **feishu-doc** | 记录/交付 | 全程 |
| **frontend-design** | 设计指导 | 设计阶段 |
| **web-artifacts-builder** | React原型 | 开发阶段 |
| **webapp-testing** | 测试验证 | 交付前 |
| **seo-audit** | SEO审计 | 交付前可选 |
| **next-best-practices** | Next.js备用 | 如用Next.js方案 |

**标准工作流**：需求→设计→原型→测试→SEO→交付/部署  
**详细步骤**：见 WARM_MEMORY.md  
**预期效果**：2-4小时交付可交互原型

---

## 📋 明天待办

### 🌙 建站实战
- [ ] 确定网站主题和需求（客户行业？）
- [ ] 用完整工作流实战：需求→设计→原型→测试→SEO
- [ ] 计时挑战：看看完整流程需要多久
- [ ] 部署上线（Coolify/Docker）

### 今天已完成 ✅
- [x] 安装 github 技能
- [x] 浏览 skills.sh 收集技能
- [x] 下载 frontend-design, web-artifacts-builder, webapp-testing
- [x] 下载 seo-audit (SEO审计)
- [x] 下载 next-best-practices (Next.js)
- [x] 验证 GitHub 访问方案（jina.ai 代理）
- [x] 更新工作流加入SEO

### 今晚任务（20:00开始）🌙
- [ ] 确定网站主题和需求
- [ ] 用 3+1 工作流实战建站
- [ ] 计时挑战：看看完整流程需要多久
- [ ] 记录真实时间和遇到的问题

### 🚀 一键部署工具（Docker）
```bash
# 5分钟建好WordPress
docker-compose up -d

# 详见 memory/Docker-WordPress实战手册.md
```

### 明天待办 ⏳
- [ ] 复盘今晚建站过程
- [ ] 优化工作流
- [ ] 研究 WordPress 主题市场

---

## 🔔 触发提醒（看到这些立刻执行）

**如果伟烨说**：
- "想做个网站" → 启动3+1工作流
- "做个原型看看" → 用 web-artifacts-builder
- "设计太丑了" → 用 frontend-design 重新设计
- "测试一下" → 用 webapp-testing 截图验证

---

## 📚 重要资源

### GitHub访问（已验证）
```
https://r.jina.ai/http:// + 任意GitHub URL
```

### 技能库
- skills.sh - Agent Skills Directory
- github.com/anthropics/skills - Anthropic官方

### 门户网站项目
- 方向：帮商家建网站/博客
- 技术：WordPress为主，React原型演示
- 目标客户：国内中小企业

---

## 📝 问题追踪

| 问题 | 状态 | 备注 |
|------|------|------|
| blogwatcher安装 | ⏸️ 待重试 | API限流 |
| skills.sh技能安装 | ⏸️ 待解决 | skillsadd网络问题 |
| awesome-claude-agents | ⏸️ 待浏览 | 用jina.ai方法 |

---

## 💡 快速参考

### web-artifacts-builder 快速开始
```bash
bash scripts/init-artifact.sh     # 初始化
# 编辑代码
bash scripts/bundle-artifact.sh   # 打包
```

### frontend-design 核心原则
- ❌ 避免：Inter字体、紫色渐变、居中布局
- ✅ 追求：独特字体、大胆配色、非对称布局

### webapp-testing 核心命令
```python
page.wait_for_load_state('networkidle')  # 等待加载
page.screenshot(path='screenshot.png')   # 截图
```

---
*更新时间：2026-03-06 12:40*

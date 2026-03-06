# WARM_MEMORY.md - 温暖层（长期记忆）

> 每周或重要变化时更新 | 用户偏好 + 稳定配置

## 👤 用户信息（伟烨）
- **名字**：伟烨
- **timezone**：Asia/Shanghai (GMT+8)
- **特点**：创业者，有很多好点子
- **偏好**：稳定可靠的方案，讨厌花哨不实用的东西

## ⚙️ 稳定配置
- **Kimi API**: sk-kimi-Cs9OtGUatopK0qds8T2oThQpG3eapXvEjt5LDqENMjWqNXmT1dyqkajioQUzub8p
- **Tavily API**: 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（配额有限，谨慎使用）

## 🔑 核心原则（来自伟烨的教导）
1. **稳定性 > 功能丰富** - 简单可依赖 > 复杂易崩溃
2. **记忆是AI的灵魂** - 没有记忆 = 每次对话都是陌生人
3. **写下来，不要记在心里** - 纸笔（或文件）才是正确工具

## 📁 项目配置
- **医疗旅游**：来华就医服务平台 https://chinahospitalsguide.com

## 📌 重要规则
- 每天早上读 HOT + WARM + 昨天日记
- 每天晚上写今天日记 + 更新 HOT
- 重要信息移到 WARM 层

## 🎯 核心工作流：客户网站快速原型（3+1技能组合）

> **重要性**：⭐⭐⭐⭐⭐ 这是门户网站项目的核心竞争力！
> **创建时间**：2026-03-06
> **预期效果**：2-4小时交付可交互网站原型

### 什么时候用？（触发条件）
- [ ] 客户说"想做个网站"
- [ ] 需要快速展示设计能力
- [ ] 确认需求后再正式开发
- [ ] 伟烨说"做个原型看看"

### 核心技能（3+1）
| 序号 | 技能名 | 作用 | 使用时机 |
|------|--------|------|----------|
| 1 | **feishu-doc** | 记录需求、整理方案、交付文档 | 全程 |
| 2 | **frontend-design** | 设计指导、审美把关、避免"AI垃圾" | 设计阶段 |
| 3 | **web-artifacts-builder** | 构建React原型、打包单文件HTML | 开发阶段 |
| +1 | **webapp-testing** | 功能测试、截图验证、确保质量 | 交付前 |

### 标准执行步骤（按顺序）

#### Step 1: 需求记录（feishu-doc）
```
1. 创建飞书文档《[客户名]网站原型需求》
2. 记录：客户行业、目标用户、核心功能、参考网站
3. 确认：预算范围、交付时间、技术偏好
```
**检查点**：文档已创建，需求已明确

#### Step 2: 设计方案（frontend-design）
```
1. 根据需求确定设计风格（极简/奢华/活泼/工业等）
2. 避免：Inter字体、紫色渐变、居中布局、圆角按钮
3. 选择：独特字体、大胆配色、非对称布局、动效交互
4. 在飞书文档中记录设计方向
```
**检查点**：设计方向已确定，风格明确

#### Step 3: 原型构建（web-artifacts-builder）
```
1. 执行：bash scripts/init-artifact.sh
2. 编辑生成的React代码，实现设计
3. 使用 shadcn/ui 组件库
4. 执行：bash scripts/bundle-artifact.sh
5. 生成 bundle.html（单文件可运行）
```
**检查点**：bundle.html 已生成，可正常打开

#### Step 4: 功能验证（webapp-testing）
```
1. 用 Playwright 测试页面功能
2. 截图验证不同分辨率显示效果
3. 检查链接、按钮、表单是否正常
4. 记录问题清单
```
**检查点**：测试通过，无明显bug

#### Step 5: 交付（feishu-doc）
```
1. 将 bundle.html 上传到飞书文档
2. 撰写交付说明：设计思路、功能说明、下一步建议
3. 分享给客户预览
```
**检查点**：客户能正常查看原型

### 常见问题 & 解决方案

| 问题 | 解决方案 |
|------|----------|
| web-artifacts-builder 初始化失败 | 检查 Node 18+ 是否安装 |
| 打包后样式丢失 | 确保使用 Tailwind CSS 类名 |
| 测试时页面加载慢 | 添加 `page.wait_for_load_state('networkidle')` |
| 客户说"太复杂" | 用 frontend-design 重新设计，走极简路线 |

### +2 SEO审核（seo-audit）- 可选但强烈推荐
```
1. 用 seo-audit 技能分析网站SEO问题
2. 检查：title、meta、h1、结构化数据
3. 检查：Core Web Vitals (LCP/FID/CLS)
4. 输出SEO优化建议清单
```
**检查点**：SEO问题已识别，有优化建议

---

### +3 部署上线（Coolify/Docker）
```
方案A - Coolify（推荐）：
  curl -fsSL https://cdn.coollabs.io/coolify/install.sh | bash
  
方案B - Docker：
  docker-compose up -d
```
**检查点**：网站已上线，可访问

---

### 完整流程图

```
需求 → 设计 → 原型 → 测试 → SEO → 交付/部署
  ↓      ↓      ↓      ↓     ↓
feishu frontend web-   web-  seo-  feishu
-doc   -design artifacts -testing audit  -doc
                    -builder           +Coolify
```

---

### 时间预估（完整流程）
- 简单官网（5页内）：2-3小时
- 中等复杂度（10页+SEO）：4-6小时
- 复杂应用（状态管理+路由）：1-2天

---

## 📚 今日更新 (2026-03-06)
- **GitHub访问**: 使用 jina.ai 代理稳定访问 - `https://r.jina.ai/http://github.com/xxx`
- **新技能**: frontend-design, web-artifacts-builder, webapp-testing (Anthropic官方)
- **新技能**: seo-audit (SEO审计), next-best-practices (Next.js)
- **技能获取方式**: 手动下载 SKILL.md 文件，安全可靠
- **核心工作流**: 客户网站快速原型（见上方详细文档）
- **SEO能力**: seo-audit 技能已集成，可做技术SEO审计

## 📚 历史记录 (2026-03-05)
- **WordPress**: 6.9最新版本，占43%+网站市场份额，中文官网cn.wordpress.org
- **AI趋势**: 算力需求攀升，智能体价值兑现，两会热议AI爆发点

---
*更新时间：2026-03-06 22:40*

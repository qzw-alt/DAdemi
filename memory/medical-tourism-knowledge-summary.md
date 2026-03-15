# 医疗旅游项目知识库 - 学习总结

> 从小德米整理的仓库学习而来
> 学习日期：2026-03-15
> 仓库地址：https://github.com/qzw-alt/medical-tourism-notes

---

## 📋 项目概览

**项目名称**: China Hospitals Guide (chinahospitalsguide.com)  
**业务模式**: 医疗旅游服务平台，帮助国际患者在中国获得高性价比医疗服务  
**核心价值**: 美国/欧洲价格的20-50%，同等质量的医疗服务  
**目标市场**: 海外患者（特别是美国、英国等发达国家）

---

## 🏥 医院资源

- **合作医院数量**: 34家
- **主要城市**: 北京、上海、深圳、广州
- **主要专科**:
  - 心血管（阜外医院 - 中国#1）
  - 骨科（上海六院 - 中国#2）
  - 肿瘤
  - 眼科
  - 牙科
  - 中医理疗
  - 综合医疗（北京协和 - 全球Top 10）

---

## 💰 定价策略

### 服务套餐
| 套餐 | 价格 | 内容 |
|------|------|------|
| **Starter Guide** | $30 | 医院数据库、费用指南、签证信息 |
| **Standard Package** | $299 | 预约挂号、病历翻译、行前协调 |
| **Premium Package** | $899 | 全程礼宾服务、机场接送、现场协助、5天协调 |

### 成本对比（美国 vs 中国）
- **心脏搭桥**: 美国$130,000 → 中国$15,000-25,000（节省80-85%）
- **膝关节置换**: 美国$50,000 → 中国$8,000-12,000（节省75-80%）
- **化疗周期**: 美国$30,000 → 中国$3,000-5,000（节省80-85%）

---

## 🌐 网站架构

### 核心页面
- `index.html` - 首页
- `hospitals.html` - 医院列表（标签筛选系统）
- `cost-comparison.html` - 费用对比
- `stories.html` - 患者故事
- `about.html` - 关于我们
- `contact.html` - 联系我们
- `blog/index.html` - 博客首页
- `privacy.html` - 隐私政策

### 设计原则
- **移动端优先**: 60%流量来自手机
- **加载速度**: 图片压缩、CSS精简
- **导航一致性**: 每个页面都有完整导航
- **CTA明显**: 行动按钮颜色对比强烈
- **费用免责声明**: 所有价格页面必须包含

---

## ✍️ 内容创作公式

### 博客文章结构（高转化）
```
1. 标题（带数字+利益点）
   例："Giving Birth in China 2026: Save $30,000+ (American Parents Guide)"

2. 快速回答框（TL;DR）

3. 成本对比表

4. 步骤流程（1,2,3...）

5. FAQ（至少3个）

6. CTA转化区块

7. 相关文章链接
```

### 高转化内容类型
| 类型 | 转化率 | 例子 |
|------|--------|------|
| 成本对比 | ⭐⭐⭐⭐⭐ | "Save $30,000" |
| 步骤指南 | ⭐⭐⭐⭐ | "7-Step Process" |
| 患者故事 | ⭐⭐⭐⭐ | "Real Experience" |
| 医院排名 | ⭐⭐⭐ | "Top 10 Hospitals" |

---

## 📧 邮件营销序列

### 欢迎序列（7天）
1. **Day 0**: 欢迎邮件 + 免费指南
2. **Day 2**: 真实成本对比
3. **Day 4**: 患者成功故事
4. **Day 6**: 签证申请指南
5. **Day 8**: 限时优惠转化

### 关键邮件主题行
- "Welcome to China Hospitals Guide - Your Medical Journey Starts Here"
- "The Real Cost of Surgery in China (2026 Price Breakdown)"
- "Meet Sarah: She Saved $45,000 on Her Surgery in China"

---

## 💬 WhatsApp自动回复

### 欢迎消息要点
- 欢迎语
- 工作时间说明（GMT+8）
- 24小时内回复承诺
- 需要收集的信息清单

### 快速回复场景
1. **信息收集**: 病情、时间、国家
2. **医院推荐**: 带费用对比
3. **套餐说明**: Starter/Standard/Premium
4. **咨询预约**: 时间、时区、平台

---

## 📋 询单处理SOP

### 响应时间
- **首次响应**: 24小时内
- **定制攻略**: 48小时内

### 用户填表字段
| 字段 | 用途 |
|------|------|
| 姓名 | 邮件称呼 |
| 邮箱 | 发送攻略 |
| 国家 | 签证建议 |
| 病情 | 匹配医院 |
| 意向城市 | 推荐医院 |
| 预计时间 | 安排预约 |

### 攻略模板选择
- 牙科 → `template-dental.md`
- 眼科 → `template-eye.md`
- 中医 → `template-tcm.md`
- 心血管 → `template-cardiology.md`
- 肿瘤 → `template-oncology.md`
- 骨科 → `template-orthopedics.md`

---

## ⚙️ 自动化工作流

### 工作流1: 潜在客户跟进
```
表单提交 → Zapier捕获 → Airtable记录 → Gmail自动回复 → Slack通知 → Notion任务
```

### 工作流2: 博客自动分发
```
新博客发布 → RSS触发 → Buffer排期 → Mailchimp简报 → Notion更新
```

### 工作流3: 支付处理
```
Stripe付款 → Airtable更新 → Gmail收据 → Notion任务 → Sheets记账 → Slack通知
```

---

## 🛠️ 技术栈

### 网站
- **托管**: GitHub Pages
- **域名**: chinahospitalsguide.com
- **CDN**: 未明确（可能用Cloudflare）

### 营销工具
| 工具 | 用途 | 费用 |
|------|------|------|
| Zapier | 工作流引擎 | $20/月 |
| Airtable | CRM/数据库 | 免费版 |
| Mailchimp | 邮件营销 | 免费版 |
| Buffer/Hootsuite | 社媒管理 | - |
| Slack | 团队通知 | 免费版 |

### 支付
- Stripe（目标）
- PayPal（目标）

---

## 📊 关键数据

### 网站数据
- **医院数量**: 34家
- **年份**: 2026（定期更新）
- **页面加载**: 0.3秒
- **SEO评分**: 29% → 75%（已优化）

### 内容数据
- **博客文章**: 20+篇
- **患者故事**: 多个真实案例
- **邮件序列**: 7封自动化邮件

---

## 🎯 当前待办（从HOT MEMORY）

### P0（紧急）
- [ ] 修复首页Title长度
- [ ] PayPal电话申请（强调"medical tourism service"）
- [ ] WhatsApp注册（用英国号）

### P1（重要）
- [ ] 添加Twitter Card标签
- [ ] Google Search Console提交sitemap
- [ ] 邮箱测试

### P2（常规）
- [ ] 新博客文章
- [ ] 视频脚本3条

---

## 💡 关键经验

### 小德米踩过的坑
1. **医院分类难扩展** → 改用标签系统
2. **费用被质疑** → 加免责声明
3. **页面导航不一致** → 批量更新所有页面
4. **年份过时** → 全局搜索替换

### 与伟烨协作技巧
- **主动汇报**: 做完立刻说，不要等问
- **选项呈现**: 给2-3个方案让选择
- **进度透明**: 还剩多少，预计多久
- **时间偏好**: 晚上6点后是黄金工作时间

---

## 📝 记忆管理规则

### 三层记忆系统
```
🔥 HOT（每天必读）
   └─ 当前活跃任务、今日待办、临时信息

🌡️ WARM（每次必读）
   └─ 用户偏好、稳定配置、常用数据

❄️ COLD（主会话读）
   └─ 长期归档、历史决策、项目总结
```

### 文件命名规范
- 项目前缀: `医疗旅游_`
- 日期日志: `2026-03-15.md`
- 任务准备: `tomorrow-tasks-prep.md`

---

## 🔗 重要文件位置

### 核心文档
- `docs/dademi-experience-handover.md` - 经验传授
- `docs/dademi-operation-manual.md` - 操作手册
- `docs/automation-workflows-medical-tourism.md` - 自动化工作流
- `docs/email-sequences.md` - 邮件序列
- `docs/sop-inquiry-response.md` - 询单SOP
- `docs/whatsapp-templates.md` - WhatsApp话术

### 模板文件
- `docs/template-dental.md`
- `docs/template-eye.md`
- `docs/template-tcm.md`
- `docs/template-cardiology.md`
- `docs/template-oncology.md`
- `docs/template-orthopedics.md`

---

**学习完成！** 🎉

现在我可以：
1. 理解医疗旅游项目的完整业务逻辑
2. 协助处理客户询单和定制攻略
3. 编写符合SEO和转化的博客文章
4. 操作自动化工作流
5. 维护三层记忆系统
6. 与伟烨高效协作

---
*学习来源：小德米的医疗旅游知识库*
*更新时间：2026-03-15*

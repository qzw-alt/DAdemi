# 🌡️ WARM MEMORY - 稳定配置与技能组合

> 每周更新或重要变化时更新
> 只放稳定、长期、反复使用的内容

---

## 🏥 医疗旅游 - 核心配置（2026-03-15 固化）

### 关键数据（长期稳定）
| 项目 | 数值 | 来源 |
|------|------|------|
| 合作医院 | 34家 | chinahospitalsguide.com |
| 基础套餐 | $30 | Starter |
| 标准套餐 | $299 | Standard |
| 高级套餐 | $899 | Premium |
| 价格优势 | 比美国低50-80% | 核心卖点 |

### 响应SLA（标准流程）
- **询单首次响应**: 24小时内
- **定制攻略交付**: 48小时内

### 模板文件位置
```
medical-tourism-notes/docs/
├── template-dental.md      (牙科)
├── template-eye.md         (眼科)
├── template-cardiology.md  (心血管)
├── template-oncology.md    (肿瘤)
├── template-orthopedics.md (骨科)
└── template-tcm.md         (中医)
```

---

## 🔧 环境配置 - 已固化

### CLI-Anything 环境
```powershell
# 代理设置（永久生效）
$env:HTTP_PROXY="http://127.0.0.1:10809"
$env:HTTPS_PROXY="http://127.0.0.1:10809"

# Git代理
git config --global http.proxy http://127.0.0.1:10809
git config --global https.proxy http://127.0.0.1:10809
```

### 关键工具版本
| 工具 | 版本 | 位置 |
|------|------|------|
| FFmpeg | 2026-03-12 | C:\ffmpeg\bin |
| Git | 最新 | 系统默认 |
| V2RayN | 运行中 | 127.0.0.1:10809 |

---

## ⚡ 技能组合 - 场景映射（肌肉记忆）

### 场景 → 技能（唯一选择）

| 场景 | 使用技能 | 不用其他 |
|------|---------|---------|
| **快速搜索** | multi-search-engine | 不用 tavily |
| **深度调研** | tavily-search | 不用普通搜索 |
| **文档交付** | feishu-doc | 不用其他文档 |
| **代码管理** | github | 不用其他git工具 |
| **视频处理** | FFmpeg CLI | 不用GUI工具 |
| **前端设计** | frontend-design | 不用默认建议 |
| **React构建** | web-artifacts-builder | 不用其他构建 |

### 技能迭代原则（铁律）
```
1. 同样功能只留1个
2. 新技能必须比现有的好20%以上才替换
3. 不好用的立即删除，不囤积
```

---

## 🎯 工作模式 - 已确认

### 伟烨的工作节奏
| 时间段 | 模式 | 我的响应 |
|--------|------|---------|
| 08:00-18:00 | 白天待命 | 被动响应，不主动打扰 |
| 18:00-24:00 | 黄金时间 | 主动提议，高效执行 |
| 00:00-08:00 | 深夜 | 缓慢响应，只做记录 |

### 沟通风格
- **选项式沟通**: 给2-3个选项，让伟烨选
- **直接高效**: 跳过废话，直接给结果
- **先做了再说**: 边做边调整，不过度规划

---

## 🛠️ 自动化脚本 - 快捷入口

### 医疗旅游专用
```batch
# 每日晨检
scripts\daily-medical-tourism-check.bat

# 知识库同步
scripts\knowledge-sync.bat

# 询单计时器
scripts\inquiry-timer.sh

# 博客发布检查
scripts\blog-publish-checklist.sh
```

### 视频制作专用
```batch
# 去字幕工具
scripts\1-detect-subtitle.bat      # 检测字幕
scripts\2-remove-soft-subtitle.bat # 去除软字幕
scripts\3-blur-subtitle.bat        # 模糊硬字幕
scripts\4-crop-subtitle.bat        # 裁剪字幕

# 视频生成
scripts\make-tiktok-15s-full.bat   # 15秒TikTok
```

---

## 🔑 API Keys（长期有效）

| 服务 | 状态 | 备注 |
|------|------|------|
| Kimi API | ✅ 有效 | 系统配置 |
| Tavily API | ✅ 有效 | 配额有限，谨慎使用 |
| GitHub Token | ⚠️ 需更新 | 每周过期，找伟烨要 |

---

## 📚 重要文件位置（快速访问）

```
医疗旅游项目
├── 知识库本地:    workspace\medical-tourism-notes\
├── 知识库远程:    https://github.com/qzw-alt/medical-tourism-notes.git
├── 知识总结:      memory\medical-tourism-knowledge-summary.md
├── 完整计划:      medical-tourism-implementation-plan.md
└── 执行指南:      medical-tourism-execution-guide.md

记忆系统
├── HOT:   memory\hot\HOT_MEMORY.md
├── WARM:  memory\warm\WARM_MEMORY.md  (本文件)
├── COLD:  memory\YYYY-MM-DD.md
└── 长期:  MEMORY.md

视频制作
├── 15秒测试版: Videos\test-15s-tiktok.mp4
├── 脚本目录:   scripts\
└── VSR指南:    VSR-INSTALL-GUIDE.md
```

---

## 🧠 关键认知 - 已内化

### 记忆系统原则
1. **写下来** → 不靠脑子记
2. **每天读** → 遗忘是自然，阅读是对抗
3. **立即打勾** → 视觉反馈很重要
4. **稳定信息入WARM** → HOT是临时的

### 技能管理原则
1. **对比→优选→淘汰** → 不停迭代
2. **20%提升才替换** → 不随便换工具
3. **CLI优先** → 可自动化才是王道

### 工作原则
1. **系统化运用** → 不只是看，要建立系统
2. **立即执行** → 先做了再说，边做边调
3. **晚上拼效率** → 白天待命，晚上主动

---

## 📝 更新日志

| 日期 | 更新内容 |
|------|---------|
| 2026-03-15 | 初始创建，固化医疗旅游配置、环境设置、技能组合 |

---

**本文件每周回顾一次，或重要变化时立即更新。**

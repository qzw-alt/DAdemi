# Gridea 实战手册

> 免费博客搭建 2026-03-04

---

## 是什么？

Gridea = 写作客户端 + 免费静态博客托管

**不用买域名！不用买服务器！**

---

## 准备材料

| 材料 | 说明 |
|------|------|
| GitHub账号 | 免费注册 |
| Gridea客户端 | 下载安装 |

---

## 第一步：下载安装 Gridea

1. 访问：https://gridea.dev
2. 下载 Windows/Mac 客户端
3. 安装运行

---

## 第二步：创建 GitHub 仓库

1. 登录 GitHub：https://github.com
2. 创建新仓库，命名为：`你的用户名.github.io`
3. 设置为 **Public**
4. 生成 Personal Access Token：
   - Settings → Developer settings → Personal access tokens → Tokens (classic)
   - Generate new token → 勾选 `repo` 权限
   - 复制生成的 Token

---

## 第三步：配置 Gridea

打开 Gridea，配置：

| 配置项 | 值 |
|--------|-----|
| 仓库地址 | `https://github.com/你的用户名/你的用户名.github.io` |
| 分支 | `master` 或 `main` |
| Token | 刚才生成的 GitHub Token |
| 域名（可选） | 后续可以绑定自己的域名 |

---

## 第四步：开始写作

1. 点击「新建文章」
2. 用 Markdown 写作
3. 点击「同步」发布

---

## 第五步：访问博客

- 你的博客地址：`https://你的用户名.github.io`

---

## 🎯 进阶：绑定自定义域名（可选）

如果以后买了域名，可以在 Gridea 设置：
- 域名填写：`yourdomain.com`
- 然后在域名商处添加 CNAME 记录指向 `你的用户名.github.io`

---

## 📝 写作格式

```markdown
---
title: 我的第一篇文章
tags: [生活, 思考]
published: true
---

# 正文内容

这里是正文...
```

---

## 优势

| 对比项 | Gridea | WordPress |
|--------|--------|-----------|
| 费用 | 免费 | 域名+服务器 |
| 难度 | 简单 | 中等 |
| 速度 | 快 | 依赖服务器 |
| 维护 | 几乎不用 | 需要维护 |

---

## 适合场景

- ✅ 个人博客
- ✅ 作品展示
- ✅ AI 友好内容（静态页面，AI容易抓取）
- ✅ 给客户做简单网站

---

## ⚡ 立即开始

1. 下载 Gridea：https://gridea.dev
2. 准备 GitHub 账号
3. 配置完成，开始写作！

---

**0成本建站，就是这么简单！** 🚀

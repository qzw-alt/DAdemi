# 🏗️ 网站建设SOP（标准操作流程）

> 版本：v1.0 2026-03-04

---

## 📋 建站流程概览

```
第1步：需求确认
    ↓
第2步：购买域名 + 服务器
    ↓
第3步：DNS解析（Cloudflare）
    ↓
第4步：环境搭建（Docker）
    ↓
第5步：WordPress安装（WP-CLI）
    ↓
第6步：主题 + 插件配置
    ↓
第7步：内容上线
    ↓
第8步：测试 + 交付
```

---

## 第1步：需求确认

### 检查清单
- [ ] 客户需求文档
- [ ] 网站类型（博客/企业站/商城）
- [ ] 域名偏好
- [ ] 预算确认

### 输出
- 需求确认单

---

## 第2步：购买域名 + 服务器

### 域名购买
| 平台 | 说明 |
|------|------|
| 阿里云 | 国内首选 |
| Namesilo | 便宜 |
| Cloudflare | 域名商 |

### 服务器购买
| 类型 | 推荐 | 价格 |
|------|------|------|
| 国内 | 阿里云轻量/腾讯云 | ¥200-400/年 |
| 国外 | RackNerd/CloudCone | ¥100-200/年 |

### 检查清单
- [ ] 域名购买完成
- [ ] 服务器购买完成
- [ ] 获取服务器IP
- [ ] 获取登录凭证

---

## 第3步：DNS解析（Cloudflare）

### 操作步骤
1. 登录 Cloudflare
2. 添加域名
3. 修改DNS服务器（域名商处设置）
4. 添加DNS记录

### 命令行操作（可选）
```bash
# 添加A记录
curl -X POST "https://api.cloudflare.com/client/v4/zones/ZONE_ID/dns_records" \
  -H "Authorization: Bearer TOKEN" \
  --data '{"type":"A","name":"@","content":"SERVER_IP"}'
```

### 检查清单
- [ ] Cloudflare账号登录
- [ ] 域名添加成功
- [ ] DNS记录添加完成
- [ ] SSL证书自动签发（Flexiable模式）

---

## 第4步：环境搭建（Docker）

### 服务器环境要求
- Ubuntu 20.04+ / CentOS 8+
- Docker 已安装
- 开放端口：80, 443, 22

### 一键安装Docker
```bash
curl -fsSL https://get.docker.com | bash
systemctl start docker
systemctl enable docker
```

### 创建docker-compose.yml
```yaml
version: '3.8'

services:
  wordpress:
    image: wordpress:latest
    ports:
      - "80:80"
    environment:
      WORDPRESS_DB_HOST: db
      WORDPRESS_DB_USER: wpuser
      WORDPRESS_DB_PASSWORD: strongpassword
      WORDPRESS_DB_NAME: wpdb
    volumes:
      - wordpress:/var/www/html
    depends_on:
      - db

  db:
    image: mysql:8.0
    environment:
      MYSQL_ROOT_PASSWORD: rootpassword
      MYSQL_DATABASE: wpdb
      MYSQL_USER: wpuser
      MYSQL_PASSWORD: strongpassword
    volumes:
      - db:/var/lib/mysql
```

### 启动
```bash
docker-compose up -d
```

### 检查清单
- [ ] Docker安装完成
- [ ] docker-compose.yml配置完成
- [ ] 服务启动成功
- [ ] 端口开放确认

---

## 第5步：WordPress安装（WP-CLI）

### 方式1：后台安装
访问 http://your-domain.com 按提示安装

### 方式2：命令行安装（WP-CLI）
```bash
# 进入容器
docker exec -it wordpress bash

# 下载WP-CLI
curl -O https://raw.githubusercontent.com/wp-cli/builds/master/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

# 安装WordPress
wp core download --locale=zh_CN
wp config create --dbhost=db --dbname=wpdb --dbuser=wpuser --dbpass=strongpassword
wp core install --url="https://your-domain.com" --title="网站标题" --admin_user=admin --admin_password=password --admin_email="email@example.com"
```

### 检查清单
- [ ] WordPress安装完成
- [ ] 后台可登录
- [ ] 前台可访问
- [ ] 中文语言包安装

---

## 第6步：主题 + 插件配置

### 推荐主题（免费）
| 主题 | 用途 |
|------|------|
| GeneratePress | 轻量、快速 |
| Astra | 功能丰富 |
| Hello Elementor | 配合Elementor |

### 推荐插件
| 插件 | 用途 |
|------|------|
| Elementor | 页面构建 |
| WooCommerce | 商城 |
| WP Super Cache | 缓存 |
| UpdraftPlus | 备份 |
| Rank Math SEO | SEO |

### 安装命令
```bash
# 安装主题
wp theme install generatepress --activate

# 安装插件
wp plugin install elementor woocommerce super-cache updraftplus rank-math-seo --activate
```

### 检查清单
- [ ] 主题安装并激活
- [ ] 必要插件安装
- [ ] 基础设置完成
- [ ] 缓存配置

---

## 第7步：内容上线

### 内容清单
- [ ] 首页
- [ ] 关于我们
- [ ] 服务/产品
- [ ] 联系方式
- [ ] 隐私政策

### 上线流程
```bash
# 创建页面
wp post create --post_type=page --post_title="首页" --post_status=publish

# 设置首页
wp option update show_on_front page
wp option update page_on_front PAGE_ID
```

### 检查清单
- [ ] 所有页面创建完成
- [ ] 菜单设置
- [ ] 首页设置
- [ ] 内容检查无误

---

## 第8步：测试 + 交付

### 测试清单
| 测试项 | 方法 |
|--------|------|
| 访问速度 | PageSpeed Insights |
| 移动端适配 | 手机访问测试 |
| 表单功能 | 提交测试 |
| 支付功能 | 测试支付 |
| SEO基础 | meta标签检查 |

### 交付清单
- [ ] 网站访问正常
- [ ] 管理后台账号密码
- [ ] 域名管理账号
- [ ] 服务器管理账号
- [ ] 操作手册

---

## ⏱️ 时间预估

| 阶段 | 时间 |
|------|------|
| 需求确认 | 30分钟 |
| 购买资源 | 30分钟 |
| DNS配置 | 15分钟 |
| 环境搭建 | 30分钟 |
| WP安装 | 30分钟 |
| 主题插件 | 1-2小时 |
| 内容上线 | 2-4小时 |
| 测试交付 | 1小时 |
| **总计** | **6-10小时** |

---

## 💰 成本预估

| 项目 | 成本 |
|------|------|
| 域名 | ¥30-50/年 |
| 服务器 | ¥200-400/年 |
| 主题/插件 | ¥0-500 |
| **年成本** | ¥230-950 |

---

## 🎯 关键成功点

1. **标准化** - 按SOP执行，减少出错
2. **自动化** - 用Docker+WP-CLI提效
3. **文档化** - 每一步都记录
4. **测试** - 交付前充分测试

---

**SOP整理完成！随时可以开始实战！** 🚀

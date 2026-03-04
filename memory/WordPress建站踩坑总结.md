# WordPress 建站踩坑总结

> 日期：2026-03-04

---

## ❌ 踩坑记录

### 1. Docker镜像下载失败
- **问题**：国内服务器连接Docker Hub超时
- **原因**：网络问题，Docker镜像无法下载
- **解决**：改用Ubuntu系统自带的WordPress包（apt install wordpress）

### 2. 远程MySQL连接失败
- **问题**：腾讯云MySQL无法远程连接
- **原因**：
  - 安全组未开放3306端口
  - MySQL未开放远程登录权限
- **解决**：在服务器上安装本地MySQL

### 3. 数据库用户权限问题
- **问题**：WordPress无法连接数据库
- **原因**：配置文件用了root用户，但需要创建专门的wp用户
- **解决**：
  - 创建wordpress数据库
  - 创建wordpress用户并授权

### 4. Apache配置问题
- **问题**：Apache默认指向/var/www/html而非WordPress目录
- **解决**：配置虚拟主机指向/usr/share/wordpress

### 5. WordPress配置文件位置
- **问题**：需要按IP地址命名配置文件
- **解决**：创建/etc/wordpress/config-122.51.199.136.php

---

## ✅ 正确流程（推荐方案）

### 方案：服务器直接安装（不用Docker）

```bash
# 1. 安装Apache + PHP + MySQL
sudo apt update
sudo apt install -y apache2 php mysql-server php-mysql

# 2. 配置MySQL
sudo mysql
CREATE DATABASE wordpress CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER 'wpuser'@'localhost' IDENTIFIED BY '你的密码';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'localhost';
FLUSH PRIVILEGES;
EXIT;

# 3. 安装WordPress
sudo apt install -y wordpress

# 4. 配置Apache
sudo a2enmod rewrite
sudo cp /etc/wordpress/config-default.php /etc/wordpress/config-你的IP.php
# 编辑配置文件，填入数据库信息

# 5. 配置虚拟主机
sudo nano /etc/apache2/sites-available/wordpress.conf
# DocumentRoot改为 /usr/share/wordpress

# 6. 启用站点
sudo a2dissite 000-default.conf
sudo a2ensite wordpress.conf
sudo systemctl restart apache2
```

---

## 📋 避坑清单

| 步骤 | 注意事项 |
|------|----------|
| 1. 服务器 | 选择Ubuntu 22.04 LTS |
| 2. 安装 | 直接用apt安装，不用Docker |
| 3. MySQL | 本地安装，创建独立用户 |
| 4. 配置 | 配置文件按IP命名 |
| 5. Apache | 修改DocumentRoot |
| 6. 测试 | 先本地访问确认 |

---

## 🎯 最佳方案

**推荐：直接用apt安装WordPress**
- 不需要Docker
- 不需要远程数据库
- 配置简单
- 维护容易

---

**下次建站就按这个流程来！** 🚀

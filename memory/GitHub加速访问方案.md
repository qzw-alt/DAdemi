# GitHub访问加速方案

> 研究时间：2026-03-05

## 问题原因
1. 地理位置 - GitHub服务器在美国，距离远
2. CDN加速失效 - 国内CDN节点可能没有缓存

## 解决方案

### 1. 修改HOSTS文件（推荐）
手动绑定GitHub的CDN和IP地址
- 获取github.global.ssl.fastly.net和github.com的IP地址
- 写入系统hosts文件

### 2. 镜像站/代理
- **FastGit** - 基于镜像的加速服务
- **dev-sidecar(开发者边车)** - 浏览器扩展形式的加速工具
- **Steam++** - 也是一个加速工具

### 3. CDN反向代理
- jsdelivr可以加速GitHub上的静态资源
- 原始: `https://github.com/jquery/jquery/archive/refs/tags/3.6.0.zip`
- 加速: `https://cdn.jsdelivr.net/gh/jquery/jquery@3.6.0/dist/jquery.min.js`

### 4. Gitee中转
- 将GitHub仓库导入Gitee
- 从Gitee克隆更快

### 5. 专门的GitHub加速器工具
- GitHub加速器（黑科技）
- 通过智能路由优化实现60%-85%提速

## 后续行动
- [ ] 在伟烨电脑安装dev-sidecar或类似工具
- [ ] 测试修改hosts文件
- [ ] 考虑使用镜像站

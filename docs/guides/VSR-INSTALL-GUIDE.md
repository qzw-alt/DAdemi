# Video Subtitle Remover (VSR) 安装指南

> Intel核显专用版本 (DirectML)
> 适合你的电脑: Intel UHD Graphics 620

---

## 📥 下载方式（推荐）

### 方式1：百度网盘（最快）

**链接**: https://pan.baidu.com/s/1zR6CjRztmOGBbOkqK8R1Ng?pwd=vsr1

**提取码**: `vsr1`

**下载文件**: `vsr-windows-directml.7z`

**文件大小**: 约 800MB-1GB

**适用显卡**: Intel / AMD / NVIDIA（无需CUDA）

**下载步骤**:
1. 打开百度网盘链接
2. 输入提取码: vsr1
3. 下载 `vsr-windows-directml.7z`
4. 解压到任意文件夹
5. 双击 `gui.exe` 运行

---

### 方式2：Google Drive

**链接**: https://drive.google.com/drive/folders/1NRgLNoHHOmdO4GxLhkPbHsYfMOB_3Elr?usp=sharing

**下载文件**: `vsr-windows-directml.7z`

---

### 方式3：源码安装（备用）

如果预编译包下载不了，可以手动安装：

#### 步骤1: 安装 Python 3.12
下载: https://www.python.org/downloads/release/python-3120/
安装时勾选 "Add Python to PATH"

#### 步骤2: 下载源码
```bash
git clone https://github.com/YaoFANGUK/video-subtitle-remover.git
cd video-subtitle-remover
```

#### 步骤3: 创建虚拟环境
```bash
python -m venv vsr_env
vsr_env\Scripts\activate
```

#### 步骤4: 安装依赖（Intel核显版）
```bash
# 安装基础依赖
pip install paddlepaddle==3.0.0 -i https://www.paddlepaddle.org.cn/packages/stable/cpu/
pip install -r requirements.txt

# 安装 DirectML (Intel/AMD显卡支持)
pip install torch_directml==0.2.5.dev240914
```

#### 步骤5: 运行
```bash
# 图形界面
python gui.py

# 命令行
python ./backend/main.py
```

---

## 🚀 使用方法

### GUI版（推荐）

1. **打开软件**
   - 双击 `gui.exe` 或运行 `python gui.py`

2. **选择视频**
   - 点击"选择视频"按钮
   - 选择要去字幕的视频文件

3. **设置参数**
   - **字幕位置**: 框选视频中的字幕区域（通常是底部）
   - **或选择"自动检测"**: 让AI自动识别所有文字

4. **开始处理**
   - 点击"开始去除"
   - 等待处理完成（根据视频长度，几分钟到几十分钟）

5. **查看结果**
   - 处理完成后会生成 `xxx_no_sub.mp4`

### 命令行版

```bash
# 基础用法
python ./backend/main.py --input video.mp4 --output output.mp4

# 指定字幕区域（底部20%）
python ./backend/main.py --input video.mp4 --sub_area 0.8,1.0
```

---

## ⚙️ 配置优化（Intel核显）

编辑 `backend/config.py` 文件，针对Intel核显优化：

```python
# 使用STTN算法（对真人视频效果好，速度快）
MODE = InpaintMode.STTN

# 跳过字幕检测（加快处理速度，但可能误伤）
STTN_SKIP_DETECTION = True

# 降低显存占用（Intel核显显存较小）
STTN_NEIGHBOR_STRIDE = 5
STTN_REFERENCE_LENGTH = 5
STTN_MAX_LOAD_NUM = 15
```

---

## 📁 文件结构

解压后目录结构：
```
video-subtitle-remover/
├── gui.exe              # 图形界面程序
├── backend/             # 核心算法
│   ├── main.py         # 主程序
│   ├── config.py       # 配置文件
│   └── ...
├── models/             # AI模型文件
└── test/               # 测试视频
```

---

## ⚠️ 注意事项

1. **显存要求**: Intel核显建议处理 1080p 以下视频，4K视频可能会卡顿
2. **处理时间**: 比NVIDIA显卡慢，1分钟视频约需5-10分钟处理
3. **最佳效果**: 字幕在固定位置效果最好
4. **字幕类型**: 对白字幕、水印、台标都可以去除

---

## 🆚 对比：VSR vs FFmpeg

| 对比项 | VSR (AI) | FFmpeg (我们的工具) |
|--------|---------|---------------------|
| 去字幕效果 | ⭐⭐⭐⭐⭐ AI修复，无痕 | ⭐⭐ 模糊/裁剪，有痕迹 |
| 处理速度 | 🐢 慢（Intel核显5-10x实时） | ⚡ 快（1x实时） |
| 安装难度 | ⭐⭐⭐ 需要配置环境 | ⭐ 即用即开 |
| 软字幕 | ✅ 支持 | ✅ 支持 |
| 硬字幕 | ✅ AI完美去除 | ⚠️ 仅模糊/裁剪 |
| 推荐场景 | 高质量需求 | 快速简单处理 |

---

## 🎯 建议

**你的情况（Intel UHD 620核显）**:
- 下载 `vsr-windows-directml.7z` 版本
- 处理 720p 或 1080p 视频
- 处理时间约为视频时长的 5-10 倍

**如果只是偶尔使用**:
- 用我们的 FFmpeg 工具（快速模糊/裁剪）
- 不需要下载 1GB 的 VSR

**如果需要专业效果**:
- 下载 VSR DirectML 版本
- 效果接近完美

---

**要我帮你下载安装吗？还是先用 FFmpeg 工具试试？**

---
name: windows-ui-automation
description: Windows UI自动化。使用PowerShell脚本模拟鼠标、键盘和窗口操作，控制桌面应用程序。
---

# Windows UI Automation Skill

## 功能

1. **鼠标操作** - 点击、移动、拖拽
2. **键盘操作** - 输入文字、快捷键
3. **窗口管理** - 激活、最小化、最大化、截图
4. **应用控制** - 启动应用、关闭应用

## 使用方法

### 1. 鼠标点击
```powershell
# 移动鼠标到指定位置并点击
$x = 500; $y = 300
[System.Windows.Forms.Cursor]::Position = "$x,$y"
# 执行左键点击
```

### 2. 键盘输入
```powershell
# 激活窗口
$wshell = New-Object -ComObject wscript.shell
$wshell.AppActivate('窗口标题')

# 输入文字
[System.Windows.Forms.SendKeys]::SendWait('要输入的文字')
```

### 3. 窗口管理
```powershell
# 激活窗口
(New-Object -ComObject WScript.Shell).AppActivate('窗口标题')

# 截图
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Screen]::PrimaryScreen
```

### 4. 执行脚本模板

```powershell
# 激活窗口并输入文字
param([string]$WindowTitle, [string]$Text)
$wshell = New-Object -ComObject wscript.shell
$wshell.AppActivate($WindowTitle)
Start-Sleep -Milliseconds 500
[System.Windows.Forms.SendKeys]::SendWait($Text)
[System.Windows.Forms.SendKeys]::SendWait('~')  # Enter
```

## 示例用例

1. **自动打开Kimi并输入文字**
   - 激活Kimi窗口
   - 定位到输入框
   - 输入文字
   - 点击发送

2. **自动化桌面任务**
   - 打开应用
   - 填写表单
   - 点击按钮

## 注意事项

- 不需要管理员权限
- 需要添加延迟避免竞态条件
- 建议在专用环境运行
- 坐标是相对于主显示器

## 相关工具

- pywinauto (Python)
- pyautogui (Python)
- PyAutoGUI

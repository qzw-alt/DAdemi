# Kimi Automation v4 - 使用FindWindowEx
import ctypes
import time
import pyperclip
import pywinauto

# 找到Kimi主窗口
hwnd = ctypes.windll.user32.FindWindowW(None, "Kimi")
if not hwnd:
    print("未找到Kimi窗口")
    exit(1)

print(f"找到窗口: {hwnd}")

# 激活窗口
ctypes.windll.user32.ShowWindow(hwnd, 9)  # SW_RESTORE
ctypes.windll.user32.SetForegroundWindow(hwnd)
time.sleep(0.5)

# 查找输入框 - 尝试多种方式
# 方法1: 找Edit控件
edit_hwnd = ctypes.windll.user32.FindWindowExW(hwnd, 0, "Edit", None)
if edit_hwnd:
    print(f"找到Edit: {edit_hwnd}")
    ctypes.windll.user32.SetForegroundWindow(edit_hwnd)
    time.sleep(0.2)
else:
    print("未找到Edit")

# 方法2: 找RichEdit控件
rich_hwnd = ctypes.windll.user32.FindWindowExW(hwnd, 0, "RichEdit", None)
if rich_hwnd:
    print(f"找到RichEdit: {rich_hwnd}")

# 方法3: 直接给主窗口发送消息
# 先设置焦点
ctypes.windll.user32.SetFocus(hwnd)
time.sleep(0.2)

# 发送测试文字
test_msg = "TEST456"
pyperclip.copy(test_msg)
pywinauto.keyboard.send_keys("^v")
time.sleep(0.2)
pywinauto.keyboard.send_keys("{ENTER}")

print("已发送!")

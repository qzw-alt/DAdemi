# Kimi Controller - 用Python控制Kimi
import ctypes
import time
import pyperclip
from ctypes import wintypes

user32 = ctypes.windll.user32

# 查找Kimi主窗口
hwnd = user32.FindWindowW(None, "Kimi")
if not hwnd:
    print("未找到Kimi窗口")
    exit(1)

print(f"找到Kimi窗口: {hwnd}")

# 激活窗口
user32.ShowWindow(hwnd, 9)
user32.SetForegroundWindow(hwnd)
time.sleep(0.5)

# 找到输入框 (SearchEditBoxWrapperClass)
input_hwnd = user32.FindWindowExW(hwnd, 0, "SearchEditBoxWrapperClass", None)
if not input_hwnd:
    print("未找到输入框")
    exit(1)

print(f"找到输入框: {input_hwnd}")

# 激活输入框
user32.SetFocus(input_hwnd)
time.sleep(0.3)

# 复制消息到剪贴板
message = "测试消息123"
pyperclip.copy(message)
print(f"已复制: {message}")

# 粘贴 (Ctrl+V)
user32.keybd_event(0x11, 0, 0, 0)  # Ctrl down
time.sleep(0.1)
user32.keybd_event(0x56, 0, 0, 0)  # V down
time.sleep(0.1)
user32.keybd_event(0x56, 0, 2, 0)  # V up
time.sleep(0.1)
user32.keybd_event(0x11, 0, 2, 0)  # Ctrl up
print("已粘贴")

time.sleep(0.3)

# 发送回车
user32.PostMessageW(input_hwnd, 0x0100, 0x0D, 0x001C0001)  # WM_KEYDOWN
time.sleep(0.1)
user32.PostMessageW(input_hwnd, 0x0101, 0x0D, 0x001C0001)  # WM_KEYUP
print("已发送回车")

print("完成!")

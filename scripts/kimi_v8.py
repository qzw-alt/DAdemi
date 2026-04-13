# Kimi Automation v8 - 精确点击输入框
# -*- coding: utf-8 -*-

import ctypes
from ctypes import wintypes
import time
import sys
import io
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')

# 鼠标操作
user32 = ctypes.windll.user32

# 查找Kimi窗口
hwnd = user32.FindWindowW(None, "Kimi")
if not hwnd:
    print("FAIL: 未找到窗口")
    sys.exit(1)

print(f"OK: 找到窗口: {hwnd}")

# 获取窗口位置
rect = wintypes.RECT()
user32.GetWindowRect(hwnd, ctypes.byref(rect))
wx, wy = rect.left, rect.top
ww, wh = rect.right - rect.left, rect.bottom - rect.top

print(f"窗口: {ww}x{wh}")

# 输入框大约在底部，x从50到ww-120，y从wh-60到wh-10
# 尝试点击输入框中心位置
input_x = wx + ww // 2
input_y = wy + wh - 40

print(f"点击位置: {input_x}, {input_y}")

# 点击输入框
user32.SetCursorPos(input_x, input_y)
time.sleep(0.2)
user32.mouse_event(0x0002, 0, 0, 0, 0)  # MOUSEEVENTF_LEFTDOWN
time.sleep(0.1)
user32.mouse_event(0x0004, 0, 0, 0, 0)  # MOUSEEVENTF_LEFTUP
print("OK: 已点击输入框")

time.sleep(0.5)

# 尝试输入文字 - 使用SendKeys方式
# 先激活窗口
user32.SetForegroundWindow(hwnd)
time.sleep(0.3)

# 使用剪贴板粘贴
import pyperclip
pyperclip.copy("TEST_INPUT_123")

# 发送 Ctrl+V
user32.keybd_event(0x11, 0, 0, 0)  # CTRL
time.sleep(0.1)
user32.keybd_event(0x56, 0, 0, 0)  # V
time.sleep(0.1)
user32.keybd_event(0x56, 0, 2, 0)  # V UP
time.sleep(0.1)
user32.keybd_event(0x11, 0, 2, 0)  # CTRL UP
print("OK: 已粘贴")

time.sleep(0.3)

# 点击发送按钮
# 发送按钮大约在 右下角
send_x = wx + ww - 60
send_y = wy + wh - 40
user32.SetCursorPos(send_x, send_y)
time.sleep(0.2)
user32.mouse_event(0x0002, 0, 0, 0, 0)
time.sleep(0.1)
user32.mouse_event(0x0004, 0, 0, 0, 0)
print("OK: 已点击发送")

print("\n完成！请查看Kimi是否收到输入")

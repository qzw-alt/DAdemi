# Kimi Automation v9 - 精确坐标
# -*- coding: utf-8 -*-

import ctypes
from ctypes import wintypes
import time
import sys
import io
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')

user32 = ctypes.windll.user32

hwnd = user32.FindWindowW(None, "Kimi")
if not hwnd:
    print("FAIL: 未找到窗口")
    sys.exit(1)

rect = wintypes.RECT()
user32.GetWindowRect(hwnd, ctypes.byref(rect))
wx, wy = rect.left, rect.top
ww, wh = rect.right - rect.left, rect.bottom - rect.top

print(f"窗口: {wx},{wy} 大小:{ww}x{wh}")

# 根据截图分析，输入框大约在：
# 左边界: ~80px from left
# 右边界: ~80px from right  
# 下边界: ~30px from bottom

# 精确定位输入框
input_left = wx + 80
input_right = wx + ww - 80
input_top = wy + wh - 70
input_bottom = wy + wh - 20

# 输入框中心
input_center_x = (input_left + input_right) // 2
input_center_y = (input_top + input_bottom) // 2

print(f"输入框区域: {input_left},{input_top} 到 {input_right},{input_bottom}")
print(f"输入框中心: {input_center_x},{input_center_y}")

# 移动鼠标到输入框
user32.SetCursorPos(input_center_x, input_center_y)
time.sleep(0.3)

# 单击激活
user32.mouse_event(0x0002, 0, 0, 0, 0)  # DOWN
time.sleep(0.1)
user32.mouse_event(0x0004, 0, 0, 0, 0)  # UP
print("OK: 点击输入框")

time.sleep(0.5)

# 确保窗口在前
user32.SetForegroundWindow(hwnd)
time.sleep(0.3)

# 尝试直接按键输入
# 先清空 (Ctrl+A, Delete)
user32.keybd_event(0x11, 0, 0, 0)  # CTRL
time.sleep(0.1)
user32.keybd_event(0x41, 0, 0, 0)  # A
time.sleep(0.1)
user32.keybd_event(0x41, 0, 2, 0)  # A UP
time.sleep(0.1)
user32.keybd_event(0x11, 0, 2, 0)  # CTRL UP
time.sleep(0.1)

user32.keybd_event(0x2E, 0, 0, 0)  # DELETE
time.sleep(0.1)
user32.keybd_event(0x2E, 0, 2, 0)  # DELETE UP
print("OK: 清空")

time.sleep(0.3)

# 输入文字
import pyperclip
pyperclip.copy("HELLO_KIMI")
time.sleep(0.1)

user32.keybd_event(0x11, 0, 0, 0)  # CTRL
time.sleep(0.1)
user32.keybd_event(0x56, 0, 0, 0)  # V
time.sleep(0.1)
user32.keybd_event(0x56, 0, 2, 0)  # V UP
time.sleep(0.1)
user32.keybd_event(0x11, 0, 2, 0)  # CTRL UP
print("OK: 粘贴")

time.sleep(0.3)

# 找到发送按钮并点击
# 发送按钮在右下角
send_x = wx + ww - 50
send_y = wy + wh - 45
user32.SetCursorPos(send_x, send_y)
time.sleep(0.2)
user32.mouse_event(0x0002, 0, 0, 0, 0)
time.sleep(0.1)
user32.mouse_event(0x0004, 0, 0, 0, 0)
print("OK: 点击发送")

print("\n=== 完成 ===")

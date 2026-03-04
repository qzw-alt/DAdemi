# Kimi Automation v13 - 直接给已存在的输入框发送
# -*- coding: utf-8 -*-

import ctypes
from ctypes import wintypes
import time
import sys
import io
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')

user32 = ctypes.windll.user32

# 输入框句柄
input_hwnd = 67316

print(f"输入框句柄: {input_hwnd}")

# 获取输入框位置
rect = wintypes.RECT()
user32.GetWindowRect(input_hwnd, ctypes.byref(rect))
print(f"输入框位置: {rect.left}, {rect.top}, {rect.right-rect.left}x{rect.bottom-rect.top}")

# 设置焦点
user32.SetFocus(input_hwnd)
time.sleep(0.2)

# 发送回车
print("发送回车...")
user32.PostMessageW(input_hwnd, 0x0100, 0x0D, 0x001C0001)  # WM_KEYDOWN
time.sleep(0.1)
user32.PostMessageW(input_hwnd, 0x0101, 0x0D, 0x001C0001)  # WM_KEYUP

print("OK: 已发送!")
print("\n请检查Kimi是否开始处理!")

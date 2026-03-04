# Kimi Automation v7 - 截图+区域识别
# -*- coding: utf-8 -*-

import ctypes
from ctypes import wintypes
import time
import sys
import io
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')

# 截图相关
from PIL import Image, ImageGrab

# 查找Kimi窗口
user32 = ctypes.windll.user32
hwnd = user32.FindWindowW(None, "Kimi")

if not hwnd:
    print("FAIL: 未找到Kimi窗口")
    sys.exit(1)

print(f"OK: 找到窗口: {hwnd}")

# 获取窗口位置和大小
rect = wintypes.RECT()
user32.GetWindowRect(hwnd, ctypes.byref(rect))
x, y, w, h = rect.left, rect.top, rect.right - rect.left, rect.bottom - rect.top

print(f"窗口位置: {x}, {y}, 宽: {w}, 高: {h}")

# 截取窗口截图
time.sleep(0.5)
screenshot = ImageGrab.grab(bbox=(x, y, x + w, y + h))
screenshot.save("kimi_screenshot.png")
print("OK: 截图已保存")

# 尝试找到输入框区域（通常在窗口底部）
input_y = y + int(h * 0.7)
input_h = int(h * 0.25)

# 截取可能的下半部分（输入区域）
input_area = ImageGrab.grab(bbox=(x, input_y, x + w, input_y + input_h))
input_area.save("kimi_input_area.png")
print("OK: 输入区域截图已保存")

print("\n完成！请查看截图文件确认Kimi界面")

# Kimi Automation v10 - 找到真正的对话窗口
# -*- coding: utf-8 -*-

import ctypes
from ctypes import wintypes
import time
import sys
import io
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')

user32 = ctypes.windll.user32

# 先找到主窗口
hwnd = user32.FindWindowW(None, "Kimi")
if not hwnd:
    print("FAIL: 未找到窗口")
    sys.exit(1)

print(f"主窗口: {hwnd}")

# 枚举所有子窗口，找到可能的对话输入区域
classname = ctypes.create_unicode_buffer(256)

def find_input_windows(hwnd, depth=0):
    # 获取类名
    user32.GetClassNameW(hwnd, classname, 256)
    cn = classname.value
    
    # 获取窗口文本
    text_len = user32.GetWindowTextLengthW(hwnd)
    if text_len > 0:
        text_buf = ctypes.create_unicode_buffer(text_len + 1)
        user32.GetWindowTextW(hwnd, text_buf, text_len + 1)
        text = text_buf.value
    else:
        text = ""
    
    # 获取位置
    rect = wintypes.RECT()
    user32.GetWindowRect(hwnd, ctypes.byref(rect))
    w = rect.right - rect.left
    h = rect.bottom - rect.top
    
    # 打印所有可能的输入相关窗口
    keywords = ["Text", "Edit", "input", "field", "area", "pane", "client"]
    if any(kw.lower() in cn.lower() for kw in keywords) or w > 200:
        print(f"  " * depth + f"[{cn[:30]:<30}] {w}x{h} | {text[:30]}")
    
    # 递归枚举子窗口
    child = user32.FindWindowExW(hwnd, 0, None, None)
    while child:
        find_input_windows(child, depth + 1)
        child = user32.FindWindowExW(hwnd, child, None, None)

print("\n=== 窗口结构 ===")
find_input_windows(hwnd)
print("\n完成")

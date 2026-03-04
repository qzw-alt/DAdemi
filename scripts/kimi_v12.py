# Kimi Automation v12 - 枚举所有控件
# -*- coding: utf-8 -*-

import ctypes
from ctypes import wintypes
import time
import sys
import io
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')

user32 = ctypes.windll.user32
windows = []

def enum_all_windows(hwnd, depth=0):
    # 获取类名
    classname = ctypes.create_unicode_buffer(256)
    user32.GetClassNameW(hwnd, classname, 256)
    cn = classname.value
    
    # 获取文本
    text = ""
    text_len = user32.GetWindowTextLengthW(hwnd)
    if text_len > 0:
        text_buf = ctypes.create_unicode_buffer(text_len + 1)
        user32.GetWindowTextW(hwnd, text_buf, text_len + 1)
        text = text_buf.value
    
    # 获取位置
    rect = wintypes.RECT()
    user32.GetWindowRect(hwnd, ctypes.byref(rect))
    w = rect.right - rect.left
    h = rect.bottom - rect.top
    
    # 存储窗口信息
    windows.append({
        'hwnd': hwnd,
        'class': cn,
        'text': text,
        'rect': (rect.left, rect.top, w, h)
    })
    
    # 递归
    child = user32.FindWindowExW(hwnd, 0, None, None)
    while child:
        enum_all_windows(child, depth + 1)
        child = user32.FindWindowExW(hwnd, child, None, None)

# 从主窗口开始枚举
hwnd = user32.FindWindowW(None, "Kimi")
if hwnd:
    enum_all_windows(hwnd)

# 找到可疑的输入框
print("=== 可疑输入框 ===")
for w in windows:
    if 'Edit' in w['class'] or 'Text' in w['class'] or 'input' in w['class'].lower():
        print(f"找到: {w['class']} 句柄:{w['hwnd']} 位置:{w['rect']} 文本:{w['text'][:20]}")

# 找到有内容的
print("\n=== 有文本的窗口 ===")
for w in windows:
    if w['text'] and len(w['text']) > 0:
        print(f"类:{w['class'][:30]:<30} 文本:{w['text'][:40]}")

# Kimi Automation v11 - 找到输入框并发送
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

print(f"OK: 主窗口: {hwnd}")

# 找到输入框 - SearchEditBoxWrapperClass
input_hwnd = user32.FindWindowExW(hwnd, 0, "SearchEditBoxWrapperClass", None)
if not input_hwnd:
    # 尝试其他方式
    input_hwnd = user32.FindWindowExW(hwnd, 0, "Edit", None)

if input_hwnd:
    print(f"OK: 找到输入框: {input_hwnd}")
    
    # 获取输入框位置
    rect = wintypes.RECT()
    user32.GetWindowRect(input_hwnd, ctypes.byref(rect))
    ix = rect.left
    iy = rect.top
    iw = rect.right - rect.left
    ih = rect.bottom - rect.top
    print(f"输入框位置: {ix},{iy} 大小:{iw}x{ih}")
    
    # 点击输入框激活
    user32.SetCursorPos(ix + iw//2, iy + ih//2)
    time.sleep(0.2)
    user32.mouse_event(0x0002, 0, 0, 0, 0)  # DOWN
    time.sleep(0.1)
    user32.mouse_event(0x0004, 0, 0, 0, 0)  # UP
    print("OK: 点击输入框")
    
    time.sleep(0.3)
    
    # 激活窗口
    user32.SetForegroundWindow(hwnd)
    time.sleep(0.2)
    
    # 发送文字 - 方法：SendMessage WM_SETTEXT
    test_msg = "帮我搜索盛诺一家医疗旅游公司信息"
    
    # 使用SendMessage直接设置文本
    result = user32.SendMessageW(input_hwnd, 0x000C, 0, test_msg)  # WM_SETTEXT
    print(f"SendMessage结果: {result}")
    
    time.sleep(0.3)
    
    # 发送回车键
    user32.PostMessageW(input_hwnd, 0x0100, 0x0D, 0x001C0001)  # WM_KEYDOWN ENTER
    time.sleep(0.1)
    user32.PostMessageW(input_hwnd, 0x0101, 0x0D, 0x001C0001)  # WM_KEYUP ENTER
    print("OK: 已发送回车")
    
else:
    print("FAIL: 未找到输入框")
    
print("\n=== 完成 ===")

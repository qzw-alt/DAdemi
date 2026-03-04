# Kimi Automation v6 - 深度测试版
# 尝试多种方法让Kimi输入文字
# -*- coding: utf-8 -*-

import ctypes
import time
import sys

# 设置输出编码
import io
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')

# 加载必要的DLL
user32 = ctypes.windll.user32

# 查找Kimi窗口
hwnd = user32.FindWindowW(None, "Kimi")
if not hwnd:
    print("FAIL: 未找到Kimi窗口")
    sys.exit(1)

print(f"OK: 找到Kimi窗口: {hwnd}")

# 激活窗口
user32.ShowWindow(hwnd, 9)  # SW_RESTORE
user32.SetForegroundWindow(hwnd)
time.sleep(1)  # 等待窗口激活

print("OK: 窗口已激活")

# 方法1: 发送WM_CHAR消息（字符消息）
def send_char(char):
    # 将焦点设置到Kimi
    user32.SetFocus(hwnd)
    time.sleep(0.1)
    # 发送字符
    user32.SendMessageW(hwnd, 0x0102, ord(char), 0)  # WM_CHAR

# 测试发送文字
test_message = "HELLO"
print(f"SEND: {test_message}")

# 方法1: 逐字符发送
for char in test_message:
    send_char(char)
    time.sleep(0.1)

time.sleep(0.3)
# 发送回车
user32.PostMessageW(hwnd, 0x0100, 0x0D, 0x001C0001)  # WM_KEYDOWN ENTER
time.sleep(0.1)
user32.PostMessageW(hwnd, 0x0101, 0x0D, 0x001C0001)  # WM_KEYUP ENTER

print("DONE: 已发送完成")

# 检查结果
print("\nCHECK: 检查窗口信息...")
child_count = 0
def enum_cb(h, _):
    global child_count
    child_count += 1
    return True

user32.EnumChildWindows(hwnd, ctypes.WINFUNCTYPE(ctypes.c_bool, ctypes.c_int, ctypes.c_int)(enum_cb), 0)
print(f"子窗口数量: {child_count}")

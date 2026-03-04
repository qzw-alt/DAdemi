# 调试脚本 - 查找Kimi窗口信息 v2
import ctypes
from ctypes import wintypes
import sys

# 枚举窗口的回调函数
EnumWindowsProc = ctypes.WINFUNCTYPE(ctypes.c_bool, ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int))

windows = []

def enum_windows_callback(hwnd, lParam):
    if ctypes.windll.user32.IsWindowVisible(hwnd):
        length = ctypes.windll.user32.GetWindowTextLengthW(hwnd)
        if length > 0:
            buff = ctypes.create_unicode_buffer(length + 1)
            ctypes.windll.user32.GetWindowTextW(hwnd, buff, length + 1)
            class_name = ctypes.create_unicode_buffer(256)
            ctypes.windll.user32.GetClassNameW(hwnd, class_name, 256)
            windows.append((hwnd, buff.value, class_name.value))
    return True

# 查找所有窗口
ctypes.windll.user32.EnumWindows(EnumWindowsProc(enum_windows_callback), 0)

# 筛选Kimi相关窗口
print("=== Kimi 相关窗口 ===")
kimi_found = False
for hwnd, title, class_name in windows:
    if 'kimi' in title.lower() or 'KIMI' in title or 'kimi' in class_name.lower():
        print(f"标题: {title}")
        print(f"类名: {class_name}")
        print(f"句柄: {hwnd}")
        print("---")
        kimi_found = True

if not kimi_found:
    print("未找到包含'Kimi'的窗口")
    print("\n所有窗口:")
    for hwnd, title, class_name in windows[:20]:
        if title:
            print(f"  {title[:50]} | {class_name}")

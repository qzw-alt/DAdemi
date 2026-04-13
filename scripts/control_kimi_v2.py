# Kimi Controller - 用Python控制Kimi v2
import ctypes
import time
import pyperclip
from ctypes import wintypes

user32 = ctypes.windll.user32

# 尝试多种方式找窗口
def find_kimi_window():
    # 方法1: 找名为"Kimi"的窗口
    hwnd = user32.FindWindowW(None, "Kimi")
    if hwnd:
        return hwnd, "Kimi"
    
    # 方法2: 找SunAwtFrame类（Java窗口）
    hwnd = user32.FindWindowW("SunAwtFrame", None)
    if hwnd:
        return hwnd, "SunAwtFrame"
    
    # 方法3: 枚举所有窗口
    windows = []
    def enum_cb(h, _):
        classname = ctypes.create_unicode_buffer(256)
        user32.GetClassNameW(h, classname, 256)
        if "Kimi" in classname.value or "kimi" in classname.value:
            windows.append((h, classname.value))
        return True
    
    user32.EnumWindows(ctypes.WINFUNCTYPE(ctypes.c_bool, ctypes.c_int, ctypes.c_int)(enum_cb), 0)
    if windows:
        return windows[0][0], windows[0][1]
    
    return None, None

hwnd, classname = find_kimi_window()
if not hwnd:
    print("未找到Kimi窗口")
    exit(1)

print(f"找到窗口: {hwnd}, 类名: {classname}")

# 激活窗口
user32.ShowWindow(hwnd, 9)
user32.SetForegroundWindow(hwnd)
time.sleep(0.5)

# 找到输入框 (SearchEditBoxWrapperClass)
input_hwnd = user32.FindWindowExW(hwnd, 0, "SearchEditBoxWrapperClass", None)
if not input_hwnd:
    print("未找到输入框，尝试其他类名...")
    # 尝试其他Java控件类名
    for cls in ["TextField", "TextArea", "Edit"]:
        input_hwnd = user32.FindWindowExW(hwnd, 0, cls, None)
        if input_hwnd:
            print(f"找到输入框: {cls}")
            break

if not input_hwnd:
    print("未找到任何输入框")
    exit(1)

print(f"找到输入框: {input_hwnd}")

# 激活输入框
user32.SetFocus(input_hwnd)
time.sleep(0.3)

# 复制消息到剪贴板
message = "你好Kimi！测试消息"
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

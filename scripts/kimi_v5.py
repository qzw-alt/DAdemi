# Kimi Automation v5 - 使用SendMessage直接发送文字
import ctypes
import time
import win32api
import win32con

# 找到Kimi主窗口
hwnd = ctypes.windll.user32.FindWindowW(None, "Kimi")
if not hwnd:
    print("未找到Kimi窗口")
    exit(1)

print(f"找到窗口: {hwnd}")

# 激活窗口
ctypes.windll.user32.ShowWindow(hwnd, 9)
ctypes.windll.user32.SetForegroundWindow(hwnd)
time.sleep(0.8)

# 查找子窗口 - Kimi是Java程序，输入框可能在子窗口里
# 方法1: 遍历所有子窗口
child_windows = []

def enum_child_callback(hwnd, data):
    class_name = ctypes.create_unicode_buffer(256)
    ctypes.windll.user32.GetClassNameW(hwnd, class_name, 256)
    text_len = ctypes.windll.user32.GetWindowTextLengthW(hwnd)
    if text_len > 0:
        text = ctypes.create_unicode_buffer(text_len + 1)
        ctypes.windll.user32.GetWindowTextW(hwnd, text, text_len + 1)
        child_windows.append((hwnd, class_name.value, text.value))
    else:
        child_windows.append((hwnd, class_name.value, ""))
    return True

EnumChildProc = ctypes.WINFUNCTYPE(ctypes.c_bool, ctypes.c_int, ctypes.c_int)
ctypes.windll.user32.EnumChildWindows(hwnd, EnumChildProc(enum_child_callback), 0)

print(f"找到 {len(child_windows)} 个子窗口:")
for h, c, t in child_windows:
    print(f"  类: {c[:30]:<30} | 文本: {t[:30]}")

# 尝试找到可能是输入框的窗口
# Java的文本输入通常是 "TextField" 或 "TextArea"
input_hwnd = None
for h, c, t in child_windows:
    if "Text" in c or "Edit" in c or "input" in c.lower():
        input_hwnd = h
        print(f"找到可能输入框: {h} - {c}")
        break

if input_hwnd:
    # 给输入框发送文字
    # 使用WM_SETTEXT
    msg = "HELLO_KIMI"
    ctypes.windll.user32.SendMessageW(input_hwnd, win32con.WM_SETTEXT, 0, msg)
    print(f"已发送文字到 {input_hwnd}")
    time.sleep(0.3)
    # 发送回车
    ctypes.windll.user32.PostMessageW(input_hwnd, win32con.WM_KEYDOWN, win32con.VK_RETURN, 0)
    time.sleep(0.1)
    ctypes.windll.user32.PostMessageW(input_hwnd, win32con.WM_KEYUP, win32con.VK_RETURN, 0)
    print("已发送回车!")
else:
    print("未找到输入框，尝试直接发送到主窗口")
    # 最后尝试：发送到主窗口
    msg = "HI_KIMI"
    ctypes.windll.user32.SendMessageW(hwnd, win32con.WM_SETTEXT, 0, msg)
    time.sleep(0.3)
    ctypes.windll.user32.PostMessageW(hwnd, win32con.WM_KEYDOWN, win32con.VK_RETURN, 0)
    print("已尝试发送")

print("完成!")

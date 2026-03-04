# Kimi Controller v4 - 用户说输入框在下部偏右边
import ctypes
from ctypes import wintypes
import time
import pyperclip

user32 = ctypes.windll.user32

# 找到Kimi窗口
hwnd = user32.FindWindowW("SunAwtFrame", None)
if not hwnd:
    hwnd = user32.FindWindowW(None, "Kimi")

if not hwnd:
    print("未找到Kimi")
    exit(1)

print(f"窗口: {hwnd}")

# 获取窗口位置
rect = wintypes.RECT()
user32.GetWindowRect(hwnd, ctypes.byref(rect))
x, y = rect.left, rect.top
w, h = rect.right - rect.left, rect.bottom - rect.top

print(f"窗口: {w}x{h}, 位置: {x},{y}")

# 输入框在"下部，偏右边"
# 假设：右边区域 = 窗口宽度的40%，输入框在下部往上80像素
right_section_x = x + int(w * 0.55)  # 55%位置开始是右边
input_x = right_section_x + 100  # 偏右边
input_y = y + h - 80  # 下部

print(f"输入框位置: {input_x},{input_y}")

# 激活窗口
user32.SetForegroundWindow(hwnd)
time.sleep(0.5)

# 点击输入框
user32.SetCursorPos(input_x, input_y)
time.sleep(0.3)
user32.mouse_event(0x0002, 0, 0, 0, 0)
time.sleep(0.1)
user32.mouse_event(0x0004, 0, 0, 0, 0)
print("点击输入框")

time.sleep(0.5)

# 输入文字
pyperclip.copy("测试消息123")
time.sleep(0.1)

# Ctrl+V
user32.keybd_event(0x11, 0, 0, 0)
time.sleep(0.1)
user32.keybd_event(0x56, 0, 0, 0)
time.sleep(0.1)
user32.keybd_event(0x56, 0, 2, 0)
time.sleep(0.1)
user32.keybd_event(0x11, 0, 2, 0)
print("已粘贴")

time.sleep(0.3)

# 点击发送 - 输入框右边
send_x = input_x + 200
send_y = input_y
user32.SetCursorPos(send_x, send_y)
time.sleep(0.2)
user32.mouse_event(0x0002, 0, 0, 0, 0)
time.sleep(0.1)
user32.mouse_event(0x0004, 0, 0, 0, 0)
print("已点击发送")

print("完成!")

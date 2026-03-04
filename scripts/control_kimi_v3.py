# Kimi Controller v3 - 基于窗口位置
import ctypes
from ctypes import wintypes
import time
import pyperclip

user32 = ctypes.windll.user32

# 找到Kimi窗口
hwnd = user32.FindWindowW("SunAwtFrame", None)
if not hwnd:
    # 尝试其他方式
    hwnd = user32.FindWindowW(None, "Kimi")

if not hwnd:
    print("未找到Kimi")
    exit(1)

print(f"窗口: {hwnd}")

# 获取窗口位置
rect = ctypes.wintypes.RECT()
user32.GetWindowRect(hwnd, ctypes.byref(rect))
x, y = rect.left, rect.top
w, h = rect.right - rect.left, rect.bottom - rect.top

print(f"窗口大小: {w}x{h}, 位置: {x},{y}")

# 根据截图，输入框在左边底部
# 假设：左边区域 = 窗口宽度的60%，输入框在底部往上30像素
left_section_x = x + 50
left_section_w = int(w * 0.55)
input_x = left_section_x + left_section_w // 2
input_y = y + h - 80  # 底部往上80像素

print(f"计算输入框位置: {input_x},{input_y}")

# 先把窗口激活
user32.SetForegroundWindow(hwnd)
time.sleep(0.5)

# 移动鼠标到输入框位置并点击
user32.SetCursorPos(input_x, input_y)
time.sleep(0.3)

# 点击
user32.mouse_event(0x0002, 0, 0, 0, 0)  # MOUSEEVENTF_LEFTDOWN
time.sleep(0.1)
user32.mouse_event(0x0004, 0, 0, 0, 0)  # MOUSEEVENTF_LEFTUP
print("已点击输入框")

time.sleep(0.5)

# 输入文字
pyperclip.copy("你好Kimi，测试消息")
time.sleep(0.1)

# Ctrl+V 粘贴
user32.keybd_event(0x11, 0, 0, 0)  # Ctrl
time.sleep(0.1)
user32.keybd_event(0x56, 0, 0, 0)  # V
time.sleep(0.1)
user32.keybd_event(0x56, 0, 2, 0)  # V up
time.sleep(0.1)
user32.keybd_event(0x11, 0, 2, 0)  # Ctrl up
print("已粘贴")

time.sleep(0.3)

# 点击发送按钮 - 在输入框右边
send_x = x + w - 60
send_y = input_y
user32.SetCursorPos(send_x, send_y)
time.sleep(0.2)
user32.mouse_event(0x0002, 0, 0, 0, 0)
time.sleep(0.1)
user32.mouse_event(0x0004, 0, 0, 0, 0)
print("已点击发送")

print("完成!")

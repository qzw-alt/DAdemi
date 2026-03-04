# 只发送文字，不点击
import pyperclip
import ctypes
import time

user32 = ctypes.windll.user32

# 复制文字到剪贴板
pyperclip.copy("你好Kimi！测试消息")
print("已复制到剪贴板")

time.sleep(0.3)

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

# 发送回车
user32.keybd_event(0x0D, 0, 0, 0)  # Enter
time.sleep(0.1)
user32.keybd_event(0x0D, 0, 2, 0)  # Enter up
print("已发送")

print("完成!")

# Kimi Test Script - 简单测试版
import pywinauto
import time
import pyperclip

# 连接Kimi
app = pywinauto.Application(backend="win32")
app.connect(process=8308)

print("已连接")

# 尝试找到输入窗口
windows = app.windows()
print(f"找到 {len(windows)} 个窗口")

# 尝试激活窗口
try:
    # 用API激活
    import ctypes
    hwnd = ctypes.windll.user32.FindWindowW(None, "Kimi")
    if hwnd:
        print(f"找到窗口句柄: {hwnd}")
        ctypes.windll.user32.ShowWindow(hwnd, 9)  # SW_RESTORE
        ctypes.windll.user32.SetForegroundWindow(hwnd)
        time.sleep(0.5)
        print("窗口已激活")
        
        # 测试输入
        pyperclip.copy("TEST123")
        pywinauto.keyboard.send_keys("^v")
        time.sleep(0.2)
        pywinauto.keyboard.send_keys("{ENTER}")
        print("已发送测试消息!")
    else:
        print("未找到窗口")
except Exception as e:
    print(f"错误: {e}")

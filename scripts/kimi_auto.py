# Kimi UI Automation Script v3
# 使用Java Robot方式或直接按键模拟

import pywinauto
import time
import sys
import os

def send_to_kimi(message):
    """发送消息到Kimi窗口"""
    try:
        print("开始连接Kimi...")
        
        # 连接Kimi进程
        app = pywinauto.Application(backend="win32")
        app.connect(process=8308)
        
        # 找到主窗口 - Java AWT的窗口通常没有标题
        # 找到包含"im" class的窗口（Input Method）
        windows = app.windows()
        
        # 尝试激活窗口并发送消息
        for w in windows:
            try:
                title = w.window_text()
                # 找到消息输入区域 - 通常是较大的Edit控件
                if "Default IME" not in title and title:
                    print(f"尝试窗口: {title}")
            except:
                pass
        
        # 最简单的方法：使用剪贴板 + 激活窗口
        import pyperclip
        pyperclip.copy(message)
        
        # 激活Kimi窗口
        try:
            kimi_window = app.window(title="M")
            kimi_window.set_focus()
            time.sleep(0.3)
        except:
            print("无法激活窗口，尝试其他方法")
        
        # 尝试找到输入框 - 通常是Edit类型
        # Java AWT的文本输入通常是TextField或TextArea
        try:
            # 尝试查找所有Edit控件
            edits = app.windows(class_name="Edit")
            if edits:
                print(f"找到 {len(edits)} 个编辑框")
                edits[0].set_focus()
                time.sleep(0.2)
                # 粘贴
                pywinauto.keyboard.send_keys("^v")
                time.sleep(0.2)
                pywinauto.keyboard.send_keys("{ENTER}")
                print("发送成功!")
                return True
        except Exception as e:
            print(f"Edit方式失败: {e}")
        
        # 最后尝试：直接使用键盘模拟
        print("尝试直接键盘模拟...")
        # 先激活窗口
        try:
            # 使用win32 api激活窗口
            import ctypes
            hwnd = ctypes.windll.user32.FindWindowW(None, "Kimi")
            if hwnd:
                ctypes.windll.user32.SetForegroundWindow(hwnd)
                time.sleep(0.3)
                # 粘贴
                pywinauto.keyboard.send_keys("^v")
                time.sleep(0.2)
                pywinauto.keyboard.send_keys("{ENTER}")
                print("通过API发送成功!")
                return True
        except Exception as e:
            print(f"API方式也失败: {e}")
        
        print("尝试了所有方法都失败了")
        return False
        
    except Exception as e:
        print(f"错误: {e}")
        import traceback
        traceback.print_exc()
        return False

if __name__ == "__main__":
    if len(sys.argv) > 1:
        message = " ".join(sys.argv[1:])
        print(f"发送消息: {message}")
        send_to_kimi(message)
    else:
        print("用法: python kimi_auto.py \"消息内容\"")
        print("测试模式:")
        send_to_kimi("测试消息")

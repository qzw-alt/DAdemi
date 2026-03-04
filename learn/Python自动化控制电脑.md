# Python 电脑控制/自动化 资料汇总

## 常用库

### 1. PyAutoGUI
最流行的Python鼠标键盘自动化库
- 官网：https://pyautogui.readthedocs.io/
- 安装：`pip install pyautogui`
- 功能：鼠标点击/移动、键盘输入、截图

### 2. pywinauto
Windows GUI自动化专用库（我们已经在用）
- 官网：https://github.com/pywinauto/pywinauto
- 安装：`pip install pywinauto`
- 功能：控件识别、窗口操作、自动化测试

### 3. pyperclip
剪贴板操作（我们已经在用）
- 安装：`pip install pyperclip`

### 4. pytesseract + pillow
OCR文字识别（截图识字）
- 安装：`pip install pytesseract pillow`

---

## 推荐教程

### Automate the Boring Stuff
https://automatetheboringstuff.com/
免费在线教程，非常详细

### GeeksforGeeks
https://www.geeksforgeeks.org/python/mouse-keyboard-automation-using-python/

### Instructables
https://www.instructables.com/Controlling-Mouse-and-Keyboard-Actions-Using-Pytho/

---

## 常用代码示例

### 1. 鼠标操作
```python
import pyautogui

# 移动鼠标
pyautogui.moveTo(100, 100, duration=1)

# 点击
pyautogui.click()

# 拖拽
pyautogui.dragTo(200, 200)
```

### 2. 键盘操作
```python
import pyautogui

# 输入文字
pyautogui.write('Hello')

# 快捷键
pyautogui.hotkey('ctrl', 'c')  # 复制
pyautogui.hotkey('ctrl', 'v')  # 粘贴

# 按键
pyautogui.press('enter')
```

### 3. 截图
```python
import pyautogui

screenshot = pyautogui.screenshot()
screenshot.save('screen.png')
```

---

## 进阶：Java应用控制

对于Kimi这种Java应用：
1. 使用鼠标点击+剪贴板粘贴
2. 使用SendKeys
3. 使用坐标定位

---

## 下一步可以安装

如果需要更强大的功能，可以安装：
- `pip install pyautogui` - 更容易使用的API
- `pip install pytesseract` - OCR文字识别
- `pip install opencv-python` - 图像识别

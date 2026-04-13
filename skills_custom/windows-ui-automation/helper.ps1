# Windows UI Automation Helper
# 用于控制桌面应用的PowerShell脚本

Add-Type -AssemblyName System.Windows.Forms

# 设置鼠标位置并点击
function Set-MouseClick {
    param([int]$X, [int]$Y)
    [System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($X, $Y)
    Start-Sleep -Milliseconds 100
    [System.Windows.Forms.MouseEvent]::LeftClick
}

# 激活窗口
function Activate-Window {
    param([string]$Title)
    $wshell = New-Object -ComObject wscript.shell
    $wshell.AppActivate($Title)
    Start-Sleep -Milliseconds 500
}

# 发送文字
function Send-Text {
    param([string]$Text)
    [System.Windows.Forms.SendKeys]::SendWait($Text)
}

# 发送按键
function Send-Key {
    param([string]$Key)
    [System.Windows.Forms.SendKeys]::SendWait($Key)
}

# 截图
function Take-Screenshot {
    param([string]$Path = "screenshot.png")
    Add-Type -AssemblyName System.Drawing
    $screen = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds
    $bitmap = New-Object System.Drawing.Bitmap($screen.Width, $screen.Height)
    $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
    $graphics.CopyFromScreen($screen.Location, [System.Drawing.Point]::Empty, $screen.Size)
    $bitmap.Save($Path)
    $graphics.Dispose()
    $bitmap.Dispose()
}

# 示例：操作Kimi
function Invoke-KimiAction {
    param([string]$Message)
    
    # 激活Kimi窗口
    Activate-Window -Title "Kimi"
    
    # 等待加载
    Start-Sleep -Seconds 1
    
    # 发送消息
    Send-Text -Text $Message
    Start-Sleep -Milliseconds 300
    Send-Key -Key "~"  # Enter
}

# 如果直接运行脚本
if ($args.Count -gt 0) {
    $action = $args[0]
    switch ($action) {
        "click" { Set-MouseClick -X $args[1] -Y $args[2] }
        "activate" { Activate-Window -Title $args[1] }
        "type" { Send-Text -Text $args[1] }
        "screenshot" { Take-Screenshot }
        "kimi" { Invoke-KimiAction -Message $args[1] }
    }
}

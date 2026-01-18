@echo off
:: 通过 fltmc 触发 UAC 提权
fltmc >nul 2>&1 || (
    echo 请求管理员权限...
    PowerShell Start-Process -FilePath "%0" -Verb RunAs
    exit
)

:: 以下是需要管理员权限的命令
taskkill /f /im ctfxlauncher.exe
echo ctfxlauncher.exe has been stopped!
pause
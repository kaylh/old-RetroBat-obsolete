@echo off
if "%enable_joytokey%"=="yes" tasklist | find /i "joytokey.exe" && taskkill /im joytokey.exe /f
exit
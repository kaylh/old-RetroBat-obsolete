@echo off
if "%enable_joytokey%"=="1" tasklist | find /i "joytokey.exe" && taskkill /im joytokey.exe /f
exit
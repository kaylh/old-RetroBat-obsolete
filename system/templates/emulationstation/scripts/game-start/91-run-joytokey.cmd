@echo off
goto:rem
***************************************
This file is part of RetroBat Scripts.
***************************************
:rem
for /f "delims=" %%x in (%setup_dir%\system\setup.info) do (set "%%x")
if "%enable_joytokey%"=="1" if exist %system_dir%\joytokey\joytokey.exe start "" %system_dir%\joytokey\joytokey.exe
exit

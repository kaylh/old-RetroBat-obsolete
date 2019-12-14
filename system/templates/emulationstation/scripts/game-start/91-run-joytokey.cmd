@echo off
goto:rem
***************************************
This file is part of RetroBat Scripts.
***************************************
:rem
for /f "delims=" %%x in (..\system\retrobat.setup) do (set "%%x")
if "%enable_joytokey%"=="yes" if exist %system_dir%\joytokey\joytokey.exe start "" ..\system\joytokey\joytokey.exe
exit

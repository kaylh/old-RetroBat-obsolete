@echo off
goto:rem
***************************************
This file is part of RetroBat Scripts.
(c) 2017-2019 Adrien Chalard "Kayl" 
***************************************
:rem

for /f "delims=" %%x in (..\system\retrobat.setup) do (set "%%x")

if exist %system_dir%\joytokey\joytokey.exe start "" ..\system\joytokey\joytokey.exe

exit

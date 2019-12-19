@echo off
echo (new ActiveXObject("WScript.Shell")).AppActivate("EmulationStation"); > %scripts_dir%\focus.js
cscript //nologo focus.js
del %scripts_dir%\focus.js
goto:eof
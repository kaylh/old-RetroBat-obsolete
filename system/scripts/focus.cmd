@echo off
goto:rem
***************************************
This file is part of RetroBat Scripts.
---------------------------------------
file name: showlogo.cmd
language: batch, javascript
author: Kayl 
***************************************
:rem
cd %scripts_dir%
echo (new ActiveXObject("WScript.Shell")).AppActivate("EmulationStation"); > %scripts_dir%\focus.js
cscript //nologo focus.js
del/Q %scripts_dir%\focus.js>nul
cd %setup_dir%
goto:eof
@echo off
goto:rem
***************************************
This file is part of RetroBat Scripts.
***************************************
:rem

for /f "delims=" %%x in (%setup_dir%\system\setup.info) do (set "%%x")
for /f "delims=" %%x in (%config_dir%\retrobat.cfg) do (set "%%x")
for /f "delims=" %%x in (%setup_dir%\modules\desktop_resolution.info) do (set "%%x")

if "%set_screen_resolution%"=="1" %setup_dir%\system\modules\qres.exe /X:%desktop_xres% /Y:%desktop_yres% >nul

exit
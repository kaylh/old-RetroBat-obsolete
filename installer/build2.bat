@echo off
title retrobat installer build script
setlocal EnableDelayedExpansion

REM PATH
set current_file=%~nx0
set current_drive="%cd:~0,2%"
set current_dir="%cd:~3%"
set current_drive=%current_drive:"=%
set current_dir=%current_dir:"=%
rem set "current_dir=%current_dir%"
set current_path=!current_drive!\!current_dir!
set update_dir=!current_path!
set modules_dir=!current_path!\..\system\modules
set download_dir=!current_path!\..\system\download
set retrobat_main_dir=!current_path!\..
set emulationstation_dir=!current_path!
set emulatorlauncher_dir=!emulationstation_dir!
set default_theme_dir=!emulationstation_dir!\.emulationstation\themes
set emulator_dir=!retrobat_main_dir!\emulators
set decorations_dir=!retrobat_main_dir!\system\decorations
set nsis_dir=!current_path!\nsis
REM END PATH
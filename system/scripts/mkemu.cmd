@echo off
goto:rem
***************************************
This file is part of RetroBat Scripts.
---------------------------------------
file name: mkemu.cmd
language: batch
author: Kayl 
***************************************
:rem

if not exist %setup_dir%\emulationstation\. md  %setup_dir%\emulationstation
if not exist %setup_dir%\emulationstation\.emulationstation\. md  %setup_dir%\emulationstation\.emulationstation
if not exist %setup_dir%\emulationstation\.emulationstation\music\. md  %setup_dir%\emulationstation\.emulationstation\music
if not exist %setup_dir%\emulationstation\.emulationstation\video\. md  %setup_dir%\emulationstation\.emulationstation\video
if exist %templates_dir%\emulationstation\emulatorLauncher.cfg if not exist %setup_dir%\emulationstation\emulatorLauncher.cfg copy/y %templates_dir%\emulationstation\emulatorLauncher.cfg %setup_dir%\emulationstation\emulatorLauncher.cfg>nul
if exist %templates_dir%\emulationstation\es_input.cfg if not exist %setup_dir%\emulationstation\.emulationstation\es_input.cfg copy/y %templates_dir%\emulationstation\es_input.cfg %setup_dir%\emulationstation\.emulationstation\es_input.cfg>nul
if exist %templates_dir%\emulationstation\es_settings.cfg if not exist %setup_dir%\emulationstation\.emulationstation\es_settings.cfg copy/y %templates_dir%\emulationstation\es_settings.cfg %setup_dir%\emulationstation\.emulationstation\es_settings.cfg>nul
if exist %templates_dir%\emulationstation\es_systems.cfg if not exist %setup_dir%\emulationstation\.emulationstation\es_systems.cfg copy/y %templates_dir%\emulationstation\es_systems.cfg %setup_dir%\emulationstation\.emulationstation\es_systems.cfg>nul
if exist %templates_dir%\emulationstation\es_features.cfg if not exist %setup_dir%\emulationstation\.emulationstation\es_features.cfg copy/y %templates_dir%\emulationstation\es_features.cfg %setup_dir%\emulationstation\.emulationstation\es_features.cfg>nul
if not exist %setup_dir%\emulationstation\.emulationstation\scripts\. if exist %templates_dir%\emulationstation\scripts\. xcopy/Y /e /i "%templates_dir%\emulationstation\scripts" "%setup_dir%\emulationstation\.emulationstation\scripts">nul

if not exist %setup_dir%\bios\. md  %setup_dir%\bios
if exist %templates_dir%\infos\info-bios.txt if not exist %setup_dir%\bios\_infos.txt copy/y %templates_dir%\infos\info-bios.txt %setup_dir%\bios\_infos.txt>nul

if not exist %setup_dir%\kodi\. md  %setup_dir%\kodi
if exist %templates_dir%\infos\info-kodi.txt if not exist %setup_dir%\kodi\_infos.txt copy/y %templates_dir%\infos\info-kodi.txt %setup_dir%\kodi\_infos.txt>nul
if exist %templates_dir%\kodi\gamelist.xml if not exist %setup_dir%\kodi\gamelist.xml copy/y %templates_dir%\kodi\gamelist.xml %setup_dir%\kodi\gamelist.xml>nul
if exist %templates_dir%\kodi\_media\kodi-logo.png xcopy/Y /e /i "%templates_dir%\kodi\_media" "%setup_dir%\kodi\_media">nul

if not exist %emulators_dir%\applewin\. md %emulators_dir%\applewin
if exist %templates_dir%\infos\info-emu.txt if not exist %emulators_dir%\applewin\_infos.txt copy/y %templates_dir%\infos\info-emu.txt %emulators_dir%\applewin\_infos.txt>nul

if not exist %emulators_dir%\demul\. md %emulators_dir%\demul
if exist %templates_dir%\demul\Demul.ini if not exist %emulators_dir%\demul\Demul.ini copy/y %templates_dir%\demul\Demul.ini %emulators_dir%\demul\Demul.ini>nul
if exist %templates_dir%\infos\info-emu.txt if not exist %emulators_dir%\demul\_infos.txt copy/y %templates_dir%\infos\info-emu.txt %emulators_dir%\demul\_infos.txt>nul

if not exist %emulators_dir%\demul-old\. md %emulators_dir%\demul-old
if exist %templates_dir%\demul-old\Demul.ini if not exist %emulators_dir%\demul-old\Demul.ini copy/y %templates_dir%\demul-old\Demul.ini %emulators_dir%\demul-old\Demul.ini>nul
if exist %templates_dir%\infos\info-emu.txt if not exist %emulators_dir%\demul-old\_infos.txt copy/y %templates_dir%\infos\info-emu.txt %emulators_dir%\demul-old\_infos.txt>nul

if not exist %emulators_dir%\cemu\. md %emulators_dir%\cemu
if exist %templates_dir%\infos\info-emu.txt if not exist %emulators_dir%\cemu\_infos.txt  copy/y %templates_dir%\infos\info-emu.txt %emulators_dir%\cemu\_infos.txt>nul

if not exist %emulators_dir%\citra\. md %emulators_dir%\citra
if not exist %emulators_dir%\citra\user\. md %emulators_dir%\citra\user
if exist %templates_dir%\infos\info-emu.txt if not exist %emulators_dir%\citra\_infos.txt copy/y %templates_dir%\infos\info-emu.txt %emulators_dir%\citra\_infos.txt>nul

if not exist %emulators_dir%\cxbx-reloaded\. md %emulators_dir%\cxbx-reloaded
if exist %templates_dir%\infos\info-emu.txt if not exist %emulators_dir%\cxbx-reloaded\_infos.txt copy/y %templates_dir%\infos\info-emu.txt %emulators_dir%\cxbx-reloaded\_infos.txt>nul

if not exist %emulators_dir%\daphne\. md %emulators_dir%\daphne
if exist %templates_dir%\infos\info-emu.txt if not exist %emulators_dir%\daphne\_infos.txt copy/y %templates_dir%\daphne\info-emu.txt %emulators_dir%\daphne\_infos.txt>nul

if not exist %emulators_dir%\dolphin-emu\. md %emulators_dir%\dolphin-emu
if not exist %emulators_dir%\dolphin-emu\portable.txt echo.>> %emulators_dir%\dolphin-emu\portable.txt
if not exist %emulators_dir%\dolphin-triforce\. md %emulators_dir%\dolphin-triforce
if not exist %emulators_dir%\dolphin-triforce\portable.txt echo.>> %emulators_dir%\dolphin-triforce\portable.txt
if not exist %emulators_dir%\dolphin-triforce\User\. md %emulators_dir%\dolphin-triforce\User
if not exist %emulators_dir%\dolphin-triforce\User\Config\. md %emulators_dir%\dolphin-triforce\User\Config
if not exist %emulators_dir%\dolphin-emu\User\. md %emulators_dir%\dolphin-emu\User
if not exist %emulators_dir%\dolphin-emu\User\Config\. md %emulators_dir%\dolphin-emu\User\Config

if exist %templates_dir%\dolphin\Dolphin.ini if not exist %emulators_dir%\dolphin-emu\User\config\Dolphin.ini copy/y %templates_dir%\dolphin\Dolphin.ini %emulators_dir%\dolphin-emu\User\config\Dolphin.ini
rem if exist %templates_dir%\dolphin\Dolphin-triforce.ini if not exist %emulators_dir%\dolphin-emu\config_triforce\Config\Dolphin.ini copy/y %templates_dir%\dolphin\Dolphin-triforce.ini %emulators_dir%\dolphin-emu\config_triforce\Config\Dolphin.ini>nul
if exist %templates_dir%\dolphin\DolphinWX.ini if not exist %emulators_dir%\dolphin-triforce\User\Config\Dolphin.ini copy/y %templates_dir%\dolphin\DolphinWX.ini %emulators_dir%\dolphin-triforce\User\config\Dolphin.ini>nul
if exist %templates_dir%\infos\info-emu.txt if not exist %emulators_dir%\dolphin-emu\_infos.txt copy/y %templates_dir%\infos\info-emu.txt %emulators_dir%\dolphin-emu\_infos.txt>nul
if exist %templates_dir%\infos\info-emu.txt if not exist %emulators_dir%\dolphin-triforce\_infos.txt copy/y %templates_dir%\infos\info-emu.txt %emulators_dir%\dolphin-triforce\_infos.txt>nul

if not exist %emulators_dir%\mgba\. md %emulators_dir%\mgba
if exist %templates_dir%\infos\info-emu.txt if not exist %emulators_dir%\mgba\_infos.txt copy/y %templates_dir%\infos\info-emu.txt %emulators_dir%\mgba\_infos.txt>nul

if not exist %emulators_dir%\snes9x\. md %emulators_dir%\snes9x
if exist %templates_dir%\infos\info-emu.txt if not exist %emulators_dir%\snes9x\_infos.txt copy/y %templates_dir%\infos\info-emu.txt %emulators_dir%\snes9x\_infos.txt>nul

if not exist %emulators_dir%\mednafen\. md %emulators_dir%\mednafen
if exist %templates_dir%\infos\info-emu.txt if not exist %emulators_dir%\mednafen\_infos.txt copy/y %templates_dir%\infos\info-emu.txt %emulators_dir%\mednafen\_infos.txt>nul

if not exist %emulators_dir%\pcsx2\. md %emulators_dir%\pcsx2
if not exist %emulators_dir%\pcsx2\bios\. md %emulators_dir%\pcsx2\bios
if exist %templates_dir%\infos\info-emu.txt if not exist %emulators_dir%\pcsx2\_infos.txt copy/y %templates_dir%\infos\info-emu.txt %emulators_dir%\pcsx2\_infos.txt>nul

if not exist %emulators_dir%\ppsspp\. md %emulators_dir%\ppsspp
if exist %templates_dir%\infos\info-emu.txt if not exist %emulators_dir%\ppsspp\_infos.txt copy/y %templates_dir%\infos\info-emu.txt %emulators_dir%\ppsspp\_infos.txt>nul

if not exist %emulators_dir%\redream\. md %emulators_dir%\redream
if exist %templates_dir%\infos\info-emu.txt if not exist %emulators_dir%\redream\_infos.txt copy/y %templates_dir%\infos\info-emu.txt %emulators_dir%\redream\_infos.txt>nul
if exist %templates_dir%\redream\redream.cfg if not exist %emulators_dir%\redream\redream.cfg copy/y %templates_dir%\redream\redream.cfg %emulators_dir%\redream\redream.cfg>nul

if not exist %emulators_dir%\dosbox\. md %emulators_dir%\dosbox
if exist %templates_dir%\infos\info-emu.txt if not exist %emulators_dir%\dosbox\_infos.txt copy/y %templates_dir%\infos\info-emu.txt %emulators_dir%\dosbox\_infos.txt>nul
if exist %templates_dir%\dosbox\run.dosbox if not exist %emulators_dir%\dosbox\run.dosbox copy/y %templates_dir%\dosbox\run.dosbox %emulators_dir%\dosbox\run.dosbox>nul

if not exist %emulators_dir%\retroarch\. md %emulators_dir%\retroarch
if exist %templates_dir%\retroarch\retroarch.cfg if not exist %emulators_dir%\retroarch\retroarch.cfg copy/y %templates_dir%\retroarch\retroarch.cfg %emulators_dir%\retroarch\retroarch.cfg>nul
if exist %templates_dir%\infos\info-emu.txt if not exist %emulators_dir%\retrobarch\_infos.txt copy/y %templates_dir%\infos\info-emu.txt %emulators_dir%\retroarch\_infos.txt>nul

if not exist %emulators_dir%\m2emulator\. md %emulators_dir%\m2emulator
if exist %templates_dir%\infos\info-emu.txt if not exist %emulators_dir%\m2emulator\_infos.txt copy/y %templates_dir%\infos\info-emu.txt %emulators_dir%\m2emulator\_infos.txt>nul
if exist %templates_dir%\m2emulator\emulator.ini if not exist %games_dir%\%model2%\emulator.ini copy/y %templates_dir%\m2emulator\emulator.ini  %games_dir%\%model2%\emulator.ini>nul
if exist %templates_dir%\m2emulator\CFG\. if not exist %games_dir%\%model2%\CFG\*.input xcopy/Y /e /i "%templates_dir%\m2emulator\CFG" "%games_dir%\%model2%\CFG">nul
if exist %templates_dir%\m2emulator\NVDATA\. if not exist %games_dir%\%model2%\NVDATA\*.DAT xcopy/Y /e /i "%templates_dir%\m2emulator\NVDATA" "%games_dir%\%model2%\NVDATA">nul

if not exist %emulators_dir%\mednafen\. md %emulators_dir%\mednafen
if exist %templates_dir%\infos\info-emu.txt if not exist %emulators_dir%\mednafen\_infos.txt copy/y %templates_dir%\infos\info-emu.txt %emulators_dir%\mednafen\_infos.txt>nul

if not exist %emulators_dir%\openbor\. md %emulators_dir%\openbor
if exist %templates_dir%\infos\info-emu.txt if not exist %emulators_dir%\openbor\_infos.txt copy/y %templates_dir%\infos\info-emu.txt %emulators_dir%\openbor\_infos.txt>nul
if not exist %emulators_dir%\openbor\openborlauncher.exe if exist %setup_dir%\system\tools\openborlauncher.exe copy/y %setup_dir%\system\tools\openborlauncher.exe %emulators_dir%\openbor\openborlauncher.exe>nul

if not exist %emulators_dir%\project64\. md %emulators_dir%\project64
if not exist %emulators_dir%\project64\Config\. md %emulators_dir%\project64\Config
if exist %templates_dir%\infos\info-emu.txt if not exist %emulators_dir%\project64\_infos.txt copy/y %templates_dir%\infos\info-emu.txt %emulators_dir%\project64\_infos.txt>nul
if exist %templates_dir%\project64\Project64.cfg if not exist %emulators_dir%\project64\Config\Project64.cfg copy/y %templates_dir%\project64\Project64.cfg  %emulators_dir%\project64\Config\Project64.cfg>nul

if not exist %emulators_dir%\raine\. md %emulators_dir%\raine
if exist %templates_dir%\infos\info-emu.txt if not exist %emulators_dir%\raine\_infos.txt copy/y %templates_dir%\infos\info-emu.txt %emulators_dir%\raine\_infos.txt>nul

if not exist %emulators_dir%\fpinball\. md %emulators_dir%\fpinball
if exist %templates_dir%\infos\info-emu.txt if not exist %emulators_dir%\fpinball\_infos.txt copy/y %templates_dir%\infos\info-emu.txt %emulators_dir%\fpinball\_infos.txt>nul
if not exist %emulators_dir%\fpinball\FPinballLauncher.exe if exist %setup_dir%\system\tools\FPinballLauncher.exe copy/y %setup_dir%\system\tools\FPinballLauncher.exe %emulators_dir%\fpinball\FPinballLauncher.exe>nul

if not exist %emulators_dir%\vpinball\. md %emulators_dir%\vpinball
if exist %templates_dir%\infos\info-emu.txt if not exist %emulators_dir%\vpinball\_infos.txt copy/y %templates_dir%\infos\info-emu.txt %emulators_dir%\vpinball\_infos.txt>nul
if not exist %emulators_dir%\vpinball\VPinballLauncher.exe if exist %setup_dir%\system\tools\VPinballLauncher.exe copy/y %setup_dir%\system\tools\VPinballLauncher.exe %emulators_dir%\vpinball\VPinballLauncher.exe>nul

if not exist %emulators_dir%\rpcs3\. md %emulators_dir%\rpcs3
if exist %templates_dir%\infos\info-emu.txt if not exist %emulators_dir%\rpcs3\_infos.txt copy/y %templates_dir%\infos\info-emu.txt %emulators_dir%\rpcs3\_infos.txt>nul
::if not exist %emulators_dir%\rpcs3\rpcs3launcher.exe if exist %setup_dir%\system\tools\rpcs3launcher.exe copy/y %setup_dir%\system\tools\rpcs3launcher.exe %emulators_dir%\rpcs3\rpcs3launcher.exe>nul
if not exist %games_dir%\ps3\*.m3u if exist %templates_dir%\roms\ps3\example-to-edit.m3u.txt copy/y %templates_dir%\roms\ps3\example-to-edit.m3u.txt %games_dir%\ps3\example-to-edit.m3u.txt>nul

if not exist %emulators_dir%\supermodel\. md %emulators_dir%\supermodel
if not exist %emulators_dir%\supermodel\Config\. md %emulators_dir%\supermodel\Config
if exist %templates_dir%\infos\info-emu.txt if not exist %emulators_dir%\supermodel\_infos.txt copy/y %templates_dir%\infos\info-emu.txt %emulators_dir%\supermodel\_infos.txt>nul
if exist %templates_dir%\supermodel\Supermodel.ini  if not exist %emulators_dir%\supermodel\Config\Supermodel.ini copy/y %templates_dir%\supermodel\Supermodel.ini %emulators_dir%\supermodel\Config\Supermodel.ini>nul

if not exist %emulators_dir%\xenia\. md %emulators_dir%\xenia
if exist %templates_dir%\infos\info-emu.txt if not exist %emulators_dir%\xenia\_infos.txt  copy/y %templates_dir%\infos\info-emu.txt %emulators_dir%\xenia\_infos.txt>nul

if not exist %emulators_dir%\xenia-canary\. md %emulators_dir%\xenia-canary
if exist %templates_dir%\infos\info-emu.txt if not exist %emulators_dir%\xenia-canary\_infos.txt  copy/y %templates_dir%\infos\info-emu.txt %emulators_dir%\xenia-canary\_infos.txt>nul

if not exist %emulators_dir%\yuzu\. md %emulators_dir%\yuzu
if exist %templates_dir%\infos\info-emu.txt if not exist %emulators_dir%\yuzu\_infos.txt  copy/y %templates_dir%\infos\info-emu.txt %emulators_dir%\yuzu\_infos.txt>nul

if not exist %setup_dir%\system\joytokey\. md %setup_dir%\system\joytokey
if exist %templates_dir%\infos\info-joytokey.txt if not exist %setup_dir%\system\joytokey\_infos.txt copy/y %templates_dir%\infos\info-joytokey.txt %setup_dir%\system\joytokey\_infos.txt>nul

if exist %templates_dir%\infos\info-bios.txt if not exist %bios_dir%\_infos.txt copy/y %templates_dir%\infos\info-bios.txt %bios_dir%\_infos.txt>nul

timeout /t 1 >nul

goto:eof
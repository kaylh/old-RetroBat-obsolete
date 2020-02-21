@echo off
goto:rem
***************************************
This file is part of RetroBat Scripts.
---------------------------------------
file name: systemsnames.cmd
language: batch
author: Kayl 
***************************************
:rem

if not exist %games_dir%\. md %games_dir%
if not exist %saves_dir%\. md %saves_dir%
if not exist %shots_dir%\. md %shots_dir%
if not exist %bios_dir%\. md %bios_dir%
if not exist %medias_dir%\. md %medias_dir%

cd %games_dir%
call %scripts_dir%\systemsnames.cmd
If not exist %amiga%\. md %amiga%
If not exist %amigacd32%\. md %amigacd32%
If not exist %amigacdtv%\. md %amigacdtv%
If not exist %amstradcpc%\. md %amstradcpc%
If not exist %arcade%\. md %arcade%
If not exist %atari800%\. md %atari800%
If not exist %atari2600%\. md %atari2600%
If not exist %atari5200%\. md %atari5200%
If not exist %atarijaguar%\. md %atarijaguar%
If not exist %atarilynx%\. md %atarilynx%
If not exist %ataripro%\. md %ataripro%
If not exist %atarist%\. md %atarist%
If not exist %atomiswave%\. md %atomiswave%
If not exist %cave%\. md %cave%
If not exist %cavestory%\. md %cavestory%
If not exist %colecov%\. md %colecov%
If not exist %com20%\. md %com20%
If not exist %com64%\. md %com64%
If not exist %com128%\. md %com128%
If not exist %cps1%\. md %cps1%
If not exist %cps2%\. md %cps2%
If not exist %cps3%\. md %cps3%
If not exist %dreamcast%\. md %dreamcast%
If not exist %fba%\. md %fba%
If not exist %fds%\. md %fds%
If not exist %fpinball%\. md %fpinball%
If not exist %gamecube%\. md %gamecube%
If not exist %gamegear%\. md %gamegear%
If not exist %gamewatch%\. md %gamewatch%
If not exist %gb%\. md %gb%
If not exist %gb2p%\. md %gb2p%
If not exist %gbadv%\. md %gbadv%
If not exist %gbc2p%\. md %gbc2p%
If not exist %gbcolor%\. md %gbcolor%
If not exist %gx4000%\. md %gx4000%
If not exist %intellivision%\. md %intellivision%
If not exist %laserdisc%\. md %laserdisc%
If not exist %lightgun%\. md %lightgun%
If not exist %lutro%\. md %lutro%
If not exist %love%\. md %love%
If not exist %mame%\. md %mame%
If not exist %mastersystem%\. md %mastersystem%
If not exist %megacd%\. md %megacd%
If not exist %megadrive%\. md %megadrive%
If not exist %model2%\. md %model2%
if not exist "%model2%\roms\." md "%model2%\roms"
If not exist %msdos%\. md %msdos%
If not exist %msu1%\. md %msu1%
If not exist %msx%\. md %msx%
If not exist %mugen%\. md %mugen%
If not exist %n3ds%\. md %n3ds%
If not exist %n64%\. md %n64%
If not exist %naomi%\. md %naomi%
If not exist %nds%\. md %nds%
If not exist %neogeo%\. md %neogeo%
If not exist %neogeocd%\. md %neogeocd%
If not exist %nes%\. md %nes%
If not exist %ngp%\. md %ngp%
If not exist %ngpc%\. md %ngpc%
If not exist %npg%\. md %npg%
If not exist %openbor%\. md %openbor%
If not exist %pc98%\. md %pc98%
If not exist %pce%\. md %pce%
If not exist %pcecd%\. md %pcecd%
If not exist %pcfx%\. md %pcfx%
If not exist %pcgames%\. md %pcgames%
If not exist %pokemini%\. md %pokemini%
If not exist %ps2%\. md %ps2%
If not exist %ps3%\. md %ps3%
If not exist %psp%\. md %psp%
If not exist %psx%\. md %psx%
If not exist %satellaview%\. md %satellaview%
If not exist %saturn%\. md %saturn%
If not exist %scummvm%\. md %scummvm%
If not exist %sega32x%\. md %sega32x%
If not exist %sg1000%\. md %sg1000%
If not exist %snes%\. md %snes%
If not exist %supergrafx%\. md %supergrafx%
If not exist %sufami%\. md %sufami%
If not exist %threedo%\. md %threedo%
If not exist %thomson%\. md %thomson%
If not exist %vb%\. md %vb%
If not exist %vectrex%\. md %vectrex%
If not exist %videopac%\. md %videopac%
If not exist %vpinball%\. md %vpinball%
If not exist %wii%\. md %wii%
if not exist %wiiu%\. md %wiiu%
If not exist %wswan%\. md %wswan%
If not exist %wswanc%\. md %wswanc%
If not exist %x68000%\. md %x68000%
If not exist %x81%\. md %x81%
If not exist %zxspectrum%\. md %zxspectrum%
if not exist %apple2%\. md %apple2%
cd ..
timeout /t 1 >nul

if not exist %setup_dir%\kodi\. md  %setup_dir%\kodi
if exist %templates_dir%\kodi\gamelist.xml copy/y %templates_dir%\kodi\gamelist.xml %setup_dir%\kodi\gamelist.xml>nul
if exist %templates_dir%\kodi\_media\kodi-logo.png xcopy/Y /e /i "%templates_dir%\kodi\_media" "%setup_dir%\kodi\_media" 2>nul

if not exist %emulators_dir%\applewin\. md %emulators_dir%\applewin
if exist %templates_dir%\infos\info-emu.txt copy/y %templates_dir%\infos\info-emu.txt %emulators_dir%\applewin\info.txt>nul

if not exist %emulators_dir%\cemu\. md %emulators_dir%\cemu
if exist %templates_dir%\infos\info-emu.txt copy/y %templates_dir%\infos\info-emu.txt %emulators_dir%\cemu\info.txt>nul

if not exist %emulators_dir%\citra\. md %emulators_dir%\citra
if not exist %emulators_dir%\citra\user\. md %emulators_dir%\citra\user
if exist %templates_dir%\infos\info-emu.txt copy/y %templates_dir%\infos\info-emu.txt %emulators_dir%\citra\info.txt>nul

if not exist %emulators_dir%\dolphin-emu\. md %emulators_dir%\dolphin-emu
if not exist %emulators_dir%\dolphin-emu\config\. md %emulators_dir%\dolphin-emu\config
if exist %templates_dir%\infos\info-emu.txt copy/y %templates_dir%\infos\info-emu.txt %emulators_dir%\dolphin-emu\info.txt>nul

if not exist %emulators_dir%\mgba\. md %emulators_dir%\mgba
if exist %templates_dir%\infos\info-emu.txt copy/y %templates_dir%\infos\info-emu.txt %emulators_dir%\mgba\info.txt>nul

if not exist %emulators_dir%\snes9x\. md %emulators_dir%\snes9x
if exist %templates_dir%\infos\info-emu.txt copy/y %templates_dir%\infos\info-emu.txt %emulators_dir%\snes9x\info.txt>nul

if not exist %emulators_dir%\mednafen\. md %emulators_dir%\mednafen
if exist %templates_dir%\infos\info-emu.txt copy/y %templates_dir%\infos\info-emu.txt %emulators_dir%\mednafen\info.txt>nul

if not exist %emulators_dir%\pcsx2\. md %emulators_dir%\pcsx2
if not exist %emulators_dir%\pcsx2\bios\. md %emulators_dir%\pcsx2\bios
if exist %templates_dir%\infos\info-emu.txt copy/y %templates_dir%\infos\info-emu.txt %emulators_dir%\pcsx2\info.txt>nul

if not exist %emulators_dir%\ppsspp\. md %emulators_dir%\ppsspp
if exist %templates_dir%\infos\info-emu.txt copy/y %templates_dir%\infos\info-emu.txt %emulators_dir%\ppsspp\info.txt>nul

if not exist %emulators_dir%\redream\. md %emulators_dir%\redream
if exist %templates_dir%\infos\info-emu.txt copy/y %templates_dir%\infos\info-emu.txt %emulators_dir%\redream\info.txt>nul

if not exist %emulators_dir%\dosbox\. md %emulators_dir%\dosbox
if exist %templates_dir%\infos\info-emu.txt copy/y %templates_dir%\infos\info-emu.txt %emulators_dir%\dosbox\info.txt>nul

if not exist %emulators_dir%\retroarch\. md %emulators_dir%\retroarch
if exist %templates_dir%\infos\info-emu.txt copy/y %templates_dir%\infos\info-emu.txt %emulators_dir%\retroarch\info.txt>nul

if not exist %emulators_dir%\m2emulator\. md %emulators_dir%\m2emulator
if exist %templates_dir%\infos\info-emu.txt copy/y %templates_dir%\infos\info-emu.txt %emulators_dir%\m2emulator\info.txt>nul
if exist %templates_dir%\m2emulator\emulator.ini copy/y %templates_dir%\m2emulator\emulator.ini  %games_dir%\%model2%\emulator.ini>nul

if not exist %emulators_dir%\mednafen\. md %emulators_dir%\mednafen
if exist %templates_dir%\infos\info-emu.txt copy/y %templates_dir%\infos\info-emu.txt %emulators_dir%\mednafen\info.txt>nul

if not exist %emulators_dir%\openbor\. md %emulators_dir%\openbor
if exist %templates_dir%\infos\info-emu.txt copy/y %templates_dir%\infos\info-emu.txt %emulators_dir%\openbor\info.txt>nul
if not exist %emulators_dir%\openbor\openborlauncher.exe if exist %setup_dir%\system\tools\openborlauncher.exe copy/y %setup_dir%\system\tools\openborlauncher.exe %emulators_dir%\openbor\openborlauncher.exe>nul

if not exist %emulators_dir%\raine\. md %emulators_dir%\raine
if exist %templates_dir%\infos\info-emu.txt copy/y %templates_dir%\infos\info-emu.txt %emulators_dir%\raine\info.txt>nul

if not exist %emulators_dir%\fpinball\. md %emulators_dir%\fpinball
if exist %templates_dir%\infos\info-emu.txt copy/y %templates_dir%\infos\info-emu.txt %emulators_dir%\fpinball\info.txt>nul
if not exist %emulators_dir%\fpinball\FPinballLauncher.exe if exist %setup_dir%\system\tools\FPinballLauncher.exe copy/y %setup_dir%\system\tools\FPinballLauncher.exe %emulators_dir%\fpinball\FPinballLauncher.exe>nul

if not exist %emulators_dir%\vpinball\. md %emulators_dir%\vpinball
if exist %templates_dir%\infos\info-emu.txt copy/y %templates_dir%\infos\info-emu.txt %emulators_dir%\vpinball\info.txt>nul
if not exist %emulators_dir%\vpinball\VPinballLauncher.exe if exist %setup_dir%\system\tools\VPinballLauncher.exe copy/y %setup_dir%\system\tools\VPinballLauncher.exe %emulators_dir%\vpinball\VPinballLauncher.exe>nul

if not exist %emulators_dir%\rpcs3\. md %emulators_dir%\rpcs3
if exist %templates_dir%\infos\info-emu.txt copy/y %templates_dir%\infos\info-emu.txt %emulators_dir%\rpcs3\info.txt>nul
::if not exist %emulators_dir%\rpcs3\rpcs3launcher.exe if exist %setup_dir%\system\tools\rpcs3launcher.exe copy/y %setup_dir%\system\tools\rpcs3launcher.exe %emulators_dir%\rpcs3\rpcs3launcher.exe>nul
if not exist %games_dir%\ps3\*.m3u if exist %templates_dir%\roms\ps3\example-to-edit.m3u.txt copy/y %templates_dir%\roms\ps3\example-to-edit.m3u.txt %games_dir%\ps3\example-to-edit.m3u.txt>nul

if not exist %setup_dir%\system\joytokey\. md %setup_dir%\system\joytokey
if exist %templates_dir%\infos\info-joytokey.txt copy/y %templates_dir%\infos\info-joytokey.txt %setup_dir%\system\joytokey\info.txt>nul

if exist %templates_dir%\infos\info-bios.txt copy/y %templates_dir%\infos\info-bios.txt %bios_dir%\bios.txt>nul
timeout /t 1 >nul
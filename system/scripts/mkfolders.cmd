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

If not exist %amiga%\. md %amiga%
If not exist %amiga500%\. md %amiga500%
If not exist %amiga1200%\. md %amiga1200%
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
If not exist %chihiro%\. md %chihiro%
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
If not exist %gaelco%\. md %gaelco%
If not exist %gamecube%\. md %gamecube%
If not exist %gamegear%\. md %gamegear%
If not exist %gamewatch%\. md %gamewatch%
If not exist %gb%\. md %gb%
If not exist %gb2p%\. md %gb2p%
If not exist %gbadv%\. md %gbadv%
If not exist %gbc2p%\. md %gbc2p%
If not exist %gbcolor%\. md %gbcolor%
If not exist %gx4000%\. md %gx4000%
If not exist %hikaru%\. md %hikaru%
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
If not exist %model3%\. md %model3%
If not exist %msdos%\. md %msdos%
If not exist %msu1%\. md %msu1%
If not exist %msx%\. md %msx%
If not exist %msx1%\. md %msx1%
If not exist %msx2%\. md %msx2%
If not exist %msx2plus%\. md %msx2plus%
If not exist %mugen%\. md %mugen%
If not exist %n3ds%\. md %n3ds%
If not exist %n64%\. md %n64%
If not exist %naomi%\. md %naomi%
If not exist %naomi2%\. md %naomi2%
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
If not exist %samcoupe%\. md %samcoupe%
If not exist %satellaview%\. md %satellaview%
If not exist %saturn%\. md %saturn%
If not exist %scummvm%\. md %scummvm%
If not exist %sega32x%\. md %sega32x%
If not exist %sg1000%\. md %sg1000%
If not exist %snes%\. md %snes%
If not exist %supergrafx%\. md %supergrafx%
If not exist %sufami%\. md %sufami%
If not exist %switch%\. md %switch%
If not exist %threedo%\. md %threedo%
If not exist %thomson%\. md %thomson%
If not exist %triforce%\. md %triforce%
If not exist %vb%\. md %vb%
If not exist %vectrex%\. md %vectrex%
If not exist %videopac%\. md %videopac%
If not exist %vpinball%\. md %vpinball%
If not exist %wii%\. md %wii%
if not exist %wiiu%\. md %wiiu%
If not exist %wswan%\. md %wswan%
If not exist %wswanc%\. md %wswanc%
If not exist %x68000%\. md %x68000%
If not exist %zx81%\. md %zx81%
If not exist %xbox%\. md %xbox%
If not exist %xbox360%\. md %xbox360%
If not exist %zxspectrum%\. md %zxspectrum%
if not exist %apple2%\. md %apple2%

timeout /t 1 >nul

cd ..

cd %saves_dir%

If not exist %amiga%\. md %amiga%
If not exist %amiga500%\. md %amiga500%
If not exist %amiga1200%\. md %amiga1200%
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
If not exist %chihiro%\. md %chihiro%
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
If not exist %gaelco%\. md %gaelco%
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
If not exist %msdos%\. md %msdos%
If not exist %msu1%\. md %msu1%
If not exist %msx%\. md %msx%
If not exist %msx1%\. md %msx1%
If not exist %msx2%\. md %msx2%
If not exist %msx2plus%\. md %msx2plus%
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
If not exist %pokemini%\. md %pokemini%
If not exist %ps2%\. md %ps2%
If not exist %psp%\. md %psp%
If not exist %psx%\. md %psx%
If not exist %samcoupe%\. md %samcoupe%
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
If not exist %wii%\. md %wii%
If not exist %wswan%\. md %wswan%
If not exist %wswanc%\. md %wswanc%
If not exist %x68000%\. md %x68000%
If not exist %zx81%\. md %zx81%
If not exist %zxspectrum%\. md %zxspectrum%

cd %setup_dir%

timeout /t 1 >nul

goto:eof
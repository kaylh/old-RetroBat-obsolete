@echo off
goto:rem
***************************************
This file is part of RetroBat Scripts. 
***************************************
:rem
:dl_4do
cls
set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/4do_libretro.dll.zip
set output_dir=%temp_dir%\4do_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkg_fail
ping 127.0.0.1 -n 4 >nul
echo Done.
if "%fullinstall%"=="1" goto dl_atari800
goto install_libretrocores


:dl_atari800
cls
set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/atari800_libretro.dll.zip
set output_dir=%temp_dir%\atari800_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkg_fail
ping 127.0.0.1 -n 4 >nul
echo Done.
if "%fullinstall%"=="1" (
	goto dl_blastem
) else (
	goto install_libretrocores
)

:dl_blastem
cls
set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/blastem_libretro.dll.zip
set output_dir=%temp_dir%\blastem_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkg_fail
ping 127.0.0.1 -n 4 >nul
echo Done.
if "%fullinstall%"=="1" (
	goto dl_bluemsx
) else (
	goto install_libretrocores
)

:dl_bluemsx
cls
set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/bluemsx_libretro.dll.zip
set output_dir=%temp_dir%\bluemsx_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkg_fail
ping 127.0.0.1 -n 4 >nul
echo Done.
if "%fullinstall%"=="1" (
	goto dl_bsnes_mercury_accuracy
) else (
	goto install_libretrocores
)

:dl_bsnes_mercury_accuracy
cls
set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/bsnes_mercury_accuracy_libretro.dll.zip
set output_dir=%temp_dir%\bsnes_mercury_accuracy_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkg_fail
ping 127.0.0.1 -n 4 >nul
echo Done.
if "%fullinstall%"=="1" (
	goto dl_cap32
) else (
	goto install_libretrocores
)

:dl_cap32
cls
set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/cap32_libretro.dll.zip
set output_dir=%temp_dir%\cap32_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkg_fail
ping 127.0.0.1 -n 4 >nul
echo Done.
if "%fullinstall%"=="1" (
	goto dl_citra
) else (
	goto install_libretrocores
)

:dl_citra
cls
set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/citra_libretro.dll.zip
set output_dir=%temp_dir%\citra_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkg_fail
ping 127.0.0.1 -n 4 >nul
echo Done.
if "%fullinstall%"=="1" (
	goto dl_crocods
) else (
	goto install_libretrocores
)

:dl_crocods
cls
set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/crocods_libretro.dll.zip
set output_dir=%temp_dir%\crocods_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkg_fail
ping 127.0.0.1 -n 4 >nul
echo Done.
if "%fullinstall%"=="1" (
	goto dl_desmume
) else (
	goto install_libretrocores
)

:dl_desmume
cls
set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/desmume_libretro.dll.zip
set output_dir=%temp_dir%\desmume_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkg_fail
ping 127.0.0.1 -n 4 >nul
echo Done.
if "%fullinstall%"=="1" (
	goto dl_dolphin
) else (
	goto install_libretrocores
)

:dl_dolphin
cls
set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/dolphin_libretro.dll.zip
set output_dir=%temp_dir%\dolphin_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkg_fail
ping 127.0.0.1 -n 4 >nul
echo Done.
if "%fullinstall%"=="1" (
	goto dl_dosbox_svn
) else (
	goto install_libretrocores
)

:dl_dosbox_svn
cls
set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/dosbox_svn_libretro.dll.zip
set output_dir=%temp_dir%\dosbox_svn_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkg_fail
ping 127.0.0.1 -n 4 >nul
echo Done.
if "%fullinstall%"=="1" (
	goto dl_ffmpeg
) else (
	goto install_libretrocores
)

:dl_ffmpeg
cls
set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/ffmpeg_libretro.dll.zip
set output_dir=%temp_dir%\ffmpeg_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkg_fail
ping 127.0.0.1 -n 4 >nul
echo Done.
if "%fullinstall%"=="1" (
	goto dl_flycast
) else (
	goto install_libretrocores
)

:dl_flycast
cls
set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/flycast_libretro.dll.zip
set output_dir=%temp_dir%\flycast_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkg_fail
ping 127.0.0.1 -n 4 >nul
echo Done.
if "%fullinstall%"=="1" (
	goto dl_fmsx
) else (
	goto install_libretrocores
)

:dl_fmsx
cls
set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/fmsx_libretro.dll.zip
set output_dir=%temp_dir%\fmsx_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkg_fail
ping 127.0.0.1 -n 4 >nul
echo Done.
if "%fullinstall%"=="1" (
	goto dl_freeintv
) else (
	goto install_libretrocores
)

:dl_freeintv
cls
set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/freeintv_libretro.dll.zip
set output_dir=%temp_dir%\freeintv_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkg_fail
ping 127.0.0.1 -n 4 >nul
echo Done.
if "%fullinstall%"=="1" (
	goto dl_fuse
) else (
	goto install_libretrocores
)

:dl_fuse
cls
set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/fuse_libretro.dll.zip
set output_dir=%temp_dir%\fuse_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkg_fail
ping 127.0.0.1 -n 4 >nul
echo Done.
if "%fullinstall%"=="1" (
	goto dl_gambatte
) else (
	goto install_libretrocores
)

:dl_gambatte
cls
set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/gambatte_libretro.dll.zip
set output_dir=%temp_dir%\gambatte_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkg_fail
ping 127.0.0.1 -n 4 >nul
echo Done.
if "%fullinstall%"=="1" (
	goto dl_gearboy
) else (
	goto install_libretrocores
)

:dl_gearboy
cls
set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/gearboy_libretro.dll.zip
set output_dir=%temp_dir%\gearboy_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkg_fail
ping 127.0.0.1 -n 4 >nul
echo Done.
if "%fullinstall%"=="1" (
	goto dl_gearsystem
) else (
	goto install_libretrocores
)

:dl_gearsystem
cls
set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/gearsystem_libretro.dll.zip
set output_dir=%temp_dir%\gearsystem_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkg_fail
ping 127.0.0.1 -n 4 >nul
echo Done.
if "%fullinstall%"=="1" (
	goto dl_genesis_plus_gx
) else (
	goto install_libretrocores
)

:dl_genesis_plus_gx
cls
set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/genesis_plus_gx_libretro.dll.zip
set output_dir=%temp_dir%\genesis_plus_gx_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkg_fail
ping 127.0.0.1 -n 4 >nul
echo Done.
if "%fullinstall%"=="1" (
	goto dl_gw
) else (
	goto install_libretrocores
)

:dl_gw
cls
set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/gw_libretro.dll.zip
set output_dir=%temp_dir%\gw_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkg_fail
ping 127.0.0.1 -n 4 >nul
echo Done.
if "%fullinstall%"=="1" (
	goto dl_handy
) else (
	goto install_libretrocores
)

:dl_handy
cls
set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/handy_libretro.dll.zip
set output_dir=%temp_dir%\handy_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkg_fail
ping 127.0.0.1 -n 4 >nul
echo Done.
if "%fullinstall%"=="1" (
	goto dl_hatari
) else (
	goto install_libretrocores
)

:dl_hatari
cls
set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/hatari_libretro.dll.zip
set output_dir=%temp_dir%\hatari_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkg_fail
ping 127.0.0.1 -n 4 >nul
echo Done.
if "%fullinstall%"=="1" (
	goto dl_higan_sfc
) else (
	goto install_libretrocores
)

:dl_higan_sfc
cls
set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/higan_sfc_libretro.dll.zip
set output_dir=%temp_dir%\higan_sfc_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkg_fail
ping 127.0.0.1 -n 4 >nul
echo Done.
if "%fullinstall%"=="1" (
	goto dl_mednafen_gba
) else (
	goto install_libretrocores
)

:dl_mednafen_gba
cls
set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/mednafen_gba_libretro.dll.zip
set output_dir=%temp_dir%\mednafen_gba_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkg_fail
ping 127.0.0.1 -n 4 >nul
echo Done.
if "%fullinstall%"=="1" (
	goto dl_mednafen_lynx
) else (
	goto install_libretrocores
)

:dl_mednafen_lynx
cls
set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/mednafen_lynx_libretro.dll.zip
set output_dir=%temp_dir%\mednafen_lynx_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkg_fail
ping 127.0.0.1 -n 4 >nul
echo Done.
if "%fullinstall%"=="1" (
	goto dl_mednafen_ngp
) else (
	goto install_libretrocores
)

:dl_mednafen_ngp
cls
set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/mednafen_ngp_libretro.dll.zip
set output_dir=%temp_dir%\mednafen_ngp_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkg_fail
ping 127.0.0.1 -n 4 >nul
echo Done.
if "%fullinstall%"=="1" (
	goto dl_mednafen_pce_fast
) else (
	goto install_libretrocores
)

:dl_mednafen_pce_fast
cls
set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/mednafen_pce_fast_libretro.dll.zip
set output_dir=%temp_dir%\mednafen_pce_fast_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkg_fail
ping 127.0.0.1 -n 4 >nul
echo Done.
if "%fullinstall%"=="1" (
	goto dl_mednafen_pce
) else (
	goto install_libretrocores
)

:dl_mednafen_pce
cls
set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/mednafen_pce_libretro.dll.zip
set output_dir=%temp_dir%\mednafen_pce_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkg_fail
ping 127.0.0.1 -n 4 >nul
echo Done.
if "%fullinstall%"=="1" (
	goto dl_mednafen_pcfx
) else (
	goto install_libretrocores
)

:dl_mednafen_pcfx
cls
set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/mednafen_pcfx_libretro.dll.zip
set output_dir=%temp_dir%\mednafen_pcfx_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkg_fail
ping 127.0.0.1 -n 4 >nul
echo Done.
if "%fullinstall%"=="1" (
	goto dl_mednafen_psx_hw
) else (
	goto install_libretrocores
)

:dl_mednafen_psx_hw
cls
set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/mednafen_psx_hw_libretro.dll.zip
set output_dir=%temp_dir%\mednafen_psx_hw_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkg_fail
ping 127.0.0.1 -n 4 >nul
echo Done.
if "%fullinstall%"=="1" (
	goto dl_mednafen_psx
) else (
	goto install_libretrocores
)

:dl_mednafen_psx
cls
set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/mednafen_psx_libretro.dll.zip
set output_dir=%temp_dir%\mednafen_psx_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkg_fail
ping 127.0.0.1 -n 4 >nul
echo Done.
if "%fullinstall%"=="1" (
	goto dl_mednafen_saturn
) else (
	goto install_libretrocores
)

:dl_mednafen_saturn
cls
set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/mednafen_saturn_libretro.dll.zip
set output_dir=%temp_dir%\mednafen_saturn_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkg_fail
ping 127.0.0.1 -n 4 >nul
echo Done.
if "%fullinstall%"=="1" (
	goto dl_mednafen_snes
) else (
	goto install_libretrocores
)

:dl_mednafen_snes
cls
set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/mednafen_snes_libretro.dll.zip
set output_dir=%temp_dir%\mednafen_snes_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkg_fail
ping 127.0.0.1 -n 4 >nul
echo Done.
if "%fullinstall%"=="1" (
	goto dl_mednafen_supergrafx
) else (
	goto install_libretrocores
)

:dl_mednafen_supergrafx
cls
set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/mednafen_supergrafx_libretro.dll.zip
set output_dir=%temp_dir%\mednafen_supergrafx_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkg_fail
ping 127.0.0.1 -n 4 >nul
echo Done.
if "%fullinstall%"=="1" (
	goto dl_mednafen_vb
) else (
	goto install_libretrocores
)

:dl_mednafen_vb
cls
set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/mednafen_vb_libretro.dll.zip
set output_dir=%temp_dir%\mednafen_vb_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkg_fail
ping 127.0.0.1 -n 4 >nul
echo Done.
if "%fullinstall%"=="1" (
	goto dl_mednafen_wswan
) else (
	goto install_libretrocores
)

:dl_mednafen_wswan
cls
set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/mednafen_wswan_libretro.dll.zip
set output_dir=%temp_dir%\mednafen_wswan_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkg_fail
ping 127.0.0.1 -n 4 >nul
echo Done.
if "%fullinstall%"=="1" (
	goto install_libretrocores
) else (
	goto install_libretrocores
)

:pkg_fail
cls
Echo.
Echo  An error occured and package files can not be found. Try to update Libretro Cores list.
Echo.
if exist %temp_dir%\*.dll.zip del/Q %temp_dir%\*.dll.zip>nul
timeout /t 3 >nul
goto exit 

:exit
exit 

:install_libretrocores
cls
echo -- Libretro Cores are installing --
echo.
%zip_dir%\7zg.exe -y x "%temp_dir%\*.dll.zip" -o"%retroarch_dir%\cores" -aoa
timeout /t 1 >nul
if exist %temp_dir%\*.dll.zip del/Q %temp_dir%\*.dll.zip>nul
echo Done.
cls
goto:eof
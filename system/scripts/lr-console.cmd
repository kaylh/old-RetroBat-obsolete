@echo off
goto:rem
***************************************
This file is part of RetroBat Scripts.
---------------------------------------
file name: lr-console.cmd
language: batch
author: Kayl 
***************************************
:rem

:dl_4do
cls
set core_name=4do
If %PROCARCH%==32 set current_url=http://buildbot.libretro.com/nightly/windows/x86/latest/%core_name%_libretro.dll.zip
If %PROCARCH%==64 set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/%core_name%_libretro.dll.zip
set output_dir=%temp_dir%\%core_name%_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading ( %core_name% ) --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkg_fail
ping 127.0.0.1 -n 4 >nul
echo Done.
if "%fullinstall%"=="1" (
	goto dl_atari800
) else (
	goto install_libretrocores
)


:dl_atari800
cls
set core_name=atari800
If %PROCARCH%==32 set current_url=http://buildbot.libretro.com/nightly/windows/x86/latest/%core_name%_libretro.dll.zip
If %PROCARCH%==64 set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/%core_name%_libretro.dll.zip
set output_dir=%temp_dir%\%core_name%_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading ( %core_name% ) --
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
set core_name=blastem
If %PROCARCH%==32 set current_url=http://buildbot.libretro.com/nightly/windows/x86/latest/%core_name%_libretro.dll.zip
If %PROCARCH%==64 set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/%core_name%_libretro.dll.zip
set output_dir=%temp_dir%\%core_name%_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading ( %core_name% ) --
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
set core_name=bluemsx
If %PROCARCH%==32 set current_url=http://buildbot.libretro.com/nightly/windows/x86/latest/%core_name%_libretro.dll.zip
If %PROCARCH%==64 set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/%core_name%_libretro.dll.zip
set output_dir=%temp_dir%\%core_name%_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading ( %core_name% ) --
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
set core_name=bsnes_mercury_accuracy
If %PROCARCH%==32 set current_url=http://buildbot.libretro.com/nightly/windows/x86/latest/%core_name%_libretro.dll.zip
If %PROCARCH%==64 set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/%core_name%_libretro.dll.zip
set output_dir=%temp_dir%\%core_name%_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading ( %core_name% ) --
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
set core_name=cap32
If %PROCARCH%==32 set current_url=http://buildbot.libretro.com/nightly/windows/x86/latest/%core_name%_libretro.dll.zip
If %PROCARCH%==64 set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/%core_name%_libretro.dll.zip
set output_dir=%temp_dir%\%core_name%_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading ( %core_name% ) --
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
set core_name=citra
If %PROCARCH%==32 set current_url=http://buildbot.libretro.com/nightly/windows/x86/latest/%core_name%_libretro.dll.zip
If %PROCARCH%==64 set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/%core_name%_libretro.dll.zip
set output_dir=%temp_dir%\%core_name%_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading ( %core_name% ) --
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
set core_name=crocods
If %PROCARCH%==32 set current_url=http://buildbot.libretro.com/nightly/windows/x86/latest/%core_name%_libretro.dll.zip
If %PROCARCH%==64 set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/%core_name%_libretro.dll.zip
set output_dir=%temp_dir%\%core_name%_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading ( %core_name% ) --
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
set core_name=desmume
If %PROCARCH%==32 set current_url=http://buildbot.libretro.com/nightly/windows/x86/latest/%core_name%_libretro.dll.zip
If %PROCARCH%==64 set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/%core_name%_libretro.dll.zip
set output_dir=%temp_dir%\%core_name%_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading ( %core_name% ) --
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
set core_name=dolphin
If %PROCARCH%==32 set current_url=http://buildbot.libretro.com/nightly/windows/x86/latest/%core_name%_libretro.dll.zip
If %PROCARCH%==64 set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/%core_name%_libretro.dll.zip
set output_dir=%temp_dir%\%core_name%_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading ( %core_name% ) --
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
set core_name=ffmpeg
If %PROCARCH%==32 set current_url=http://buildbot.libretro.com/nightly/windows/x86/latest/%core_name%_libretro.dll.zip
If %PROCARCH%==64 set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/%core_name%_libretro.dll.zip
set output_dir=%temp_dir%\%core_name%_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading ( %core_name% ) --
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
set core_name=flycast
If %PROCARCH%==32 set current_url=http://buildbot.libretro.com/nightly/windows/x86/latest/%core_name%_libretro.dll.zip
If %PROCARCH%==64 set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/%core_name%_libretro.dll.zip
set output_dir=%temp_dir%\%core_name%_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading ( %core_name% ) --
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
set core_name=fmsx
If %PROCARCH%==32 set current_url=http://buildbot.libretro.com/nightly/windows/x86/latest/%core_name%_libretro.dll.zip
If %PROCARCH%==64 set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/%core_name%_libretro.dll.zip
set output_dir=%temp_dir%\%core_name%_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading ( %core_name% ) --
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
set core_name=freeintv
If %PROCARCH%==32 set current_url=http://buildbot.libretro.com/nightly/windows/x86/latest/%core_name%_libretro.dll.zip
If %PROCARCH%==64 set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/%core_name%_libretro.dll.zip
set output_dir=%temp_dir%\%core_name%_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading ( %core_name% ) --
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
set core_name=fuse
If %PROCARCH%==32 set current_url=http://buildbot.libretro.com/nightly/windows/x86/latest/%core_name%_libretro.dll.zip
If %PROCARCH%==64 set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/%core_name%_libretro.dll.zip
set output_dir=%temp_dir%\%core_name%_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading ( %core_name% ) --
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
set core_name=gambatte
If %PROCARCH%==32 set current_url=http://buildbot.libretro.com/nightly/windows/x86/latest/%core_name%_libretro.dll.zip
If %PROCARCH%==64 set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/%core_name%_libretro.dll.zip
set output_dir=%temp_dir%\%core_name%_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading ( %core_name% ) --
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
set core_name=gearboy
If %PROCARCH%==32 set current_url=http://buildbot.libretro.com/nightly/windows/x86/latest/%core_name%_libretro.dll.zip
If %PROCARCH%==64 set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/%core_name%_libretro.dll.zip
set output_dir=%temp_dir%\%core_name%_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading ( %core_name% ) --
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
set core_name=gearsystem
If %PROCARCH%==32 set current_url=http://buildbot.libretro.com/nightly/windows/x86/latest/%core_name%_libretro.dll.zip
If %PROCARCH%==64 set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/%core_name%_libretro.dll.zip
set output_dir=%temp_dir%\%core_name%_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading ( %core_name% ) --
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
set core_name=genesis_plus_gx
If %PROCARCH%==32 set current_url=http://buildbot.libretro.com/nightly/windows/x86/latest/%core_name%_libretro.dll.zip
If %PROCARCH%==64 set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/%core_name%_libretro.dll.zip
set output_dir=%temp_dir%\%core_name%_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading ( %core_name% ) --
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
set core_name=gw
If %PROCARCH%==32 set current_url=http://buildbot.libretro.com/nightly/windows/x86/latest/%core_name%_libretro.dll.zip
If %PROCARCH%==64 set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/%core_name%_libretro.dll.zip
set output_dir=%temp_dir%\%core_name%_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading ( %core_name% ) --
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
set core_name=handy
If %PROCARCH%==32 set current_url=http://buildbot.libretro.com/nightly/windows/x86/latest/%core_name%_libretro.dll.zip
If %PROCARCH%==64 set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/%core_name%_libretro.dll.zip
set output_dir=%temp_dir%\%core_name%_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading ( %core_name% ) --
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
set core_name=hatari
If %PROCARCH%==32 set current_url=http://buildbot.libretro.com/nightly/windows/x86/latest/%core_name%_libretro.dll.zip
If %PROCARCH%==64 set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/%core_name%_libretro.dll.zip
set output_dir=%temp_dir%\%core_name%_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading ( %core_name% ) --
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
set core_name=higan_sfc
If %PROCARCH%==32 set current_url=http://buildbot.libretro.com/nightly/windows/x86/latest/%core_name%_libretro.dll.zip
If %PROCARCH%==64 set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/%core_name%_libretro.dll.zip
set output_dir=%temp_dir%\%core_name%_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading ( %core_name% ) --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkg_fail
ping 127.0.0.1 -n 4 >nul
echo Done.
if "%fullinstall%"=="1" (
	goto dl_kronos
) else (
	goto install_libretrocores
)

:dl_kronos
cls
set core_name=kronos
If %PROCARCH%==32 set current_url=http://buildbot.libretro.com/nightly/windows/x86/latest/%core_name%_libretro.dll.zip
If %PROCARCH%==64 set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/%core_name%_libretro.dll.zip
set output_dir=%temp_dir%\%core_name%_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading ( %core_name% ) --
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
set core_name=mednafen_gba
If %PROCARCH%==32 set current_url=http://buildbot.libretro.com/nightly/windows/x86/latest/%core_name%_libretro.dll.zip
If %PROCARCH%==64 set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/%core_name%_libretro.dll.zip
set output_dir=%temp_dir%\%core_name%_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading ( %core_name% ) --
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
set core_name=mednafen_lynx
If %PROCARCH%==32 set current_url=http://buildbot.libretro.com/nightly/windows/x86/latest/%core_name%_libretro.dll.zip
If %PROCARCH%==64 set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/%core_name%_libretro.dll.zip
set output_dir=%temp_dir%\%core_name%_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading ( %core_name% ) --
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
set core_name=mednafen_ngp
If %PROCARCH%==32 set current_url=http://buildbot.libretro.com/nightly/windows/x86/latest/%core_name%_libretro.dll.zip
If %PROCARCH%==64 set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/%core_name%_libretro.dll.zip
set output_dir=%temp_dir%\%core_name%_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading ( %core_name% ) --
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
set core_name=mednafen_pce_fast
If %PROCARCH%==32 set current_url=http://buildbot.libretro.com/nightly/windows/x86/latest/%core_name%_libretro.dll.zip
If %PROCARCH%==64 set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/%core_name%_libretro.dll.zip
set output_dir=%temp_dir%\%core_name%_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading ( %core_name% ) --
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
set core_name=mednafen_pce
If %PROCARCH%==32 set current_url=http://buildbot.libretro.com/nightly/windows/x86/latest/%core_name%_libretro.dll.zip
If %PROCARCH%==64 set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/%core_name%_libretro.dll.zip
set output_dir=%temp_dir%\%core_name%_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading ( %core_name% ) --
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
set core_name=mednafen_pcfx
If %PROCARCH%==32 set current_url=http://buildbot.libretro.com/nightly/windows/x86/latest/%core_name%_libretro.dll.zip
If %PROCARCH%==64 set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/%core_name%_libretro.dll.zip
set output_dir=%temp_dir%\%core_name%_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading ( %core_name% ) --
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
set core_name=mednafen_psx_hw
If %PROCARCH%==32 set current_url=http://buildbot.libretro.com/nightly/windows/x86/latest/%core_name%_libretro.dll.zip
If %PROCARCH%==64 set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/%core_name%_libretro.dll.zip
set output_dir=%temp_dir%\%core_name%_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading ( %core_name% ) --
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
set core_name=mednafen_psx
If %PROCARCH%==32 set current_url=http://buildbot.libretro.com/nightly/windows/x86/latest/%core_name%_libretro.dll.zip
If %PROCARCH%==64 set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/%core_name%_libretro.dll.zip
set output_dir=%temp_dir%\%core_name%_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading ( %core_name% ) --
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
set core_name=mednafen_saturn
If %PROCARCH%==32 set current_url=http://buildbot.libretro.com/nightly/windows/x86/latest/%core_name%_libretro.dll.zip
If %PROCARCH%==64 set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/%core_name%_libretro.dll.zip
set output_dir=%temp_dir%\%core_name%_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading ( %core_name% ) --
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
set core_name=mednafen_supergrafx
If %PROCARCH%==32 set current_url=http://buildbot.libretro.com/nightly/windows/x86/latest/%core_name%_libretro.dll.zip
If %PROCARCH%==64 set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/%core_name%_libretro.dll.zip
set output_dir=%temp_dir%\%core_name%_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading ( %core_name% ) --
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
set core_name=mednafen_vb
If %PROCARCH%==32 set current_url=http://buildbot.libretro.com/nightly/windows/x86/latest/%core_name%_libretro.dll.zip
If %PROCARCH%==64 set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/%core_name%_libretro.dll.zip
set output_dir=%temp_dir%\%core_name%_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading ( %core_name% ) --
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
set core_name=mednafen_wswan
If %PROCARCH%==32 set current_url=http://buildbot.libretro.com/nightly/windows/x86/latest/%core_name%_libretro.dll.zip
If %PROCARCH%==64 set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/%core_name%_libretro.dll.zip
set output_dir=%temp_dir%\%core_name%_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading ( %core_name% ) --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkg_fail
ping 127.0.0.1 -n 4 >nul
echo Done.
if "%fullinstall%"=="1" (
	goto dl_mgba
) else (
	goto install_libretrocores
)

:dl_mgba
cls
set core_name=mgba
If %PROCARCH%==32 set current_url=http://buildbot.libretro.com/nightly/windows/x86/latest/%core_name%_libretro.dll.zip
If %PROCARCH%==64 set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/%core_name%_libretro.dll.zip
set output_dir=%temp_dir%\%core_name%_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading ( %core_name% ) --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkg_fail
ping 127.0.0.1 -n 4 >nul
echo Done.
if "%fullinstall%"=="1" (
	goto dl_mupen64plus_next
) else (
	goto install_libretrocores
)

:dl_mupen64plus_next
cls
set core_name=mupen64plus_next
If %PROCARCH%==32 set current_url=http://buildbot.libretro.com/nightly/windows/x86/latest/%core_name%_libretro.dll.zip
If %PROCARCH%==64 set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/%core_name%_libretro.dll.zip
set output_dir=%temp_dir%\%core_name%_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading ( %core_name% ) --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkg_fail
ping 127.0.0.1 -n 4 >nul
echo Done.
if "%fullinstall%"=="1" (
	goto dl_nestopia
) else (
	goto install_libretrocores
)

:dl_nestopia
cls
set core_name=nestopia
If %PROCARCH%==32 set current_url=http://buildbot.libretro.com/nightly/windows/x86/latest/%core_name%_libretro.dll.zip
If %PROCARCH%==64 set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/%core_name%_libretro.dll.zip
set output_dir=%temp_dir%\%core_name%_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading ( %core_name% ) --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkg_fail
ping 127.0.0.1 -n 4 >nul
echo Done.
if "%fullinstall%"=="1" (
	goto dl_nxengine
) else (
	goto install_libretrocores
)

:dl_nxengine
cls
set core_name=nxengine
If %PROCARCH%==32 set current_url=http://buildbot.libretro.com/nightly/windows/x86/latest/%core_name%_libretro.dll.zip
If %PROCARCH%==64 set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/%core_name%_libretro.dll.zip
set output_dir=%temp_dir%\%core_name%_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading ( %core_name% ) --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkg_fail
ping 127.0.0.1 -n 4 >nul
echo Done.
if "%fullinstall%"=="1" (
	goto dl_o2em
) else (
	goto install_libretrocores
)

:dl_o2em
cls
set core_name=o2em
If %PROCARCH%==32 set current_url=http://buildbot.libretro.com/nightly/windows/x86/latest/%core_name%_libretro.dll.zip
If %PROCARCH%==64 set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/%core_name%_libretro.dll.zip
set output_dir=%temp_dir%\%core_name%_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading ( %core_name% ) --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkg_fail
ping 127.0.0.1 -n 4 >nul
echo Done.
if "%fullinstall%"=="1" (
	goto dl_picodrive
) else (
	goto install_libretrocores
)

:dl_picodrive
cls
set core_name=picodrive
If %PROCARCH%==32 set current_url=http://buildbot.libretro.com/nightly/windows/x86/latest/%core_name%_libretro.dll.zip
If %PROCARCH%==64 set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/%core_name%_libretro.dll.zip
set output_dir=%temp_dir%\%core_name%_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading ( %core_name% ) --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkg_fail
ping 127.0.0.1 -n 4 >nul
echo Done.
if "%fullinstall%"=="1" (
	goto dl_play
) else (
	goto install_libretrocores
)

:dl_play
cls
set core_name=play
If %PROCARCH%==32 set current_url=http://buildbot.libretro.com/nightly/windows/x86/latest/%core_name%_libretro.dll.zip
If %PROCARCH%==64 set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/%core_name%_libretro.dll.zip
set output_dir=%temp_dir%\%core_name%_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading ( %core_name% ) --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkg_fail
ping 127.0.0.1 -n 4 >nul
echo Done.
if "%fullinstall%"=="1" (
	goto dl_ppsspp
) else (
	goto install_libretrocores
)

:dl_ppsspp
cls
set core_name=ppsspp
If %PROCARCH%==32 set current_url=http://buildbot.libretro.com/nightly/windows/x86/latest/%core_name%_libretro.dll.zip
If %PROCARCH%==64 set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/%core_name%_libretro.dll.zip
set output_dir=%temp_dir%\%core_name%_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading ( %core_name% ) --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkg_fail
ping 127.0.0.1 -n 4 >nul
echo Done.
if "%fullinstall%"=="1" (
	goto dl_prosystem
) else (
	goto install_libretrocores
)

:dl_prosystem
cls
set core_name=prosystem
If %PROCARCH%==32 set current_url=http://buildbot.libretro.com/nightly/windows/x86/latest/%core_name%_libretro.dll.zip
If %PROCARCH%==64 set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/%core_name%_libretro.dll.zip
set output_dir=%temp_dir%\%core_name%_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading ( %core_name% ) --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkg_fail
ping 127.0.0.1 -n 4 >nul
echo Done.
if "%fullinstall%"=="1" (
	goto dl_puae
) else (
	goto install_libretrocores
)

:dl_puae
cls
set core_name=puae
If %PROCARCH%==32 set current_url=http://buildbot.libretro.com/nightly/windows/x86/latest/%core_name%_libretro.dll.zip
If %PROCARCH%==64 set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/%core_name%_libretro.dll.zip
set output_dir=%temp_dir%\%core_name%_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading ( %core_name% ) --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkg_fail
ping 127.0.0.1 -n 4 >nul
echo Done.
if "%fullinstall%"=="1" (
	goto dl_quicknes
) else (
	goto install_libretrocores
)

:dl_quicknes
cls
set core_name=quicknes
If %PROCARCH%==32 set current_url=http://buildbot.libretro.com/nightly/windows/x86/latest/%core_name%_libretro.dll.zip
If %PROCARCH%==64 set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/%core_name%_libretro.dll.zip
set output_dir=%temp_dir%\%core_name%_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading ( %core_name% ) --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkg_fail
ping 127.0.0.1 -n 4 >nul
echo Done.
if "%fullinstall%"=="1" (
	goto dl_scummvm
) else (
	goto install_libretrocores
)

:dl_scummvm
cls
set core_name=scummvm
If %PROCARCH%==32 set current_url=http://buildbot.libretro.com/nightly/windows/x86/latest/%core_name%_libretro.dll.zip
If %PROCARCH%==64 set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/%core_name%_libretro.dll.zip
set output_dir=%temp_dir%\%core_name%_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading ( %core_name% ) --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkg_fail
ping 127.0.0.1 -n 4 >nul
echo Done.
if "%fullinstall%"=="1" (
	goto dl_snes9x
) else (
	goto install_libretrocores
)

:dl_snes9x
cls
set core_name=snes9x
If %PROCARCH%==32 set current_url=http://buildbot.libretro.com/nightly/windows/x86/latest/%core_name%_libretro.dll.zip
If %PROCARCH%==64 set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/%core_name%_libretro.dll.zip
set output_dir=%temp_dir%\%core_name%_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading ( %core_name% ) --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkg_fail
ping 127.0.0.1 -n 4 >nul
echo Done.
if "%fullinstall%"=="1" (
	goto dl_stella
) else (
	goto install_libretrocores
)

:dl_stella
cls
set core_name=stella
If %PROCARCH%==32 set current_url=http://buildbot.libretro.com/nightly/windows/x86/latest/%core_name%_libretro.dll.zip
If %PROCARCH%==64 set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/%core_name%_libretro.dll.zip
set output_dir=%temp_dir%\%core_name%_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading ( %core_name% ) --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkg_fail
ping 127.0.0.1 -n 4 >nul
echo Done.
if "%fullinstall%"=="1" (
	goto dl_tgbdual
) else (
	goto install_libretrocores
)

:dl_tgbdual
cls
set core_name=tgbdual
If %PROCARCH%==32 set current_url=http://buildbot.libretro.com/nightly/windows/x86/latest/%core_name%_libretro.dll.zip
If %PROCARCH%==64 set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/%core_name%_libretro.dll.zip
set output_dir=%temp_dir%\%core_name%_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading ( %core_name% ) --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkg_fail
ping 127.0.0.1 -n 4 >nul
echo Done.
if "%fullinstall%"=="1" (
	goto dl_theodore
) else (
	goto install_libretrocores
)

:dl_theodore
cls
set core_name=theodore
If %PROCARCH%==32 set current_url=http://buildbot.libretro.com/nightly/windows/x86/latest/%core_name%_libretro.dll.zip
If %PROCARCH%==64 set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/%core_name%_libretro.dll.zip
set output_dir=%temp_dir%\%core_name%_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading ( %core_name% ) --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkg_fail
ping 127.0.0.1 -n 4 >nul
echo Done.
if "%fullinstall%"=="1" (
	goto dl_vecx
) else (
	goto install_libretrocores
)

:dl_vecx
cls
set core_name=vecx
If %PROCARCH%==32 set current_url=http://buildbot.libretro.com/nightly/windows/x86/latest/%core_name%_libretro.dll.zip
If %PROCARCH%==64 set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/%core_name%_libretro.dll.zip
set output_dir=%temp_dir%\%core_name%_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading ( %core_name% ) --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkg_fail
ping 127.0.0.1 -n 4 >nul
echo Done.
if "%fullinstall%"=="1" (
	goto dl_vice_x64
) else (
	goto install_libretrocores
)

:dl_vice_x64
cls
set core_name=vice_x64
If %PROCARCH%==32 set current_url=http://buildbot.libretro.com/nightly/windows/x86/latest/%core_name%_libretro.dll.zip
If %PROCARCH%==64 set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/%core_name%_libretro.dll.zip
set output_dir=%temp_dir%\%core_name%_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading ( %core_name% ) --
echo.
call %scripts_dir%\powershelldl.cmd
if %ERRORLEVEL% == 1 goto pkg_fail
ping 127.0.0.1 -n 4 >nul
echo Done.
if "%fullinstall%"=="1" (
	goto dl_virtualjaguar
) else (
	goto install_libretrocores
)

:dl_virtualjaguar
cls
set core_name=virtualjaguar
If %PROCARCH%==32 set current_url=http://buildbot.libretro.com/nightly/windows/x86/latest/%core_name%_libretro.dll.zip
If %PROCARCH%==64 set current_url=http://buildbot.libretro.com/nightly/windows/x86_64/latest/%core_name%_libretro.dll.zip
set output_dir=%temp_dir%\%core_name%_libretro.dll.zip
if exist %output_dir% goto install_libretrocores
echo -- Libretro Core is now downloading ( %core_name% ) --
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
Echo  An error occured and package files can not be found.
Echo.
timeout /t 3 >nul
if exist %temp_dir%\*.dll.zip goto install_libretrocores
goto exit 

:exit
exit 

:install_libretrocores
cls
echo -- Libretro Cores are installing --
echo.
if exist %temp_dir%\*.dll.zip %zip_dir%\7zg.exe -y x "%temp_dir%\*.dll.zip" -o"%retroarch_dir%\cores" -aoa
timeout /t 1 >nul
if exist %temp_dir%\*.dll.zip del/Q %temp_dir%\*.dll.zip>nul
echo Done.
cls
goto:eof
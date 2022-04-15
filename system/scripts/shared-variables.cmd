goto:rem
---------------------------------------
shared-variables.cmd
---------------------------------------
This Batch script is originally created for RetroBat.
It's not intended to run on its own but must be called by other scripts in order to share some common information required by them.
---------------------------------------
:rem

:: ---- GENERAL INFOS ----
set name=RetroBat
echo name=%name%>> "%tmp_infos_file%"

:: ---- PROCESSOR ARCHITECTURE INFO ----

Reg Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > nul && set archx=x86 || set archx=x86_64

if "%archx%"=="x86_64" (
	set arch=win64
) else (
	set arch=win32
)
echo archx=%archx%>> "%tmp_infos_file%"
echo arch=%arch%>> "%tmp_infos_file%"

:: ---- RETROBAT PATHS ----

echo batgui_path=!root_path!>> "%tmp_infos_file%"
echo batocera_ports_path=!root_path!\emulationstation>> "%tmp_infos_file%"
echo bios_path=!root_path!\bios>> "%tmp_infos_file%"
echo decorations_path=!root_path!\system\decorations>> "%tmp_infos_file%"
echo default_theme_path=!root_path!\emulationstation\.emulationstation\themes>> "%tmp_infos_file%"
echo download_path=!root_path!\system\download>> "%tmp_infos_file%"
echo emulationstation_path=!root_path!\emulationstation>> "%tmp_infos_file%"
echo emulators_path=!root_path!\emulators>> "%tmp_infos_file%"
echo extraction_path=!root_path!\system\download\extract>> "%tmp_infos_file%"
echo lrcores_path=!root_path!\emulators\retroarch\cores>> "%tmp_infos_file%"
echo retroarch_path=!root_path!\emulators\retroarch>> "%tmp_infos_file%"
echo roms_path=!root_path!\roms>> "%tmp_infos_file%"
echo saves_path=!root_path!\saves>> "%tmp_infos_file%"
echo shaders_path=!root_path!\system\shaders>> "%tmp_infos_file%"
echo system_path=!root_path!\system>> "%tmp_infos_file%"

:: ---- SET INFOS ABOUT RETROBAT VERSION ----

set version_file_local=version.info
set version_file_remote=remote_version.info

if exist "!root_path!\system\modules\rb_updater\%version_file_remote%" del/Q "!root_path!\system\modules\rb_updater\%version_file_remote%" 

if not exist "!root_path!\system\modules\rb_updater\%version_file_remote%" "!root_path!\system\modules\rb_updater\wget" --no-check-certificate wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 3 -P "!root_path!\system\modules\rb_updater" https://www.retrobat.ovh/repo/%arch%/%branch%/%version_file_remote% -q >nul

cd !root_path!\system\modules\rb_updater
set/p version_remote=<%version_file_remote%
echo version_remote=%version_remote%>> "%tmp_infos_file%"

cd !root_path!\emulationstation
set/p version_local=<%version_file_local%
echo version_local=%version_local%>> "%tmp_infos_file%"

:: ---- URLS ----

echo batgui_url=https://www.retrobat.ovh/repo/%arch%/%branch%>> "%tmp_infos_file%"
echo batocera_ports_url=https://github.com/fabricecaruso/batocera-ports/releases/tag/continuous>> "%tmp_infos_file%"
echo bios_url=https://www.retrobat.ovh/repo/%arch%/%branch%>> "%tmp_infos_file%"
echo decorations_url=https://www.retrobat.ovh/repo/%arch%/%branch%>> "%tmp_infos_file%"
echo default_theme_url=https://github.com/fabricecaruso/es-theme-carbon/archive/refs/heads>> "%tmp_infos_file%"
echo emulationstation_url=https://github.com/fabricecaruso/batocera-emulationstation/releases/tag/continuous-master>> "%tmp_infos_file%"
echo lrcores_url=https://buildbot.libretro.com/nightly/windows/%archx%/latest>> "%tmp_infos_file%"
echo releases_url=https://www.retrobat.ovh/releases>> "%tmp_infos_file%"
echo retroarch_url=https://buildbot.libretro.com/%branch%/%retroarch_version%/windows/%archx%>> "%tmp_infos_file%"
echo retrobat_url=https://www.retrobat.ovh/repo/%arch%/%branch%>> "%tmp_infos_file%"

:: ---- GO BACK TO PARENT SCRIPT ----

goto :eof

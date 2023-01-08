goto:rem
---------------------------------------
shared-variables.cmd
---------------------------------------
This Batch script is originally created for RetroBat.
It's not intended to run on its own but must be called by other scripts in order to share some common information required by them.
---------------------------------------
:rem

:: ---- GENERAL INFOS ----
set name=retrobat
(echo name=%name%)>> "%tmp_infos_file%"

:: ---- PROCESSOR ARCHITECTURE INFO ----

Reg Query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" | find /i "AMD64" > nul && (set archx=x86_64) || (set archx=x86)

if "%archx%"=="x86_64" (set arch=win64)
if "%archx%"=="x86" (set arch=win32)
(echo archx=%archx%)>> "%tmp_infos_file%"
(echo arch=%arch%)>> "%tmp_infos_file%"

:: ---- RETROBAT PATHS ----

(set build_path=!root_path!\build)
(echo build_path=!root_path!\build)>> "%tmp_infos_file%"
if "%archx%"=="x86_64" (echo msys_path=%SystemDrive%\msys64)>> "%tmp_infos_file%"
if "%archx%"=="x86" (echo msys_path=%SystemDrive%\msys)>> "%tmp_infos_file%"

if not "%script_type%" == "builder" (

	(echo batgui_path=!root_path!)>> "%tmp_infos_file%"
	(echo batocera_ports_path=!root_path!\emulationstation)>> "%tmp_infos_file%"
	(echo bios_path=!root_path!\bios)>> "%tmp_infos_file%"
	(echo decorations_path=!root_path!\system\decorations)>> "%tmp_infos_file%"
	(echo default_theme_path=!root_path!\emulationstation\.emulationstation\themes\es-theme-carbon)>> "%tmp_infos_file%"
	(echo download_path=!root_path!\system\download)>> "%tmp_infos_file%"
	(echo emulationstation_path=!root_path!\emulationstation)>> "%tmp_infos_file%"
	(echo emulators_path=!root_path!\emulators)>> "%tmp_infos_file%"
	(echo extraction_path=!root_path!\system\download\extract)>> "%tmp_infos_file%"
	(echo lrcores_path=!root_path!\emulators\retroarch\cores)>> "%tmp_infos_file%"
	(echo mega_bezels_path=!root_path!)>> "%tmp_infos_file%"
	(echo retroarch_path=!root_path!\emulators\retroarch)>> "%tmp_infos_file%"
	(echo retrobat_path=!root_path!)>> "%tmp_infos_file%"
	(echo retrobat_binaries_path=!root_path!)>> "%tmp_infos_file%"
	(echo roms_path=!root_path!\roms)>> "%tmp_infos_file%"
	(echo saves_path=!root_path!\saves)>> "%tmp_infos_file%"
	(echo shaders_path=!root_path!\system\shaders)>> "%tmp_infos_file%"
	(echo system_path=!root_path!\system)>> "%tmp_infos_file%"
	(echo wiimotegun_path=!root_path!\emulationstation)>> "%tmp_infos_file%"

) else (

	(echo batgui_path=!build_path!)>> "%tmp_infos_file%"
	(echo batocera_ports_path=!build_path!\emulationstation)>> "%tmp_infos_file%"
	(echo bios_path=!build_path!\bios)>> "%tmp_infos_file%"
	(echo decorations_path=!build_path!\system\decorations)>> "%tmp_infos_file%"
	(echo default_theme_path=!build_path!\emulationstation\.emulationstation\themes\es-theme-carbon)>> "%tmp_infos_file%"
	(echo download_path=!build_path!\system\download)>> "%tmp_infos_file%"
	(echo emulationstation_path=!build_path!\emulationstation)>> "%tmp_infos_file%"
	(echo emulators_path=!build_path!\emulators)>> "%tmp_infos_file%"
	(echo extraction_path=!build_path!\system\download\extract)>> "%tmp_infos_file%"
	(echo lrcores_path=!build_path!\emulators\retroarch\cores)>> "%tmp_infos_file%"
	(echo mega_bezels_path=!build_path!)>> "%tmp_infos_file%"
	(echo retroarch_path=!build_path!\emulators\retroarch)>> "%tmp_infos_file%"
	(echo retrobat_path=!build_path!)>> "%tmp_infos_file%"
	(echo retrobat_binaries_path=!build_path!)>> "%tmp_infos_file%"
	(echo roms_path=!build_path!\roms)>> "%tmp_infos_file%"
	(echo saves_path=!build_path!\saves)>> "%tmp_infos_file%"
	(echo shaders_path=!build_path!\system\shaders)>> "%tmp_infos_file%"
	(echo system_path=!build_path!\system)>> "%tmp_infos_file%"
	(echo wiimotegun_path=!build_path!\emulationstation)>> "%tmp_infos_file%"
)
	
:: ---- URLS ----

set installroot_url=https://www.retrobat.ovh

if not "%script_type%" == "builder" (

	(echo archive_url=%installroot_url%/repo/%arch%/%branch%/archives)>> "%tmp_infos_file%"

) else (

	(echo batgui_url=%installroot_url%/repo/%arch%/%branch%)>> "%tmp_infos_file%"
	(echo batocera_ports_url=https://github.com/fabricecaruso/batocera-ports/releases/download/continuous)>> "%tmp_infos_file%"	
	(echo emulationstation_url=https://github.com/fabricecaruso/batocera-emulationstation/releases/download/continuous-master)>> "%tmp_infos_file%"
	(echo emulators_url=%installroot_url%/repo/%arch%/%branch%/emulators)>> "%tmp_infos_file%"
	(echo lrcores_url=https://buildbot.libretro.com/nightly/windows/%archx%/latest)>> "%tmp_infos_file%"
	(echo mega_bezels_url=%installroot_url%/repo/medias)>> "%tmp_infos_file%"
	(echo retroarch_url=https://buildbot.libretro.com/stable/%retroarch_version%/windows/%archx%)>> "%tmp_infos_file%"
	(echo retrobat_binaries_url=%installroot_url%/repo/tools)>> "%tmp_infos_file%"
	(echo wiimotegun_url=https://github.com/fabricecaruso/WiimoteGun/releases/download/v1.0)>> "%tmp_infos_file%"

)

:: ---- SET VERSIONS ----

set version_file_local=version.info
set version_file_remote=remote_version.info

if exist "%root_path%\emulationstation\%version_file_local%" (

	set/P version_local=<"%root_path%\emulationstation\%version_file_local%"
	echo version_local=!version_local!>> "%tmp_infos_file%"
)

if not "%script_type%" == "builder" if not "%extract_pkg%" == "es" (

	if exist "%root_path%\system\modules\rb_updater\%version_file_remote%" del/Q "%root_path%\system\modules\rb_updater\%version_file_remote%" >nul
	if exist "%root_path%\system\modules\rb_updater\%version_file_remote%.*" del/Q "%root_path%\system\modules\rb_updater\%version_file_remote%.*" >nul
	"%root_path%\system\modules\rb_updater\wget" --no-check-certificate --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 3 -P "%root_path%\system\modules\rb_updater" %installroot_url%/repo/%arch%/%branch%/%version_local%/%version_file_remote% -q

	if not exist "%root_path%\system\modules\rb_updater\%version_file_remote%" (
	
		(set exit_msg=error: missing version file)
		(set/A exit_code=2)
		goto :eof
		
	) else (
	
		(set/A exit_code=0)
	)
)

if exist "%root_path%\system\modules\rb_updater\%version_file_remote%" (
	
	set/P version_remote=<"%root_path%\system\modules\rb_updater\%version_file_remote%"
	(echo version_remote=!version_remote!)>> "%tmp_infos_file%"
	
)

:: ---- GO BACK TO PARENT SCRIPT ----

goto :eof

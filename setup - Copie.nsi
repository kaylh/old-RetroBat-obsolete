/*
********************************

  RetroBat Setup NSIS Script

********************************
*/
SetCompressor lzma
RequestExecutionLevel user
Unicode true

!define PRODUCT "RetroBat"
!define FILENAME "retrobat"
;!define BRANCH "stable"
;!define PRODUCT_VERSION "5.0.0"
!define VERSION "${RELEASE_VERSION}"
;!define /date TIMESTAMP "%Y%m%d%H%M"
;!define /date TIMESTAMP2 "%Y/%m/%d %H:%M:%S"
!define PRODUCT_PUBLISHER "RetroBat Team"
!define PRODUCT_WEB_SITE "https://www.retrobat.org/"

!define BASE_SOURCE ".\build"
!define BASE_TARGET "$(^Name)"
!define RESOURCES_PATH "${BASE_SOURCE}\system\resources"

!include "MUI2.nsh"
!include "FileFunc.nsh"
!include "LogicLib.nsh"

Name "${PRODUCT}"
OutFile "${FILENAME}-v${VERSION}-setup.exe"
InstallDir "C:\${BASE_TARGET}"
ShowInstDetails "hide"
BrandingText "(c) ${PRODUCT_PUBLISHER}"
SpaceTexts none

!define MUI_ABORTWARNING
!define MUI_ABORTWARNING_TEXT "Are you sure you wish to abort installation?"
!define MUI_COMPONENTSPAGE_SMALLDESC
!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_BITMAP "${RESOURCES_PATH}\retrobat_header.bmp"
!define MUI_HEADERIMAGE_BITMAP_STRETCH "FitControl"
!define MUI_HEADER_TRANSPARENT_TEXT
!define MUI_ICON "${RESOURCES_PATH}\retrobat-icon-white.ico"
!define MUI_WELCOMEFINISHPAGE_BITMAP "${RESOURCES_PATH}\retrobat_wizard.bmp"
!define MUI_FINISHPAGE_SHOWREADME
!define MUI_FINISHPAGE_SHOWREADME_TEXT "Create Desktop Shortcut"
!define MUI_FINISHPAGE_SHOWREADME_FUNCTION CreateDesktopShortCut
!define MUI_FINISHPAGE_LINK "Visit official ${PRODUCT} website: ${PRODUCT_WEB_SITE}"
!define MUI_FINISHPAGE_LINK_LOCATION "${PRODUCT_WEB_SITE}"

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "license.txt"
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH
!insertmacro MUI_LANGUAGE "English"
/*
Function CreateVersionFile
 FileOpen $0 "$INSTDIR\system\version.info" w
 FileWrite $0 "${VERSION}"
 FileClose $0
FunctionEnd
*/
!macro MUI_FINISHPAGE_SHORTCUT
  !ifndef MUI_FINISHPAGE_NOREBOOTSUPPORT
    !define MUI_FINISHPAGE_NOREBOOTSUPPORT
    !ifdef MUI_FINISHPAGE_RUN
      !undef MUI_FINISHPAGE_RUN
    !endif
  !endif
  !define MUI_PAGE_CUSTOMFUNCTION_SHOW DisableCancelButton
  !insertmacro MUI_PAGE_FINISH
  !define MUI_PAGE_CUSTOMFUNCTION_SHOW DisableBackButton
 
  Function DisableCancelButton
    EnableWindow $mui.Button.Cancel 0
  FunctionEnd
 
  Function DisableBackButton
    EnableWindow $mui.Button.Back 0
  FunctionEnd
!macroend

Function CreateDesktopShortCut
 CreateShortCut "$DESKTOP\RetroBat.lnk" "$INSTDIR\retrobat.exe"
FunctionEnd

;Installer Sections     
Section "install"
/*
;Add files
  SetOutPath "$INSTDIR"
  
  Delete ${BASE_SOURCE}\*.log
  
  SetOverwrite ifnewer
 
  File ${BASE_SOURCE}\${FILENAME}.exe
  File /nonfatal ${BASE_SOURCE}\${FILENAME}.ini
  File ${BASE_SOURCE}\${FILENAME}.dat
  File ${BASE_SOURCE}\readme.txt
  File ${BASE_SOURCE}\license.txt
  File /r ${BASE_SOURCE}\*.*
*/
  SetOverwrite ifnewer
/*  SetOutPath "$INSTDIR"
  File ${BASE_SOURCE}\${FILENAME}.exe
  File ${BASE_SOURCE}\${FILENAME}.dat
  File ${BASE_SOURCE}\readme.txt
  File ${BASE_SOURCE}\license.txt 
  SetOutPath "$INSTDIR\bios"
  File /nonfatal /r ${BASE_SOURCE}\bios\*.*
  SetOutPath "$INSTDIR\decorations"
  File /nonfatal /r ${BASE_SOURCE}\decorations\*.*
  SetOutPath "$INSTDIR\emulationstation"
  File /nonfatal ${BASE_SOURCE}\emulationstation\*.exe
  File /nonfatal ${BASE_SOURCE}\emulationstation\*.config
  File /nonfatal ${BASE_SOURCE}\emulationstation\*.dll
  File /nonfatal ${BASE_SOURCE}\emulationstation\*.cfg
  File /nonfatal ${BASE_SOURCE}\emulationstation\*.lib
  File /nonfatal ${BASE_SOURCE}\emulationstation\*.cmd
  File /nonfatal ${BASE_SOURCE}\emulationstation\*.exe
  SetOutPath "$INSTDIR\emulationstation\.emulationstation"
  File /nonfatal ${BASE_SOURCE}\emulationstation\.emulationstation\es_features.cfg
  File /nonfatal ${BASE_SOURCE}\emulationstation\.emulationstation\es_padtokey.cfg
  File /nonfatal ${BASE_SOURCE}\emulationstation\.emulationstation\notice.pdf
  SetOutPath "$INSTDIR\emulationstation\.emulationstation\themes"
  File /nonfatal /r ${BASE_SOURCE}\emulationstation\.emulationstation\themes\*.*
  SetOutPath "$INSTDIR\emulationstation\fr"
  File /nonfatal /r ${BASE_SOURCE}\emulationstation\fr\*.*"
  SetOutPath "$INSTDIR\emulationstation\plugins"
  File /nonfatal /r ${BASE_SOURCE}\emulationstation\plugins\*.*
  SetOutPath "$INSTDIR\emulationstation\resources"
  File /nonfatal /r ${BASE_SOURCE}\emulationstation\resources\*.*
  SetOutPath "$INSTDIR\emulationstation\store"
  File /nonfatal /r ${BASE_SOURCE}\emulationstation\store\*.*
*/ SetOutPath "$INSTDIR\emulators"
  File /nonfatal /r /x Dolphin.ini /x qt-config.ini /x config.xml /x Fusion.ini /x kronos.ini /x Emulator.ini /x default.cfg /x config.ini /x oricutron.cfg /x PCSX2_ui.ini /x PCSX2_vm.ini /x ppsspp.ini /x Project64.cfg /x raine32_sdl.cfg /x redream.cfg /x retroarch.cfg /x retroarch-core-options.cfg /x override\*.cfg /x snes9x.conf /x Supermodel.ini /x winuae.ini /x xemu.ini /x xemu.toml /x Demul.ini /x settings.ini ${BASE_SOURCE}\emulators\*.*
  SetOutPath "$INSTDIR\system"
  File /nonfatal /r ${BASE_SOURCE}\system\*.*
  
  SetOverwrite off
  SetOutPath "$INSTDIR" 
  File /nonfatal ${BASE_SOURCE}\${FILENAME}.ini
  SetOutPath "$INSTDIR\emulators\citra\user" 
  File /nonfatal ${BASE_SOURCE}\emulators\citra\user\qt-config.ini
  SetOutPath "$INSTDIR\emulators\cxbx-reloaded"
  File /nonfatal ${BASE_SOURCE}\emulators\cxbx-reloaded\settings.ini
  SetOutPath "$INSTDIR\emulators\daphne"
  File /nonfatal ${BASE_SOURCE}\emulators\daphne\config.xml
  SetOutPath "$INSTDIR\emulators\demul-old"
  File /nonfatal ${BASE_SOURCE}\emulators\demul-old\Demul.ini
  SetOutPath "$INSTDIR\emulators\demul"
  File /nonfatal ${BASE_SOURCE}\emulators\demul\Demul.ini
  SetOutPath "$INSTDIR\emulators\dolphin-emu\User\Config"
  File /nonfatal ${BASE_SOURCE}\emulators\dolphin-emu\User\Config\Dolphin.ini
  SetOutPath "$INSTDIR\emulators\dolphin-triforce\User\Config"
  File /nonfatal ${BASE_SOURCE}\emulators\dolphin-triforce\User\Config\Dolphin.ini
  SetOutPath "$INSTDIR\emulators\duckstation"
  File /nonfatal ${BASE_SOURCE}\emulators\duckstation\settings.ini
  SetOutPath "$INSTDIR\emulators\kega-fusion"
  File /nonfatal ${BASE_SOURCE}\emulators\kega-fusion\Fusion.ini
  SetOutPath "$INSTDIR\emulators\m2emulator"
  File /nonfatal ${BASE_SOURCE}\emulators\m2emulator\Emulator.ini
  SetOutPath "$INSTDIR\emulators\mesen-s"
  File /nonfatal ${BASE_SOURCE}\emulators\mesen-s\settings.xml
  SetOutPath "$INSTDIR\emulators\mesen"
  File /nonfatal ${BASE_SOURCE}\emulators\mesen\settings.xml
  SetOutPath "$INSTDIR\emulators\oricutron"
  File /nonfatal ${BASE_SOURCE}\emulators\oricutron\oricutron.cfg
  SetOutPath "$INSTDIR\emulators\pcsx2\inis"
  File /nonfatal ${BASE_SOURCE}\emulators\pcsx2\inis\PCSX2_ui.ini
  SetOutPath "$INSTDIR\emulators\pcsx2-16\inis"
  File /nonfatal ${BASE_SOURCE}\emulators\pcsx2-16\inis\PCSX2_vm.ini
  SetOutPath "$INSTDIR\emulators\ppsspp\memstick\PSP\SYSTEM"
  File /nonfatal ${BASE_SOURCE}\emulators\ppsspp\memstick\PSP\SYSTEM\ppsspp.ini
  SetOutPath "$INSTDIR\emulators\raine\config"
  File /nonfatal ${BASE_SOURCE}\emulators\raine\config\raine32_sdl.cfg
  SetOutPath "$INSTDIR\emulators\redream"
  File /nonfatal ${BASE_SOURCE}\emulators\redream\redream.cfg
  SetOutPath "$INSTDIR\emulators\retroarch\config\override"
  File /nonfatal ${BASE_SOURCE}\emulators\retroarch\config\override\*.cfg
  SetOutPath "$INSTDIR\emulators\retroarch"
  File /nonfatal ${BASE_SOURCE}\emulators\retroarch\retroarch-core-options.cfg
  File /nonfatal ${BASE_SOURCE}\emulators\retroarch\retroarch.cfg
  SetOutPath "$INSTDIR\emulators\snes9x"
  File /nonfatal ${BASE_SOURCE}\emulators\snes9x\snes9x.conf
  SetOutPath "$INSTDIR\emulators\supermodel"
  File /nonfatal ${BASE_SOURCE}\emulators\supermodel\Supermodel.ini
  SetOutPath "$INSTDIR\emulators\winuae"
  File /nonfatal ${BASE_SOURCE}\emulators\winuae\winuae.ini
  SetOutPath "$INSTDIR\emulators\xemu"
  File /nonfatal ${BASE_SOURCE}\emulators\xemu\xemu.ini
  File /nonfatal ${BASE_SOURCE}\emulators\xemu\xemu.toml

  SetOverwrite off	
  SetOutPath "$INSTDIR\emulationstation\.emulationstation"  
  File /nonfatal ${BASE_SOURCE}\emulationstation\.emulationstation\es_settings.cfg
  File /nonfatal ${BASE_SOURCE}\emulationstation\.emulationstation\es_input.cfg

;  Call CreateVersionFile
  
SectionEnd
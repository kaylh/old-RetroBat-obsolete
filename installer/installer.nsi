/*
********************************

  RetroBat Setup NSIS Script

********************************
*/

SetCompressor lzma

RequestExecutionLevel user

Unicode true

!define PRODUCT "RetroBat"
!define PRODUCT_VERSION "4.0.0"
!define VERSION "${PRODUCT_VERSION}"
!define /date TIMESTAMP "%Y%m%d-%H%M%S"
!define /date TIMESTAMP2 "%Y/%m/%d %H:%M:%S"
!define PRODUCT_PUBLISHER "RetroBat Team"
!define PRODUCT_WEB_SITE "https://www.retrobat.ovh/"

!define BASE_DIR ".."
!define BASE_INSTALL_DIR "C:\$(^Name)\"
!define DECORATIONS_DIR "$INSTDIR\decorations"
!define DECORATIONS_BASE "${BASE_DIR}\decorations"
!define EMULATIONSTATION_DIR "$INSTDIR\emulationstation"
!define EMULATIONSTATION_BASE "${BASE_DIR}\emulationstation"
!define EMULATORS_DIR "$INSTDIR\emulators"
!define EMULATORS_BASE "${BASE_DIR}\emulators"
!define DOWNLOAD_DIR "$INSTDIR\system\download"

!include "MUI2.nsh"
!include "FileFunc.nsh"
!include "LogicLib.nsh"

Name "${PRODUCT}"
OutFile "retrobat-v${VERSION}-${TIMESTAMP}-installer.exe"
InstallDir "${BASE_INSTALL_DIR}"
ShowInstDetails "hide"
;BrandingText "Copyright (c) 2020 ${PRODUCT_PUBLISHER}"
BrandingText "${PRODUCT} v${VERSION}"
SpaceTexts none

!define MUI_ABORTWARNING
!define MUI_ABORTWARNING_TEXT "Are you sure you wish to abort installation?"

;Var CompletedText
;CompletedText $CompletedText

;!define MUI_COMPONENTSPAGE_NODESC
!define MUI_COMPONENTSPAGE_SMALLDESC
!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_BITMAP "..\system\resources\retrobat_header.bmp"
!define MUI_HEADERIMAGE_BITMAP_STRETCH "FitControl"
!define MUI_HEADER_TRANSPARENT_TEXT
!define MUI_ICON "..\system\resources\retrobat-icon-white.ico"
;!define MUI_TEXTCOLOR "FFFFFF"
!define MUI_WELCOMEFINISHPAGE_BITMAP "..\system\resources\retrobat_wizard.bmp"

!define MUI_COMPONENTSPAGE_TEXT_TOP "Choose the type of installation."
!define MUI_COMPONENTSPAGE_TEXT_COMPLIST " "
  
!define MUI_FINISHPAGE_SHOWREADME
!define MUI_FINISHPAGE_SHOWREADME_TEXT "Create Desktop Shortcut"
!define MUI_FINISHPAGE_SHOWREADME_FUNCTION CreateDesktopShortCut
 
!define MUI_FINISHPAGE_LINK "Visit official RetroBat website: www.retrobat.ovh"
!define MUI_FINISHPAGE_LINK_LOCATION "https://www.retrobat.ovh/"

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "..\license.txt"
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_DIRECTORY

;!define MUI_FINISHPAGE_NOAUTOCLOSE

!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_LANGUAGE "English"

Function CreateVersionFile
 FileOpen $0 "$INSTDIR\system\version.info" w
 FileWrite $0 "${VERSION} ${TIMESTAMP2}"
 FileClose $0
FunctionEnd


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
 
InstType /COMPONENTSONLYONCUSTOM
InstType "Full installation" SEC01
InstType "Lite installation" SEC02
;InstType "Update existing installation" SEC03
;InstType "Install DirectX Runtime" SEC04
;InstType "Install Visual C++" SEC05

Function .onInit
 SetCurInstType 1
FunctionEnd

Function CreateDesktopShortCut
 CreateShortCut "$DESKTOP\RetroBat.lnk" "$INSTDIR\retrobat.exe" "" "$INSTDIR\system\resources\retrobat-icon.ico"
FunctionEnd

SectionGroup "-RetroBat"

Section /o "Main Files" SectionRetroBat
SectionInstType ${SEC01} ${SEC02}

 SectionIn RO
 SetOutPath "$INSTDIR"
 SetOverwrite ifnewer
 
 SetDetailsPrint textonly
	DetailPrint "Copying RetroBat main files..."
 SetDetailsPrint listonly
 
 Delete "$INSTDIR\retrobat.exe"
 Delete "$INSTDIR\license.txt"
 Delete "$INSTDIR\*.dll"
 RMDir /r "$INSTDIR\system\configmenu"
 RMDir /r "$INSTDIR\system\resources"
 RMDir /r "$INSTDIR\system\shaders"
 RMDir /r "$INSTDIR\system\templates"

 
 File "${BASE_DIR}\retrobat.exe"
 File "${BASE_DIR}\retrobat.ini"
 File "${BASE_DIR}\license.txt"
 File /nonfatal "${BASE_DIR}\*.dll" 
 File /r "${BASE_DIR}\system"
 File /r "${BASE_DIR}\bios"

 SetDetailsPrint textonly
	DetailPrint "Creating RetroBat folders"
 SetDetailsPrint listonly

 ifFileExists "$INSTDIR\retrobat.exe" 0 +3

 ExecWait "$INSTDIR\retrobat.exe /NOF #MakeTree"
 SetDetailsPrint listonly
 
 Call CreateVersionFile

;  SetOutPath "$TEMP"
;  SetOverwrite on
;  File /r "dxredist"
;  File /r "vcredist"
SectionEnd

Section /o "EmulationStation" SectionES
SectionInstType ${SEC01} ${SEC02}

 SetOutPath "${EMULATIONSTATION_DIR}"
 SetOverwrite ifnewer
 
 SetDetailsPrint textonly
	DetailPrint "Copying EmulationStation files..."
 SetDetailsPrint listonly

 Delete "${EMULATIONSTATION_DIR}\*.exe"
 Delete "${EMULATIONSTATION_DIR}\*.log"
 Delete "${EMULATIONSTATION_DIR}\*.dll"
 Delete "${EMULATIONSTATION_DIR}\*.old"
 Delete "${EMULATIONSTATION_DIR}\*.lib"
 Delete "${EMULATIONSTATION_DIR}\*.info"
 Delete "${EMULATIONSTATION_DIR}\*.cfg"

 RMDir /r "${EMULATIONSTATION_DIR}\plugins"
 RMDir /r "${EMULATIONSTATION_DIR}\resources"

 File "${EMULATIONSTATION_BASE}\*.exe"
 File "${EMULATIONSTATION_BASE}\*.dll"
 File /nonfatal "${EMULATIONSTATION_BASE}\*.lib"
 File "${EMULATIONSTATION_BASE}\*.info"
 File /nonfatal "${EMULATIONSTATION_BASE}\*.cfg"

 File /r "${EMULATIONSTATION_BASE}\plugins"
 File /r "${EMULATIONSTATION_BASE}\resources"

 SetOutPath "${EMULATIONSTATION_DIR}\.emulationstation"
 SetOverwrite ifnewer

 IfFileExists "${EMULATIONSTATION_DIR}\.emulationstation\*.cfg" 0 +2
 CopyFiles "${EMULATIONSTATION_DIR}\.emulationstation\*.cfg" "${EMULATIONSTATION_DIR}\.emulationstation\*.cfg.old"
 Delete "${EMULATIONSTATION_DIR}\.emulationstation\es_features.cfg"
 Delete "${EMULATIONSTATION_DIR}\.emulationstation\es_padtokey.cfg"
 Delete "${EMULATIONSTATION_DIR}\.emulationstation\es_systems.cfg"
 Delete "${EMULATIONSTATION_DIR}\.emulationstation\es_settings.cfg"
 Delete "${EMULATIONSTATION_DIR}\.emulationstation\es_log.txt"
 Delete "${EMULATIONSTATION_DIR}\.emulationstation\*.bak"

 File /nonfatal "${EMULATIONSTATION_BASE}\.emulationstation\es_features.cfg"
 File /nonfatal "${EMULATIONSTATION_BASE}\.emulationstation\es_padtokey.cfg"
 File /nonfatal "${EMULATIONSTATION_BASE}\.emulationstation\es_systems.cfg"
 File /nonfatal "${EMULATIONSTATION_BASE}\.emulationstation\es_settings.cfg"
 
 SetOverwrite off
 
 File /nonfatal "${EMULATIONSTATION_BASE}\.emulationstation\es_input.cfg"

 SetOutPath "${EMULATIONSTATION_DIR}\.emulationstation\themes"
 SetOverwrite ifnewer

 RMDir /r "${EMULATIONSTATION_DIR}\.emulationstation\themes\es-theme-carbon"
 File /r /x "${EMULATIONSTATION_BASE}\.emulationstation\themes\es-theme-carbon\.git\*.*" "${EMULATIONSTATION_BASE}\.emulationstation\themes\es-theme-carbon"

 SetOutPath "${EMULATIONSTATION_DIR}\.emulationstation\video"
 SetOverwrite ifnewer

 File /nonfatal "${EMULATIONSTATION_BASE}\.emulationstation\video\*.mp4"
 File /nonfatal "${EMULATIONSTATION_BASE}\.emulationstation\video\*.m4v"

 
SectionEnd

Section /o "RetroArch" SectionRetroArch
SectionInstType ${SEC01} ${SEC02}

 SetOutPath "${EMULATORS_DIR}"
 SetOverwrite ifnewer
 
 SetDetailsPrint textonly
	DetailPrint "Copying RetroArch files..."
 SetDetailsPrint listonly
 
 File /r /x "${EMULATORS_BASE}\retroarch\retroarch.cfg" /x "${EMULATORS_BASE}\retroarch\retroarch-core-options.cfg" "${EMULATORS_BASE}\retroarch"
 
SectionEnd

Section /o "Standalone emulators" SectionEmulators
SectionInstType ${SEC01}

 SetOutPath "${EMULATORS_DIR}"
 SetOverwrite ifnewer
 
 SetDetailsPrint textonly
	DetailPrint "Copying emulators files..."
 SetDetailsPrint listonly
 
 File /r "${EMULATORS_BASE}\applewin"
 File /r /x "${EMULATORS_BASE}\cemu\settings.xml" "${EMULATORS_BASE}\cemu" 
 File /r "${EMULATORS_BASE}\citra"
 File /r /x "${EMULATORS_BASE}\cxbx-reloaded\settings.ini" "${EMULATORS_BASE}\cxbx-reloaded" 
 File /r "${EMULATORS_BASE}\daphne"
 File /r /x "${EMULATORS_BASE}\demul\Demul.ini" "${EMULATORS_BASE}\demul" 
 File /r /x "${EMULATORS_BASE}\demul-old\Demul.ini" "${EMULATORS_BASE}\demul-old"
 File /r  /x "${EMULATORS_BASE}\dolphin-emu\Dolphin.ini" "${EMULATORS_BASE}\dolphin-emu"
 File /r /x "${EMULATORS_BASE}\dolphin-triforce\Dolphin.ini" "${EMULATORS_BASE}\dolphin-triforce" 
 File /r "${EMULATORS_BASE}\dosbox"
 File /r /x "${EMULATORS_BASE}\duckstation\settings.ini" "${EMULATORS_BASE}\duckstation" 
 File /r "${EMULATORS_BASE}\fpinball"
 File /r /x "${EMULATORS_BASE}\kega-fusion\Fusion.ini" "${EMULATORS_BASE}\kega-fusion" 
 File /r /x "${EMULATORS_BASE}\kronos\kronos.ini" "${EMULATORS_BASE}\kronos" 
 File /r /x "${EMULATORS_BASE}\m2emulator\Emulator.ini" "${EMULATORS_BASE}\m2emulator" 
 File /r "${EMULATORS_BASE}\mednafen"
 File /r /x "${EMULATORS_BASE}\mesen\settings.xml" "${EMULATORS_BASE}\mesen" 
 File /r /x "${EMULATORS_BASE}\mesen-s\settings.xml" "${EMULATORS_BASE}\mesen-s" 
 File /r /x "${EMULATORS_BASE}\mgba\config.ini" "${EMULATORS_BASE}\mgba" 
 File /r "${EMULATORS_BASE}\openbor"
 File /r /x "${EMULATORS_BASE}\oricutron\oricutron.cfg" "${EMULATORS_BASE}\oricutron" 
 File /r /x "${EMULATORS_BASE}\pcsx2\inis\PCSX2_ui.ini" "${EMULATORS_BASE}\pcsx2" 
 File /r /x "${EMULATORS_BASE}\ppsspp\memstick\PSP\SYSTEM\ppsspp.ini" "${EMULATORS_BASE}\ppsspp" 
 File /r /x "${EMULATORS_BASE}\project64\Config\Project64.cfg" "${EMULATORS_BASE}\project64" 
 File /r /x "${EMULATORS_BASE}\raine\config\raine32_sdl.cfg" "${EMULATORS_BASE}\raine" 
 File /r /x "${EMULATORS_BASE}\redream\redream.cfg" "${EMULATORS_BASE}\redream" 
 File /r "${EMULATORS_BASE}\rpcs3"
 File /r "${EMULATORS_BASE}\simcoupe"
 File /r /x "${EMULATORS_BASE}\snes9x\snes9x.conf" "${EMULATORS_BASE}\snes9x" 
 File /r "${EMULATORS_BASE}\solarus"
 File /r /x "${EMULATORS_BASE}\supermodel\Supermodel.ini" "${EMULATORS_BASE}\supermodel" 
 File /r "${EMULATORS_BASE}\vpinball"
 File /r /x "${EMULATORS_BASE}\xenia-canary\xenia-canary.config.toml" "${EMULATORS_BASE}\xenia-canary" 
 File /r "${EMULATORS_BASE}\yuzu"

SectionEnd

Section /o "Decorations" SectionDecorations
SectionInstType ${SEC01} ${SEC02}

 SetOutPath "$INSTDIR"
 SetOverwrite ifnewer
 
 SetDetailsPrint textonly
	DetailPrint "Copying decorations files..."
 SetDetailsPrint listonly
 
 File /r /x "${DECORATIONS_BASE}\.git\*.*" "${DECORATIONS_BASE}"
 
SectionEnd

SectionGroupEnd

;Section "DirectX Runtime" SEC02
;   DetailPrint "Running DirectX runtime setup..."
;   ExecWait '"$TEMP\dxredist\DXSETUP.exe" /silent'
;   DetailPrint "Finished DirectX runtime setup"
;SectionEnd

;Section "Visual C++ 2015 Redistributable" SEC03
;   DetailPrint "Running Visual C++ 2015 Redistributable setup..."
;   ExecWait '"$TEMP\vcredist\vc_redist.x64.exe" /install /quiet /norestart'
;   DetailPrint "Finished Visual C++ 2015 Redistributable setup"
;SectionEnd

Section /o "-PostInstallTasks" !Required
SectionInstType ${SEC01} ${SEC02}

 SectionIn RO
 
  SetDetailsPrint textonly
	DetailPrint "Applying settings..."
 SetDetailsPrint listonly

 ifFileExists "$INSTDIR\retrobat.exe" 0 +4

 ExecWait "$INSTDIR\retrobat.exe /NOF #GetConfigFiles"
 ExecWait "$INSTDIR\retrobat.exe /NOF #SetEmulationStationSettings"
 ExecWait "$INSTDIR\retrobat.exe /NOF #SetEmulatorsSettings"
 SetDetailsPrint textonly

 SetDetailsPrint textonly
	DetailPrint "Cleaning download folder"
 SetDetailsPrint listonly

 Delete "${DOWNLOAD_DIR}\*.7z"
 Delete "${DOWNLOAD_DIR}\*.zip"
 Delete "${DOWNLOAD_DIR}\*.*"
	
SectionEnd

!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
!insertmacro MUI_DESCRIPTION_TEXT ${SectionDecorations} "Install bezels selection for RetroArch."
!insertmacro MUI_DESCRIPTION_TEXT ${SectionES} "Install EmulationStation build for Windows."
!insertmacro MUI_DESCRIPTION_TEXT ${SectionRetroArch} "Install RetroArch and Libretro cores."
!insertmacro MUI_DESCRIPTION_TEXT ${SectionEmulators} "Install compatible standalone emulators."
;!insertmacro MUI_DESCRIPTION_TEXT ${SectionRetroArch} "RetroArch v${RETROARCH_VERSION}."
!insertmacro MUI_DESCRIPTION_TEXT ${SectionRetroBat} "Install main softwares and needed configuration files."
!insertmacro MUI_FUNCTION_DESCRIPTION_END

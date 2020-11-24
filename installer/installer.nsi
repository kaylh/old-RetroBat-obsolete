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

 File "${EMULATIONSTATION_BASE}\.emulationstation\es_features.cfg"
 File "${EMULATIONSTATION_BASE}\.emulationstation\es_padtokey.cfg"
 File "${EMULATIONSTATION_BASE}\.emulationstation\es_systems.cfg"
 File "${EMULATIONSTATION_BASE}\.emulationstation\es_settings.cfg"
 
 SetOverwrite off
 
 File "${EMULATIONSTATION_BASE}\.emulationstation\es_input.cfg"

 SetOutPath "${EMULATIONSTATION_DIR}\.emulationstation\themes"
 SetOverwrite ifnewer

 RMDir /r "${EMULATIONSTATION_DIR}\.emulationstation\themes\es-theme-carbon"
 File /r "${EMULATIONSTATION_BASE}\.emulationstation\themes\es-theme-carbon"

 SetOutPath "${EMULATIONSTATION_DIR}\.emulationstation\video"
 SetOverwrite ifnewer

 File /nonfatal "${EMULATIONSTATION_BASE}\.emulationstation\video\*.mp4"
 File /nonfatal "${EMULATIONSTATION_BASE}\.emulationstation\video\*.m4v"

 
SectionEnd

Section /o "Emulators" SectionEmulators
SectionInstType ${SEC01} ${SEC02}

 SetOutPath "${EMULATORS_DIR}"
 SetOverwrite ifnewer
 
 SetDetailsPrint textonly
	DetailPrint "Copying emulators files..."
 SetDetailsPrint listonly
 
 File /r "${EMULATORS_BASE}\retroarch"
 
SectionEnd

Section /o "Decorations" SectionDecorations
SectionInstType ${SEC01} ${SEC02}

 SetOutPath "$INSTDIR"
 SetOverwrite ifnewer
 
 SetDetailsPrint textonly
	DetailPrint "Copying decorations files..."
 SetDetailsPrint listonly
 
 File /r "${DECORATIONS_BASE}"
 
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
	DetailPrint "Configure settings..."
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
!insertmacro MUI_DESCRIPTION_TEXT ${SectionDecorations} "Bezels selection for RetroArch."
!insertmacro MUI_DESCRIPTION_TEXT ${SectionES} "EmulationStation build for Windows."
!insertmacro MUI_DESCRIPTION_TEXT ${SectionEmulators} "Compatible emulators."
;!insertmacro MUI_DESCRIPTION_TEXT ${SectionRetroArch} "RetroArch v${RETROARCH_VERSION}."
!insertmacro MUI_DESCRIPTION_TEXT ${SectionRetroBat} "Main softwares and needed configuration files."
!insertmacro MUI_FUNCTION_DESCRIPTION_END

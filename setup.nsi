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
!define VERSION "${PRODUCT_VERSION}"
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
OutFile "${FILENAME}-v${RELEASE_VERSION}-setup.exe"
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

Function CreateVersionFile
 FileOpen $0 "$INSTDIR\system\version.info" w
 FileWrite $0 "${VERSION}-${TIMESTAMP}"
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

Function CreateDesktopShortCut
 CreateShortCut "$DESKTOP\RetroBat.lnk" "$INSTDIR\retrobat.exe"
FunctionEnd

;Installer Sections     
Section "install"
 
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
  
  Call CreateVersionFile
  
SectionEnd
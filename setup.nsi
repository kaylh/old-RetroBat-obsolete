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

!define SETUP_VERSION "5.1.0.0"

VIAddVersionKey "ProductName" "${PRODUCT}"
VIAddVersionKey "CompanyName" "${PRODUCT}"
VIAddVersionKey "FileVersion" "${SETUP_VERSION}"
VIAddVersionKey "LegalCopyright" "RetroBat Team"
VIAddVersionKey "FileDescription" "This program extracts and copies all major components of RetroBat to the chosen destination."

VIProductVersion "${SETUP_VERSION}"
VIFileVersion "${SETUP_VERSION}"

!include "MUI2.nsh"
!include "FileFunc.nsh"
!include "LogicLib.nsh"

Name "${PRODUCT}"
OutFile "${FILENAME}-v${VERSION}-setup.exe"
InstallDir "C:\${BASE_TARGET}\"
ShowInstDetails "hide"
BrandingText "${PRODUCT} ${VERSION} (c) ${PRODUCT_PUBLISHER}"
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

!define MUI_LANGDLL_REGISTRY_VALUENAME "NSIS:Language"

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "license.txt"
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_LANGUAGE "Afrikaans"
!insertmacro MUI_LANGUAGE "Albanian"
!insertmacro MUI_LANGUAGE "Arabic"
!insertmacro MUI_LANGUAGE "Basque"
!insertmacro MUI_LANGUAGE "Belarusian"
!insertmacro MUI_LANGUAGE "Bosnian"
!insertmacro MUI_LANGUAGE "Breton"
!insertmacro MUI_LANGUAGE "Bulgarian"
!insertmacro MUI_LANGUAGE "Catalan"
!insertmacro MUI_LANGUAGE "Croatian"
!insertmacro MUI_LANGUAGE "Czech"
!insertmacro MUI_LANGUAGE "Danish"
!insertmacro MUI_LANGUAGE "Dutch"
!insertmacro MUI_LANGUAGE "English"
!insertmacro MUI_LANGUAGE "Estonian"
!insertmacro MUI_LANGUAGE "Farsi"
!insertmacro MUI_LANGUAGE "Finnish"
!insertmacro MUI_LANGUAGE "French"
!insertmacro MUI_LANGUAGE "Galician"
!insertmacro MUI_LANGUAGE "German"
!insertmacro MUI_LANGUAGE "Greek"
!insertmacro MUI_LANGUAGE "Hebrew"
!insertmacro MUI_LANGUAGE "Hungarian"
!insertmacro MUI_LANGUAGE "Icelandic"
!insertmacro MUI_LANGUAGE "Indonesian"
!insertmacro MUI_LANGUAGE "Irish"
!insertmacro MUI_LANGUAGE "Italian"
!insertmacro MUI_LANGUAGE "Japanese"
!insertmacro MUI_LANGUAGE "Korean"
!insertmacro MUI_LANGUAGE "Kurdish"
!insertmacro MUI_LANGUAGE "Latvian"
!insertmacro MUI_LANGUAGE "Lithuanian"
!insertmacro MUI_LANGUAGE "Luxembourgish"
!insertmacro MUI_LANGUAGE "Macedonian"
!insertmacro MUI_LANGUAGE "Malay"
!insertmacro MUI_LANGUAGE "Mongolian"
!insertmacro MUI_LANGUAGE "Norwegian"
!insertmacro MUI_LANGUAGE "NorwegianNynorsk"
!insertmacro MUI_LANGUAGE "Polish"
!insertmacro MUI_LANGUAGE "Portuguese"
!insertmacro MUI_LANGUAGE "PortugueseBR"
!insertmacro MUI_LANGUAGE "Romanian"
!insertmacro MUI_LANGUAGE "Russian"
!insertmacro MUI_LANGUAGE "Serbian"
!insertmacro MUI_LANGUAGE "SerbianLatin"
!insertmacro MUI_LANGUAGE "SimpChinese"
!insertmacro MUI_LANGUAGE "Slovak"
!insertmacro MUI_LANGUAGE "Slovenian"
!insertmacro MUI_LANGUAGE "Spanish"
!insertmacro MUI_LANGUAGE "SpanishInternational"
!insertmacro MUI_LANGUAGE "Swedish"
!insertmacro MUI_LANGUAGE "Thai"
!insertmacro MUI_LANGUAGE "TradChinese"
!insertmacro MUI_LANGUAGE "Turkish"
!insertmacro MUI_LANGUAGE "Ukrainian"
!insertmacro MUI_LANGUAGE "Uzbek"
!insertmacro MUI_LANGUAGE "Welsh"
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

Function .onInit
  !insertmacro MUI_LANGDLL_DISPLAY
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
  SetOutPath "$INSTDIR"
  File ${BASE_SOURCE}\${FILENAME}.exe
  File ${BASE_SOURCE}\${FILENAME}.dat
  File ${BASE_SOURCE}\readme.txt
  File ${BASE_SOURCE}\license.txt
  File /r /x ${BASE_SOURCE}\emulationstation\.emulationstation\es_settings.cfg /x ${BASE_SOURCE}\emulationstation\.emulationstation\es_input.cfg ${BASE_SOURCE}\*.*
  
  SetOverwrite off
  SetOutPath "$INSTDIR" 
  File /nonfatal ${BASE_SOURCE}\${FILENAME}.ini

  SetOverwrite off	
  SetOutPath "$INSTDIR\emulationstation\.emulationstation"  
  File ${BASE_SOURCE}\emulationstation\.emulationstation\es_settings.cfg
  File ${BASE_SOURCE}\emulationstation\.emulationstation\es_input.cfg

;  Call CreateVersionFile
  
SectionEnd
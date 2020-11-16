/*
********************************

  RetroBat Setup NSIS Script

********************************
*/

SetCompressor lzma

!include "MUI2.nsh"
!include "FileFunc.nsh"
!include "LogicLib.nsh"

!define PRODUCT "RetroBat"
!define PRODUCT_VERSION "4.0"
!define VERSION "${PRODUCT_VERSION}"
!define /date TIMESTAMP "%Y%m%d-%H%M%S"
;!define RETROARCH_VERSION "1.9.0"
;!define OS_ARCHITECTURE "x86_64"
!define PRODUCT_PUBLISHER "RetroBat Team"
!define PRODUCT_WEB_SITE "https://www.retrobat.ovh/"

!define BASE_DIR ".."
!define BASE_INSTALL_DIR "C:\$(^Name)\"
!define EMULATIONSTATION_DIR "$INSTDIR\emulationstation"
!define EMULATIONSTATION_BASE "${BASE_DIR}\emulationstation"
!define EMULATORS_DIR "$INSTDIR\emulators"
!define EMULATORS_BASE "${BASE_DIR}\emulators"
;!define BASE_INSTALL_DIR "$EXEDIR"
!define DOWNLOAD_DIR "$INSTDIR\system\download"

Unicode true

Name "${PRODUCT}"
OutFile "retrobat-v${VERSION}-${TIMESTAMP}-installer.exe"
;OutFile "setup.exe"
InstallDir "${BASE_INSTALL_DIR}"
RequestExecutionLevel user
ShowInstDetails "nevershow"
;BrandingText "Copyright (c) 2020 ${PRODUCT_PUBLISHER}"
BrandingText "${PRODUCT} v${VERSION}"
SpaceTexts none

;!define MUI_ABORTWARNING
!define MUI_ABORTWARNING_TEXT "Are you sure you wish to abort installation?"

;Var PKGNAME
;Var LRCORE
Var CompletedText
CompletedText $CompletedText

;!define MUI_BGCOLOR "1C4E75"
!define MUI_COMPONENTSPAGE_NODESC
;!define MUI_DIRECTORYPAGE_BGCOLOR "1C4E75"
;!define MUI_DIRECTORYPAGE_TEXTCOLOR "FFFFFF"
!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_BITMAP "..\system\resources\retrobat_header.bmp"
!define MUI_HEADERIMAGE_BITMAP_STRETCH "FitControl"
!define MUI_HEADER_TRANSPARENT_TEXT
!define MUI_ICON "..\system\resources\retrobat-icon-white.ico"
!define MUI_TEXTCOLOR "FFFFFF"
!define MUI_WELCOMEFINISHPAGE_BITMAP "..\system\resources\retrobat_wizard.bmp"

!define MUI_COMPONENTSPAGE_TEXT_TOP "Choose the type of installation. All the types will install all the components needed, there are three different configuration profiles for EmulationStation and RetroArch."
!define MUI_COMPONENTSPAGE_TEXT_COMPLIST " "
  
!define MUI_FINISHPAGE_SHOWREADME
!define MUI_FINISHPAGE_SHOWREADME_TEXT "Create Desktop Shortcut"
!define MUI_FINISHPAGE_SHOWREADME_FUNCTION CreateDesktopShortCut
;!define MUI_FINISHPAGE_SHOWREADME_NOTCHECKED
 
!define MUI_FINISHPAGE_LINK "Visit official RetroBat website: www.retrobat.ovh"
!define MUI_FINISHPAGE_LINK_LOCATION "https://www.retrobat.ovh/"

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "..\license.txt"
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_DIRECTORY

;!define MUI_FINISHPAGE_NOAUTOCLOSE
!define MUI_PAGE_CUSTOMFUNCTION_PRE InstFilesPre
!define MUI_PAGE_CUSTOMFUNCTION_SHOW InstFilesShow
!define MUI_PAGE_CUSTOMFUNCTION_LEAVE InstFilesLeave
Var MUI_HeaderText
Var MUI_HeaderSubText
!define MUI_INSTFILESPAGE_FINISHHEADER_TEXT "$MUI_HeaderText"
!define MUI_INSTFILESPAGE_FINISHHEADER_SUBTEXT "$MUI_HeaderSubText"

!insertmacro MUI_PAGE_INSTFILES
;!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_FINISH

Function StrStrip
 Exch $R0 #string
 Exch
 Exch $R1 #in string
 Push $R2
 Push $R3
 Push $R4
 Push $R5
 StrLen $R5 $R0
 StrCpy $R2 -1
 IntOp $R2 $R2 + 1
 StrCpy $R3 $R1 $R5 $R2
 StrCmp $R3 "" +9
 StrCmp $R3 $R0 0 -3
 StrCpy $R3 $R1 $R2
 IntOp $R2 $R2 + $R5
 StrCpy $R4 $R1 "" $R2
 StrCpy $R1 $R3$R4
 IntOp $R2 $R2 - $R5
 IntOp $R2 $R2 - 1
 Goto -10
 StrCpy $R0 $R1
 Pop $R5
 Pop $R4
 Pop $R3
 Pop $R2
 Pop $R1
 Exch $R0
FunctionEnd

!macro StrStrip Str InStr OutVar

Push '${InStr}'
Push '${Str}'
Call StrStrip
Pop '${OutVar}'

!macroend

!define StrStrip '!insertmacro StrStrip'

Function CreateVersionFile
 FileOpen $4 "$INSTDIR\system\version.info" w
 FileWrite $4 "${VERSION}-${TIMESTAMP}"
 FileClose $4
FunctionEnd

Var CurrentPage
Var UserIsMakingAbortDecision
Var UserAborted
Var SectionAborted

Function PauseIfUserIsMakingAbortDecision
 ${DoWhile} $UserIsMakingAbortDecision == "yes"
 Sleep 500
 ${Loop}
FunctionEnd

!define PauseIfUserIsMakingAbortDecision `Call PauseIfUserIsMakingAbortDecision`

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

!macro CheckUserAborted
 ${PauseIfUserIsMakingAbortDecision}
 ${If} $UserAborted == "yes"
 goto _userabort_aborted
 ${EndIf}
!macroend

!define CheckUserAborted `!insertmacro CheckUserAborted`

!macro EndUserAborted
 ${CheckUserAborted}
 goto _useraborted_end
 _userabort_aborted:
 ${If} $SectionAborted == ""
 StrCpy $SectionAborted "${__SECTION__}"
 DetailPrint "${__SECTION__} installation interrupted."
 ${ElseIf} $SectionAborted != "${__SECTION__}"
 DetailPrint "  ${__SECTION__} installation skipped."
 ${EndIf}
 _useraborted_end:
!macroend

!define EndUserAborted `!insertmacro EndUserAborted`

Function InstFilesPre
 StrCpy $CurrentPage "InstFiles"
 StrCpy $UserAborted "no"
FunctionEnd

Function InstFilesShow
 GetDlgItem $0 $HWNDPARENT 2
 EnableWindow $0 1
FunctionEnd

InstType /COMPONENTSONLYONCUSTOM
InstType "Standard installation" SEC01
InstType "Batocera USB installation" SEC02
InstType "Update existing installation" SEC03
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
 
 Delete "$INSTDIR\retrobat.exe"
 Delete "$INSTDIR\retrobat.ini"
 Delete "$INSTDIR\license.txt"
 Delete "$INSTDIR\*.dll"
 RMDir /r "$INSTDIR\system"
 ${CheckUserAborted}
 
 File "${BASE_DIR}\retrobat.exe"
 File "${BASE_DIR}\retrobat.ini"
 File "${BASE_DIR}\license.txt"
; File "${BASE_DIR}\*.dll" 
 File /r "${BASE_DIR}\system"
 ${CheckUserAborted}
 
 StrCpy $0 "$INSTDIR"
 StrCpy $0 $0 3
 ${StrStrip} "$0" "$INSTDIR" $R0

 Call CreateVersionFile
 ${CheckUserAborted}

 SetDetailsPrint textonly
	DetailPrint "Creating RetroBat folders"
 SetDetailsPrint none

 ifFileExists "$INSTDIR\retrobat.exe" 0 +3
 ${CheckUserAborted}
 ExecWait "$INSTDIR\retrobat.exe /NOF #MakeTree"

 ifFileExists "$INSTDIR\system\install.done" 0 +3
 ${CheckUserAborted}
 Delete "$INSTDIR\system\install.done"
 ${EndUserAborted}

;  SetOutPath "$TEMP"
;  SetOverwrite on
;  File /r "dxredist"
;  File /r "vcredist"
SectionEnd

Section /o "EmulationStation" SectionES
SectionInstType ${SEC01} ${SEC02}

 SetOutPath "${EMULATIONSTATION_DIR}"
 SetOverwrite ifnewer
 
 Delete "${EMULATIONSTATION_DIR}\*.exe"
 Delete "${EMULATIONSTATION_DIR}\*.log"
 Delete "${EMULATIONSTATION_DIR}\*.dll"
 Delete "${EMULATIONSTATION_DIR}\*.old"
 Delete "${EMULATIONSTATION_DIR}\*.lib"
 Delete "${EMULATIONSTATION_DIR}\*.info"
 Delete "${EMULATIONSTATION_DIR}\*.cfg"
 Delete "${EMULATIONSTATION_DIR}\.emulationstation\es_features.cfg"
 Delete "${EMULATIONSTATION_DIR}\.emulationstation\es_padtokey.cfg"
 Delete "${EMULATIONSTATION_DIR}\.emulationstation\es_systems.cfg"
 Delete "${EMULATIONSTATION_DIR}\.emulationstation\es_log.txt"
 Delete "${EMULATIONSTATION_DIR}\.emulationstation\*.bak"
 RMDir /r "${EMULATIONSTATION_DIR}\plugins"
 RMDir /r "${EMULATIONSTATION_DIR}\resources"
 RMDir /r "${EMULATIONSTATION_DIR}\.emulationstation\themes\es-theme-carbon"
 
 File "${EMULATIONSTATION_BASE}\*.exe"
 File "${EMULATIONSTATION_BASE}\*.dll"
 File "${EMULATIONSTATION_BASE}\*.lib"
 File "${EMULATIONSTATION_BASE}\*.info"
 File "${EMULATIONSTATION_BASE}\*.cfg"
 File "${EMULATIONSTATION_BASE}\.emulationstation\es_features.cfg"
 File "${EMULATIONSTATION_BASE}\.emulationstation\es_padtokey.cfg"
 File "${EMULATIONSTATION_BASE}\.emulationstation\es_systems.cfg"
 File /r "${EMULATIONSTATION_BASE}\plugins"
 File /r "${EMULATIONSTATION_BASE}\resources"
 File /r "${EMULATIONSTATION_BASE}\.emulationstation\themes\es-theme-carbon"
 
SectionEnd

Section /o "RetroArch" SectionRetroArch
SectionInstType ${SEC01} ${SEC02}

 SetOutPath "${EMULATORS_DIR}\retroarch"
 SetOverwrite ifnewer
 
 RMDir /r "${EMULATORS_DIR}\retroarch"
 
 File /r "${EMULATORS_BASE}\retroarch"
 
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
	DetailPrint "Cleaning download folder"
 SetDetailsPrint none

 Delete "${DOWNLOAD_DIR}\*.7z"
 Delete "${DOWNLOAD_DIR}\*.zip"
	
SectionEnd

Section -"Post"

 ${If} $UserAborted == "yes"
	StrCpy $CompletedText "Installation aborted."
	StrCpy $MUI_HeaderText "Installation Failed"
    StrCpy $MUI_HeaderSubText "Setup was aborted."
 ${Else}
    StrCpy $CompletedText "Completed"
    StrCpy $MUI_HeaderText "Installation Complete"
    StrCpy $MUI_HeaderSubText "Setup was completed successfully."
 ${EndIf}

SectionEnd

!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
!insertmacro MUI_DESCRIPTION_TEXT ${SectionES} "Batocera EmulationStation build for Windows."
!insertmacro MUI_DESCRIPTION_TEXT ${SectionEmulators} "Selection of standalone emulators."
!insertmacro MUI_DESCRIPTION_TEXT ${SectionRetroArch} "RetroArch v${RETROARCH_VERSION} custom build."
!insertmacro MUI_DESCRIPTION_TEXT ${SectionRetroBat} "Main softwares and configuration files needed."
!insertmacro MUI_FUNCTION_DESCRIPTION_END

Function InstFilesLeave
 StrCpy $CurrentPage ""
FunctionEnd

!define MUI_CUSTOMFUNCTION_ABORT onUserAbort

Function onUserAbort
  StrCpy $UserIsMakingAbortDecision "yes"
  ${If} ${Cmd} `MessageBox MB_YESNO|MB_DEFBUTTON2 "${MUI_ABORTWARNING_TEXT}" IDYES`
    ${If} $CurrentPage == "InstFiles"
      StrCpy $UserAborted "yes"
      MessageBox MB_OK "Your RetroBat's installation may be incomplete."
      StrCpy $UserIsMakingAbortDecision "no"
      Abort
    ${Else}
;      MessageBox MB_OK "See you next time."
      StrCpy $UserIsMakingAbortDecision "no"
    ${EndIf}
  ${Else}
    StrCpy $UserIsMakingAbortDecision "no"
    Abort
  ${EndIf}
FunctionEnd

!insertmacro MUI_LANGUAGE "English"
/*
********************************

  RetroBat Setup NSIS Script

********************************
*/

  !include "MUI2.nsh"
  !include "FileFunc.nsh"
  !include "LogicLib.nsh"

  !define PRODUCT "RetroBat"
  !define PRODUCT_VERSION "3.10"
  !define VERSION "${PRODUCT_VERSION}"
  !define RETROARCH_VERSION "1.8.9"
  !define OS_ARCHITECTURE "x86_64"
  !define PRODUCT_PUBLISHER "RetroBat Team"
  !define PRODUCT_WEB_SITE "https://www.retrobat.ovh/"

  !define BASE_DIR "..\RetroBat"
; !define BASE_INSTALL_DIR "C:\$(^Name)"
  !define BASE_INSTALL_DIR "$EXEDIR"
  !define DOWNLOAD_DIR "$INSTDIR\system\download"

  Unicode true

  Name "${PRODUCT}"
;  OutFile "setup-retrobat-v${VERSION}.exe"
  OutFile "setup.exe"
  InstallDir "${BASE_INSTALL_DIR}"
  RequestExecutionLevel user
  ShowInstDetails "nevershow"
  BrandingText "Copyright (c) 2020 ${PRODUCT_PUBLISHER}"
  SpaceTexts none

;  !define MUI_ABORTWARNING
  !define MUI_ABORTWARNING_TEXT "Are you sure you wish to abort installation?"

  Var PKGNAME
  Var LRCORE
  Var CompletedText
  CompletedText $CompletedText

;  !define MUI_BGCOLOR "1C4E75"
  !define MUI_COMPONENTSPAGE_NODESC
;  !define MUI_DIRECTORYPAGE_BGCOLOR "1C4E75"
;  !define MUI_DIRECTORYPAGE_TEXTCOLOR "FFFFFF"
  !define MUI_HEADERIMAGE
  !define MUI_HEADERIMAGE_BITMAP ".\system\resources\header.bmp"
  !define MUI_HEADERIMAGE_BITMAP_STRETCH "FitControl"
  !define MUI_HEADER_TRANSPARENT_TEXT
  !define MUI_ICON ".\system\resources\retrobat-icon-white.ico"
;  !define MUI_TEXTCOLOR "FFFFFF"
  !define MUI_WELCOMEFINISHPAGE_BITMAP ".\system\resources\wizard.bmp"

  !define MUI_COMPONENTSPAGE_TEXT_TOP "Choose the type of installation. All the types will install all the components needed, there are three different configuration profiles for EmulationStation and RetroArch."
  !define MUI_COMPONENTSPAGE_TEXT_COMPLIST " "
  
  !define MUI_FINISHPAGE_SHOWREADME
  !define MUI_FINISHPAGE_SHOWREADME_TEXT "Create Desktop Shortcut"
  !define MUI_FINISHPAGE_SHOWREADME_FUNCTION CreateDesktopShortCut
;  !define MUI_FINISHPAGE_SHOWREADME_NOTCHECKED
 
  !define MUI_FINISHPAGE_LINK "Visit official RetroBat website: www.retrobat.ovh"
  !define MUI_FINISHPAGE_LINK_LOCATION "https://www.retrobat.ovh/"

  !insertmacro MUI_PAGE_WELCOME
  !insertmacro MUI_PAGE_LICENSE ".\licence.txt"
  !insertmacro MUI_PAGE_COMPONENTS
  !insertmacro MUI_PAGE_DIRECTORY

;  !define MUI_FINISHPAGE_NOAUTOCLOSE
  !define MUI_PAGE_CUSTOMFUNCTION_PRE InstFilesPre
  !define MUI_PAGE_CUSTOMFUNCTION_SHOW InstFilesShow
  !define MUI_PAGE_CUSTOMFUNCTION_LEAVE InstFilesLeave
  Var MUI_HeaderText
  Var MUI_HeaderSubText
  !define MUI_INSTFILESPAGE_FINISHHEADER_TEXT "$MUI_HeaderText"
  !define MUI_INSTFILESPAGE_FINISHHEADER_SUBTEXT "$MUI_HeaderSubText"

  !insertmacro MUI_PAGE_INSTFILES

;  !insertmacro MUI_PAGE_WELCOME
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

Function SetInfoDirs

  FileOpen $4 "$INSTDIR\system\setup.info" w
  FileWrite $4 "Name=RetroBat"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "Version=${VERSION}"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "setup_dir=\$R0"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "system_dir=\$R0\system"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "scripts_dir=\$R0\system\scripts"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "config_dir=\$R0\configs"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "templates_dir=\$R0\system\templates"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "rbmenu_dir=\$R0\system\configmenu"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "temp_dir=\$R0\system\downloads"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "emulators_dir=\$R0\emulators"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "retroarch_dir=\$R0\emulators\retroarch"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "retroarch_config_dir=\$R0\emulators\retroarch\config"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "es_dir=\$R0\emulationstation"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "es_config_dir=\$R0\emulationstation\.emulationstation"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "saves_dir=\$R0\saves"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "shots_config_dir=\$R0\screenshots"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "medias_dir=\$R0\medias"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "games_dir=\$R0\roms"
  FileClose $4

  FileOpen $4 "$INSTDIR\system\version.info" w
  FileWrite $4 "${VERSION}"
  FileClose $4

  FileOpen $4 "$INSTDIR\system\install.done" w
  FileWrite $4 "installed"
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
InstType "Full integration (RetroArch ANGLE)" IT_REQUIRED_03
InstType "Partial integration (RetroArch OPENGL)" IT_REQUIRED_02
InstType "Batocera USB" IT_REQUIRED_04
;InstType "Legacy ES systems list (No launcher commands)" IT_REQUIRED_01


Function .onInit

 SetCurInstType 1

FunctionEnd

Function CreateDesktopShortCut
 
CreateShortCut "$DESKTOP\RetroBat.lnk" "$INSTDIR\retrobat.exe" "" "$INSTDIR\system\resources\retrobat-icon-purple.ico"
 
FunctionEnd

SectionGroup "-RetroBat"

Section /o "Main Files" SectionRetroBat
SectionInstType ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04}


	SetOutPath "${DOWNLOAD_DIR}"

	ifFileExists "${DOWNLOAD_DIR}\retrobat-v${VERSION}.zip" +3 0
	inetc::get "https://www.retrobat.ovh/repo/v3/retrobat-v${VERSION}.zip" "${DOWNLOAD_DIR}\retrobat-v${VERSION}.zip" /END
	${CheckUserAborted}
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\retrobat-v${VERSION}.zip" "$INSTDIR"
	${CheckUserAborted}
	ifFileExists "${DOWNLOAD_DIR}\bios-base.zip" +3 0
	inetc::get "https://www.retrobat.ovh/repo/v3/bios-base.zip" "${DOWNLOAD_DIR}\bios-base.zip" /END
	${CheckUserAborted}
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\bios-base.zip" "$INSTDIR\bios"
	${CheckUserAborted}
	

StrCpy $0 "$INSTDIR"
StrCpy $0 $0 3
${StrStrip} "$0" "$INSTDIR" $R0

Call SetInfoDirs

	SetOutPath $INSTDIR

	SetDetailsPrint textonly
		DetailPrint "Creating RetroBat folders"
	SetDetailsPrint none

	ifFileExists "$INSTDIR\retrobat.exe" 0 +3
	${CheckUserAborted}
	ExecWait "$INSTDIR\retrobat.exe /NOF #MakeTree"

	SetOutPath $INSTDIR

	ifFileExists "$INSTDIR\system\install.done" 0 +3
	${CheckUserAborted}
	Delete "$INSTDIR\system\install.done"
	${EndUserAborted}

SectionEnd

Section /o "EmulationStation" SectionES
SectionInstType ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04}

	SetOutPath "${DOWNLOAD_DIR}"

	ifFileExists "${DOWNLOAD_DIR}\emulationstation.zip" installES 0
	${CheckUserAborted}
	inetc::get "https://github.com/fabricecaruso/batocera-emulationstation/releases/download/continuous-stable/EmulationStation-Win32.zip" "${DOWNLOAD_DIR}\emulationstation.zip" /END
	installES:
	${CheckUserAborted}
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\emulationstation.zip" "$INSTDIR\emulationstation"

	ifFileExists "${DOWNLOAD_DIR}\batocera-ports.zip" installBP 0
	${CheckUserAborted}
	inetc::get "http://www.retrobat.ovh/repo/v3/batocera-ports.zip" "${DOWNLOAD_DIR}\batocera-ports.zip" /END
	installBP:
	${CheckUserAborted}
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\batocera-ports.zip" "$INSTDIR\emulationstation"

	ifFileExists "${DOWNLOAD_DIR}\retrobat-intro.zip" installIntro 0
	${CheckUserAborted}
	inetc::get "http://www.retrobat.ovh/repo/v3/retrobat-intro.zip" "${DOWNLOAD_DIR}\retrobat-intro.zip" /END
	installIntro:
	${CheckUserAborted}
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\retrobat-intro.zip" "$INSTDIR\emulationstation\.emulationstation\video"

	ifFileExists "${DOWNLOAD_DIR}\es-theme-carbon.zip" installCT 0
	${CheckUserAborted}
	inetc::get "http://www.retrobat.ovh/repo/v3/es-theme-carbon.zip" "${DOWNLOAD_DIR}\es-theme-carbon.zip" /END
	installCT:
	${CheckUserAborted}
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\es-theme-carbon.zip" "$INSTDIR\emulationstation\.emulationstation\themes\es-theme-carbon"
	${EndUserAborted}
	 
SectionEnd

	Section /o "RetroArch" SectionRetroArch
	SectionInstType ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04}

	${CheckUserAborted}
	CreateDirectory "$INSTDIR\emulators\retroarch"
	CreateDirectory "$INSTDIR\emulators\retroarch\assets"
	CreateDirectory "$INSTDIR\emulators\retroarch\autoconfig"
	CreateDirectory "$INSTDIR\emulators\retroarch\database\cursors"
	CreateDirectory "$INSTDIR\emulators\retroarch\database\rdb"
	CreateDirectory "$INSTDIR\emulators\retroarch\info"
	CreateDirectory "$INSTDIR\emulators\retroarch\shaders"
	CreateDirectory "$INSTDIR\decorations"

		SetOutPath "$INSTDIR\emulators\retroarch"
		
		ifFileExists "${DOWNLOAD_DIR}\retroarch-${OS_ARCHITECTURE}.7z" installRA01 0
		${CheckUserAborted}
		inetc::get "http://www.retrobat.ovh/repo/emulators/retroarch-${OS_ARCHITECTURE}.7z" "${DOWNLOAD_DIR}\retroarch-${OS_ARCHITECTURE}.7z" /END
		installRA01:
		${CheckUserAborted}
		Nsis7z::ExtractWithDetails "${DOWNLOAD_DIR}\retroarch-${OS_ARCHITECTURE}.7z" "Extracting %s"

		ifFileExists "${DOWNLOAD_DIR}\retroarch-assets.zip" installRA02 0
		${CheckUserAborted}
		inetc::get "https://buildbot.libretro.com/assets/frontend/assets.zip" "${DOWNLOAD_DIR}\retroarch-assets.zip" /END
		installRA02:
		${CheckUserAborted}
		nsisunz::UnzipToLog "${DOWNLOAD_DIR}\retroarch-assets.zip" "$INSTDIR\emulators\retroarch\assets"

		ifFileExists "${DOWNLOAD_DIR}\retroarch-autoconfig.zip" installRA03 0
		${CheckUserAborted}
		inetc::get "https://buildbot.libretro.com/assets/frontend/autoconfig.zip" "${DOWNLOAD_DIR}\retroarch-autoconfig.zip" /END
		installRA03:
		${CheckUserAborted}
		nsisunz::UnzipToLog "${DOWNLOAD_DIR}\retroarch-autoconfig.zip" "$INSTDIR\emulators\retroarch\autoconfig"

		ifFileExists "${DOWNLOAD_DIR}\retroarch-database-cursors.zip" installRA04 0
		${CheckUserAborted}
		inetc::get "https://buildbot.libretro.com/assets/frontend/database-cursors.zip" "${DOWNLOAD_DIR}\retroarch-database-cursors.zip" /END
		installRA04:
		${CheckUserAborted}
		nsisunz::UnzipToLog "${DOWNLOAD_DIR}\retroarch-database-cursors.zip" "$INSTDIR\emulators\retroarch\database\cursors"

		ifFileExists "${DOWNLOAD_DIR}\retroarch-database-rdb.zip" installRA05 0
		${CheckUserAborted}
		inetc::get "https://buildbot.libretro.com/assets/frontend/database-rdb.zip" "${DOWNLOAD_DIR}\retroarch-database-rdb.zip" /END
		installRA05:
		${CheckUserAborted}
		nsisunz::UnzipToLog "${DOWNLOAD_DIR}\retroarch-database-rdb.zip" "$INSTDIR\emulators\retroarch\database\rdb"

		ifFileExists "${DOWNLOAD_DIR}\retroarch-info.zip" installRA06 0
		${CheckUserAborted}
		inetc::get "https://buildbot.libretro.com/assets/frontend/info.zip" "${DOWNLOAD_DIR}\retroarch-info.zip" /END
		installRA06:
		${CheckUserAborted}
		nsisunz::UnzipToLog "${DOWNLOAD_DIR}\retroarch-info.zip" "$INSTDIR\emulators\retroarch\info"

		ifFileExists "${DOWNLOAD_DIR}\$PKGNAME" installRA07 0
		${CheckUserAborted}
		inetc::get "http://www.retrobat.ovh/repo/v3/shaders.zip" "${DOWNLOAD_DIR}\retroarch-shaders.zip" /END
		installRA07:
		${CheckUserAborted}
		nsisunz::UnzipToLog "${DOWNLOAD_DIR}\retroarch-shaders.zip" "$INSTDIR\emulators\retroarch\shaders"

		ifFileExists "${DOWNLOAD_DIR}\decorations.zip" installRA08 0
		${CheckUserAborted}
		inetc::get "https://github.com/kaylh/RetroArch-Bezels/releases/download/1.0/retroarch-bezels.zip" "${DOWNLOAD_DIR}\decorations.zip" /END
		installRA08:
		${CheckUserAborted}
		nsisunz::UnzipToLog "${DOWNLOAD_DIR}\decorations.zip" "$INSTDIR\decorations"
		${EndUserAborted}

	SectionEnd

Section /o "Libretro Cores Pack" SectionLR
SectionInstType ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04}

	SetOutPath "$INSTDIR\emulators\retroarch\cores"

	StrCpy $LRCORE "2048"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE01 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
LRCORE01:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "81"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE02 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE02:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "atari800"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE03 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE03:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "blastem"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE04 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE04:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "bluemsx"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE05 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE05:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "bsnes"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE06 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE06:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "bsnes_hd_beta"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE07 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE07:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "bsnes_mercury_balanced"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE08 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE08:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "bsnes_mercury_accuracy"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE09 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE09:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "bsnes_mercury_performance"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE10 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE10:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "bsnes2014_accuracy"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE11 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE11:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "bsnes2014_balanced"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE12 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE12:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "bsnes2014_performance"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE13 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE13:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "cap32"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE14 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE14:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "citra_canary"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE15 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE15:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "citra"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE16 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE16:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "craft"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE17 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE17:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "crocods"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE18 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE18:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "desmume"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE19 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE19:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "desmume2015"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE20 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE20:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "dolphin"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE21 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE21:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "dosbox_core"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE22 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE22:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "dosbox_svn_ce"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE23 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE23:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "dosbox_svn"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE24 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE24:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "fbalpha2012_cps1"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE25 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE25:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "fbalpha2012_cps2"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE26 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE26:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "fbalpha2012"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE27 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE27:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "fbalpha2012_neogeo"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE28 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE28:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "fbneo"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE29 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE29:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "fceumm"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE30 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE30:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "ffmpeg"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE31 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE31:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "flycast_gles2"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE32 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE32:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "flycast"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE33 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE33:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "fmsx"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE34 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE34:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "freeintv"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE35 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE35:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "frodo"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE36 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE36:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "fuse"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE37 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE37:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "gambatte"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE38 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE38:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "gearboy"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE39 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE39:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "gearsystem"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE40 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE40:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "genesis_plus_gx"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE41 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE41:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "gpsp"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE42 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE42:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "gw"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE43 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE43:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "handy"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE44 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE44:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "hatari"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE45 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE45:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "higan_sfc_balanced"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE46 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE46:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "higan_sfc"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE47 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE47:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "imageviewer"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE48 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE48:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "kronos"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE49 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE49:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "lutro"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE50 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE50:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "mame2003_plus"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE51 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE51:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "mame2016"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE52 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE52:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "mednafen_gba"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE53 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE53:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "mednafen_lynx"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE54 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE54:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "mednafen_ngp"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE55 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE55:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "mednafen_pce_fast"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE56 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE56:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "mednafen_pce"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE57 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE57:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "mednafen_pcfx"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE58 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE58:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "mednafen_psx_hw"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE59 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE59:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "mednafen_psx"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE60 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE60:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "mednafen_saturn"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE61 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE61:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "mednafen_snes"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE62 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE62:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "mednafen_supergrafx"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE63 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE63:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "mednafen_vb"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE64 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE64:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "mednafen_wswan"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE65 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE65:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "melonds"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE66 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE66:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "mesen"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE67 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE67:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "mesen-s"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE68 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE68:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "mgba"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE69 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE69:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "mrboom"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE70 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE70:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "mupen64plus_next_gles3"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE71 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE71:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "mupen64plus_next"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE72 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE72:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "nekop2"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE73 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE73:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "neocd"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE74 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE74:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "nestopia"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE75 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE75:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "np2kai"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE76 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE76:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "nxengine"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE77 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE77:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "o2em"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE78 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE78:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "opera"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE79 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE79:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "parallel_n64"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE80 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE80:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "pcsx_rearmed"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE81 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE81:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "picodrive"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE82 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE82:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "play"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE83 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE83:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "pokemini"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE84 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE84:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "ppsspp"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE85 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE85:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "prboom"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE86 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE86:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "prosystem"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE87 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE87:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "puae"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE88 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE88:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "px68k"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE89 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE89:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "quasi88"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE90 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE90:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "quicknes"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE91 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE91:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "race"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE92 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE92:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "sameboy"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE93 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE93:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "scummvm"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE94 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE94:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "smsplus"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE95 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE95:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "snes9x"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE96 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE96:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "stella"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE97 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE97:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "stella2014"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE98 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE98:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "tgbdual"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE99 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE99:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "theodore"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE100 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE100:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
/*	StrCpy $LRCORE "tic80"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE00 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE00:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
*/
	StrCpy $LRCORE "vba_next"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE101 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE101:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "vbam"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE102 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE102:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "vecx"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE103 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE103:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "vice_x64"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE104 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE104:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "vice_x128"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE00 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE00:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "vice_xpet"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE105 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE105:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "vice_xplus4"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE106 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE106:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "vice_xvic"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE107 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE107:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "virtualjaguar"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE108 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE108:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "yabasanshiro"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE109 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE109:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "yabause"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" LRCORE110 0
	${CheckUserAborted}
inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	${CheckUserAborted}
LRCORE110:
${CheckUserAborted}
nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	${EndUserAborted}
	
SectionEnd

Section /o "Standalone Emulators Pack" SectionEmulators
SectionInstType ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04}


	SetOutPath "$INSTDIR\emulators\applewin"
	
	StrCpy $PKGNAME "applewin.7z"
	ifFileExists "${DOWNLOAD_DIR}\$PKGNAME" installAppleWin 0
	${CheckUserAborted}
	inetc::get "https://www.retrobat.ovh/repo/emulators/$PKGNAME" "${DOWNLOAD_DIR}\$PKGNAME" /END

	installAppleWin:
	${CheckUserAborted}
Nsis7z::ExtractWithDetails "${DOWNLOAD_DIR}\$PKGNAME" "Extracting %s"
	
	SetOutPath "$INSTDIR\emulators\cemu"
	
	StrCpy $PKGNAME "cemu.7z"
	ifFileExists "${DOWNLOAD_DIR}\$PKGNAME" installCemu 0
	${CheckUserAborted}
	inetc::get "https://www.retrobat.ovh/repo/emulators/$PKGNAME" "${DOWNLOAD_DIR}\$PKGNAME" /END

	installCemu:
	${CheckUserAborted}
Nsis7z::ExtractWithDetails "${DOWNLOAD_DIR}\$PKGNAME" "Extracting %s"
	
	SetOutPath "$INSTDIR\emulators\cxbx-reloaded"
	
	StrCpy $PKGNAME "cxbx-reloaded.7z"
	ifFileExists "${DOWNLOAD_DIR}\$PKGNAME" installCXBX 0
	${CheckUserAborted}
	inetc::get "https://www.retrobat.ovh/repo/emulators/$PKGNAME" "${DOWNLOAD_DIR}\$PKGNAME" /END

	installCXBX:
	${CheckUserAborted}
Nsis7z::ExtractWithDetails "${DOWNLOAD_DIR}\$PKGNAME" "Extracting %s"
	
	SetOutPath "$INSTDIR\emulators\daphne"
	
	StrCpy $PKGNAME "daphne.7z"
	ifFileExists "${DOWNLOAD_DIR}\$PKGNAME" installDaphne 0
	${CheckUserAborted}
	inetc::get "https://www.retrobat.ovh/repo/emulators/$PKGNAME" "${DOWNLOAD_DIR}\$PKGNAME" /END

	installDaphne:
	${CheckUserAborted}
Nsis7z::ExtractWithDetails "${DOWNLOAD_DIR}\$PKGNAME" "Extracting %s"
	
	SetOutPath "$INSTDIR\emulators\demul"
	
	StrCpy $PKGNAME "demul.7z"
	ifFileExists "${DOWNLOAD_DIR}\$PKGNAME" installDemul 0
	${CheckUserAborted}
	inetc::get "https://www.retrobat.ovh/repo/emulators/$PKGNAME" "${DOWNLOAD_DIR}\$PKGNAME" /END

	installDemul:
	${CheckUserAborted}
Nsis7z::ExtractWithDetails "${DOWNLOAD_DIR}\$PKGNAME" "Extracting %s"
	
	SetOutPath "$INSTDIR\emulators\demul-old"
	
	StrCpy $PKGNAME "demul.7z"
	ifFileExists "${DOWNLOAD_DIR}\$PKGNAME" installDemulOld 0
	${CheckUserAborted}
	inetc::get "https://www.retrobat.ovh/repo/emulators/$PKGNAME" "${DOWNLOAD_DIR}\$PKGNAME" /END

	installDemulOld:
	${CheckUserAborted}
Nsis7z::ExtractWithDetails "${DOWNLOAD_DIR}\$PKGNAME" "Extracting %s"
	
	SetOutPath "$INSTDIR\emulators\dolphin-emu"
	
	StrCpy $PKGNAME "dolphin-emu.7z"
	ifFileExists "${DOWNLOAD_DIR}\$PKGNAME" installDolphin 0
	${CheckUserAborted}

	installDolphin:
	${CheckUserAborted}
Nsis7z::ExtractWithDetails "${DOWNLOAD_DIR}\$PKGNAME" "Extracting %s"
	
	SetOutPath "$INSTDIR\emulators\dolphin-triforce"
	
	StrCpy $PKGNAME "dolphin-triforce.7z"
	ifFileExists "${DOWNLOAD_DIR}\$PKGNAME" installDolphinWX 0
	${CheckUserAborted}
	inetc::get "https://www.retrobat.ovh/repo/emulators/$PKGNAME" "${DOWNLOAD_DIR}\$PKGNAME" /END

	installDolphinWX:
	${CheckUserAborted}
Nsis7z::ExtractWithDetails "${DOWNLOAD_DIR}\$PKGNAME" "Extracting %s"
	
	SetOutPath "$INSTDIR\emulators\dosbox"
	
	StrCpy $PKGNAME "dosbox.7z"
	ifFileExists "${DOWNLOAD_DIR}\$PKGNAME" installDOSBox 0
	${CheckUserAborted}
	inetc::get "https://www.retrobat.ovh/repo/emulators/$PKGNAME" "${DOWNLOAD_DIR}\$PKGNAME" /END

	installDOSBox:
	${CheckUserAborted}
Nsis7z::ExtractWithDetails "${DOWNLOAD_DIR}\$PKGNAME" "Extracting %s"
	
	SetOutPath "$INSTDIR\emulators\fpinball"
	
	StrCpy $PKGNAME "fpinball.7z"
	ifFileExists "${DOWNLOAD_DIR}\$PKGNAME" installFpinball 0
	${CheckUserAborted}
	inetc::get "https://www.retrobat.ovh/repo/emulators/$PKGNAME" "${DOWNLOAD_DIR}\$PKGNAME" /END

	installFpinball:
	${CheckUserAborted}
Nsis7z::ExtractWithDetails "${DOWNLOAD_DIR}\$PKGNAME" "Extracting %s"
	
	SetOutPath "$INSTDIR\emulators\m2emulator"
	
	StrCpy $PKGNAME "m2emulator.7z"
	ifFileExists "${DOWNLOAD_DIR}\$PKGNAME" installM2Emu 0
	${CheckUserAborted}
	inetc::get "https://www.retrobat.ovh/repo/emulators/$PKGNAME" "${DOWNLOAD_DIR}\$PKGNAME" /END

	installM2Emu:
	${CheckUserAborted}
Nsis7z::ExtractWithDetails "${DOWNLOAD_DIR}\$PKGNAME" "Extracting %s"
	
	SetOutPath "$INSTDIR\emulators\mednafen"
	
	StrCpy $PKGNAME "mednafen.7z"
	ifFileExists "${DOWNLOAD_DIR}\$PKGNAME" installMednafen 0
	${CheckUserAborted}
	inetc::get "https://www.retrobat.ovh/repo/emulators/$PKGNAME" "${DOWNLOAD_DIR}\$PKGNAME" /END

	installMednafen:
	${CheckUserAborted}
Nsis7z::ExtractWithDetails "${DOWNLOAD_DIR}\$PKGNAME" "Extracting %s"
	
	SetOutPath "$INSTDIR\emulators\mgba"
	
	StrCpy $PKGNAME "mgba.7z"
	ifFileExists "${DOWNLOAD_DIR}\$PKGNAME" installMGBA 0
	${CheckUserAborted}
	inetc::get "https://www.retrobat.ovh/repo/emulators/$PKGNAME" "${DOWNLOAD_DIR}\$PKGNAME" /END

	installMGBA:
	${CheckUserAborted}
Nsis7z::ExtractWithDetails "${DOWNLOAD_DIR}\$PKGNAME" "Extracting %s"
	
	SetOutPath "$INSTDIR\emulators\openbor"
	
	StrCpy $PKGNAME "openbor.7z"
	ifFileExists "${DOWNLOAD_DIR}\$PKGNAME" installOpenbor 0
	${CheckUserAborted}
	inetc::get "https://www.retrobat.ovh/repo/emulators/$PKGNAME" "${DOWNLOAD_DIR}\$PKGNAME" /END

	installOpenbor:
	${CheckUserAborted}
Nsis7z::ExtractWithDetails "${DOWNLOAD_DIR}\$PKGNAME" "Extracting %s"
	
	SetOutPath "$INSTDIR\emulators\pcsx2"
	
	StrCpy $PKGNAME "pcsx2.7z"
	ifFileExists "${DOWNLOAD_DIR}\$PKGNAME" installPcsx2 0
	${CheckUserAborted}
	inetc::get "https://www.retrobat.ovh/repo/emulators/$PKGNAME" "${DOWNLOAD_DIR}\$PKGNAME" /END

	installPcsx2:
	${CheckUserAborted}
Nsis7z::ExtractWithDetails "${DOWNLOAD_DIR}\$PKGNAME" "Extracting %s"
	
	SetOutPath "$INSTDIR\emulators\ppsspp"
	
	StrCpy $PKGNAME "ppsspp.7z"
	ifFileExists "${DOWNLOAD_DIR}\$PKGNAME" installPpsspp 0
	${CheckUserAborted}
	inetc::get "https://www.retrobat.ovh/repo/emulators/$PKGNAME" "${DOWNLOAD_DIR}\$PKGNAME" /END

	installPpsspp:
	${CheckUserAborted}
Nsis7z::ExtractWithDetails "${DOWNLOAD_DIR}\$PKGNAME" "Extracting %s"
	
	SetOutPath "$INSTDIR\emulators\raine"
	
	StrCpy $PKGNAME "raine.7z"
	ifFileExists "${DOWNLOAD_DIR}\$PKGNAME" installRaine 0
	${CheckUserAborted}
	inetc::get "https://www.retrobat.ovh/repo/emulators/$PKGNAME" "${DOWNLOAD_DIR}\$PKGNAME" /END

	installRaine:
	${CheckUserAborted}
Nsis7z::ExtractWithDetails "${DOWNLOAD_DIR}\$PKGNAME" "Extracting %s"
	
	SetOutPath "$INSTDIR\emulators\rpcs3"
	
	StrCpy $PKGNAME "rpcs3.7z"
	ifFileExists "${DOWNLOAD_DIR}\$PKGNAME" installRpcs3 0
	${CheckUserAborted}
	inetc::get "https://www.retrobat.ovh/repo/emulators/$PKGNAME" "${DOWNLOAD_DIR}\$PKGNAME" /END

	installRpcs3:
	${CheckUserAborted}
Nsis7z::ExtractWithDetails "${DOWNLOAD_DIR}\$PKGNAME" "Extracting %s"
	
	SetOutPath "$INSTDIR\emulators\simcoupe"
	
	StrCpy $PKGNAME "simcoupe.7z"
	ifFileExists "${DOWNLOAD_DIR}\$PKGNAME" installSimcoupe 0
	${CheckUserAborted}
	inetc::get "https://www.retrobat.ovh/repo/emulators/$PKGNAME" "${DOWNLOAD_DIR}\$PKGNAME" /END

	installSimcoupe:
	${CheckUserAborted}
Nsis7z::ExtractWithDetails "${DOWNLOAD_DIR}\$PKGNAME" "Extracting %s"
	
	SetOutPath "$INSTDIR\emulators\snes9x"
	
	StrCpy $PKGNAME "snes9x.7z"
	ifFileExists "${DOWNLOAD_DIR}\$PKGNAME" installSnes9x 0
	${CheckUserAborted}
	inetc::get "https://www.retrobat.ovh/repo/emulators/$PKGNAME" "${DOWNLOAD_DIR}\$PKGNAME" /END

	installSnes9x:
	${CheckUserAborted}
Nsis7z::ExtractWithDetails "${DOWNLOAD_DIR}\$PKGNAME" "Extracting %s"
	
	SetOutPath "$INSTDIR\emulators\supermodel"
	
	StrCpy $PKGNAME "supermodel.7z"
	ifFileExists "${DOWNLOAD_DIR}\$PKGNAME" installSupermodel 0
	${CheckUserAborted}
	inetc::get "https://www.retrobat.ovh/repo/emulators/$PKGNAME" "${DOWNLOAD_DIR}\$PKGNAME" /END

	installSupermodel:
	${CheckUserAborted}
Nsis7z::ExtractWithDetails "${DOWNLOAD_DIR}\$PKGNAME" "Extracting %s"
	
	SetOutPath "$INSTDIR\emulators\vpinball"
	
	StrCpy $PKGNAME "vpinball.7z"
	ifFileExists "${DOWNLOAD_DIR}\$PKGNAME" installVpinball 0
	${CheckUserAborted}
	inetc::get "https://www.retrobat.ovh/repo/emulators/$PKGNAME" "${DOWNLOAD_DIR}\$PKGNAME" /END

	installVpinball:
	${CheckUserAborted}
Nsis7z::ExtractWithDetails "${DOWNLOAD_DIR}\$PKGNAME" "Extracting %s"
	
	SetOutPath "$INSTDIR\emulators\xenia-canary"
	
	StrCpy $PKGNAME "xenia-canary.7z"
	ifFileExists "${DOWNLOAD_DIR}\$PKGNAME" installXenia 0
	${CheckUserAborted}
	inetc::get "https://www.retrobat.ovh/repo/emulators/$PKGNAME" "${DOWNLOAD_DIR}\$PKGNAME" /END

	installXenia:
	${CheckUserAborted}
Nsis7z::ExtractWithDetails "${DOWNLOAD_DIR}\$PKGNAME" "Extracting %s"
	${EndUserAborted}

SectionEnd

Section /o "-PostInstallTasks" !Required
SectionInstType ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04}
	
;SectionIn RO

	SetDetailsPrint textonly
		DetailPrint "Cleaning download folder"
	SetDetailsPrint none

;	Delete "${DOWNLOAD_DIR}\*.7z"
;	Delete "${DOWNLOAD_DIR}\*.zip"

SetOutPath $INSTDIR

	SetDetailsPrint textonly
		DetailPrint "Setting up configuration files"
	SetDetailsPrint none

	ifFileExists "$INSTDIR\retrobat.exe" 0 +2
	${CheckUserAborted}
	ExecWait "$INSTDIR\retrobat.exe /NOF #CopyConfig"	
	${EndUserAborted}
	
SetOutPath $INSTDIR
	
SectionEnd

/* Section /o "-ConfigMode1"
SectionInstType ${IT_REQUIRED_01}

	${CheckUserAborted}
  FileOpen $4 "$INSTDIR\retrobat.ini" w
  FileWrite $4 "[RetroBat]"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "ConfigMode=1"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "InputComboMode=1"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "[EmulationStation]"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "InterfaceMode=0"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "Fullscreen=1"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "WindowXSize=1280"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "WindowYSize=720"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "NoExitMenu=0"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "PlayVideoIntro=1"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "VideoLength=6500"
  FileWrite $4 "$\r$\n"
  FileWrite $4 'VideoFile="RetroBat-intro.mp4"'
  FileWrite $4 "$\r$\n"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "[RetroArch]"
  FileWrite $4 "$\r$\n"
  FileWrite $4 'DefaultVideoDriver="glcore"'
  FileClose $4
	${EndUserAborted}
SectionEnd
*/

Section /o "-ConfigMode2"
SectionInstType ${IT_REQUIRED_02}

  ${CheckUserAborted}
  FileOpen $4 "$INSTDIR\retrobat.ini" w
  FileWrite $4 "[RetroBat]"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "ConfigMode=2"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "InputComboMode=1"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "[EmulationStation]"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "InterfaceMode=0"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "Fullscreen=1"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "WindowXSize=1280"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "WindowYSize=720"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "NoExitMenu=0"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "PlayVideoIntro=1"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "VideoLength=6500"
  FileWrite $4 "$\r$\n"
  FileWrite $4 'VideoFile="RetroBat-intro.mp4"'
  FileWrite $4 "$\r$\n"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "[RetroArch]"
  FileWrite $4 "$\r$\n"
  FileWrite $4 'DefaultVideoDriver="gl"'
  FileClose $4
  ${EndUserAborted}
  
SectionEnd

Section /o "-ConfigMode3"
SectionInstType ${IT_REQUIRED_03}
	
  ${CheckUserAborted}
  FileOpen $4 "$INSTDIR\retrobat.ini" w
  FileWrite $4 "[RetroBat]"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "ConfigMode=3"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "InputComboMode=1"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "[EmulationStation]"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "InterfaceMode=0"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "Fullscreen=1"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "WindowXSize=1280"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "WindowYSize=720"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "NoExitMenu=0"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "PlayVideoIntro=1"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "VideoLength=6500"
  FileWrite $4 "$\r$\n"
  FileWrite $4 'VideoFile="RetroBat-intro.mp4"'
  FileWrite $4 "$\r$\n"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "[RetroArch]"
  FileWrite $4 "$\r$\n"
  FileWrite $4 'DefaultVideoDriver="d3d11"'
  FileClose $4
  ${EndUserAborted}
  
SectionEnd

Section /o "-ConfigMode4"
SectionInstType ${IT_REQUIRED_04}
	
  ${CheckUserAborted}
  FileOpen $4 "$INSTDIR\retrobat.ini" w
  FileWrite $4 "[RetroBat]"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "ConfigMode=4"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "InputComboMode=1"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "[EmulationStation]"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "InterfaceMode=0"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "Fullscreen=1"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "WindowXSize=1280"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "WindowYSize=720"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "NoExitMenu=0"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "PlayVideoIntro=0"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "VideoLength=6500"
  FileWrite $4 "$\r$\n"
  FileWrite $4 'VideoFile="RetroBat-intro.mp4"'
  FileWrite $4 "$\r$\n"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "[RetroArch]"
  FileWrite $4 "$\r$\n"
  FileWrite $4 'DefaultVideoDriver="gl"'
  FileClose $4
  ${EndUserAborted}
	
SectionEnd

SectionGroupEnd

SectionGroup "Optional EmulationStation Themes" SectionThemes

			Section /o "Forever"

				${CheckUserAborted}
				SetDetailsPrint textonly
					DetailPrint "Installing Forever Theme"
				SetDetailsPrint none

				StrCpy $PKGNAME "es-theme-forever.zip"
				ifFileExists "${DOWNLOAD_DIR}\$PKGNAME" +4 0
				${CheckUserAborted}
				inetc::get "https://github.com/lehcimcramtrebor/es-theme-forever/archive/master.zip" "${DOWNLOAD_DIR}\$PKGNAME" /END
				${CheckUserAborted}
				nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$PKGNAME" "$INSTDIR\emulationstation\.emulationstation\themes"
				${EndUserAborted}
				
			SectionEnd

			Section /o "NextFull"

				SetDetailsPrint textonly
					DetailPrint "Installing NextFull Theme"
				SetDetailsPrint none

				StrCpy $PKGNAME "es-theme-nextfull.zip"
				ifFileExists "${DOWNLOAD_DIR}\$PKGNAME" +4 0
				${CheckUserAborted}
				inetc::get "https://github.com/kaylh/es-theme-nextfull/archive/master.zip" "${DOWNLOAD_DIR}\$PKGNAME" /END
				${CheckUserAborted}
				nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$PKGNAME" "$INSTDIR\emulationstation\.emulationstation\themes"
				${EndUserAborted}
				
			SectionEnd

			SectionGroup "Retro'Arts"

			Section /o "Retro'Arts UHD 2160p"

				SetDetailsPrint textonly
					DetailPrint "Installing Retro'Arts UHD 2160p Theme"
				SetDetailsPrint none

				StrCpy $PKGNAME "es-theme-retroarts-2160p.zip"
				ifFileExists "${DOWNLOAD_DIR}\$PKGNAME" +4 0
				${CheckUserAborted}
				inetc::get "https://github.com/lehcimcramtrebor/es-theme-retroarts/tree/UHD-2160p" "${DOWNLOAD_DIR}\$PKGNAME" /END
				${CheckUserAborted}
				nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$PKGNAME" "$INSTDIR\emulationstation\.emulationstation\themes"
				${EndUserAborted}
				
			SectionEnd

			Section /o "Retro'Arts WQHD 1440p"

				SetDetailsPrint textonly
					DetailPrint "Installing Retro'Arts WQHD 1440p Theme"
				SetDetailsPrint none

				StrCpy $PKGNAME "es-theme-retroarts-1440p.zip"
				ifFileExists "${DOWNLOAD_DIR}\$PKGNAME" +4 0
				${CheckUserAborted}
				inetc::get "https://github.com/lehcimcramtrebor/es-theme-retroarts/tree/WQHD-1440p" "${DOWNLOAD_DIR}\$PKGNAME" /END
				${CheckUserAborted}
				nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$PKGNAME" "$INSTDIR\emulationstation\.emulationstation\themes"
				${EndUserAborted}
				
			SectionEnd

			Section /o "Retro'Arts FULL HD 1080p"

				SetDetailsPrint textonly
					DetailPrint "Installing Retro'Arts FULL HD 1080p Theme"
				SetDetailsPrint none

				StrCpy $PKGNAME "es-theme-retroarts-1080p.zip"
				ifFileExists "${DOWNLOAD_DIR}\$PKGNAME" +4 0
				${CheckUserAborted}
				inetc::get "https://github.com/lehcimcramtrebor/es-theme-retroarts/tree/FULLHD-1080p" "${DOWNLOAD_DIR}\$PKGNAME" /END
				${CheckUserAborted}
				nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$PKGNAME" "$INSTDIR\emulationstation\.emulationstation\themes"
				${EndUserAborted}
				
			SectionEnd

			Section /o "Retro'Arts HD Ready 720p"

				SetDetailsPrint textonly
					DetailPrint "Installing Retro'Arts HD Ready 720p Theme"
				SetDetailsPrint none

				StrCpy $PKGNAME "es-theme-retroarts-720p.zip"
				ifFileExists "${DOWNLOAD_DIR}\$PKGNAME" +4 0
				${CheckUserAborted}
				inetc::get "https://github.com/lehcimcramtrebor/es-theme-retroarts/tree/HDREADY-720p" "${DOWNLOAD_DIR}\$PKGNAME" /END
				${CheckUserAborted}
				nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$PKGNAME" "$INSTDIR\emulationstation\.emulationstation\themes"
				${EndUserAborted}
				
			SectionEnd

			SectionGroupEnd

			Section /o "Roleta"

				SetDetailsPrint textonly
					DetailPrint "Installing Roleta Theme"
				SetDetailsPrint none

				StrCpy $PKGNAME "es-theme-roleta.zip"
				ifFileExists "${DOWNLOAD_DIR}\$PKGNAME" +4 0
				${CheckUserAborted}
				inetc::get "https://github.com/lorenzolamas/es-theme-retrobat-Roleta/archive/master.zip" "${DOWNLOAD_DIR}\$PKGNAME" /END
				${CheckUserAborted}
				nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$PKGNAME" "$INSTDIR\emulationstation\.emulationstation\themes"
				${EndUserAborted}
				
			SectionEnd

	SectionGroupEnd

/* Section /o "Desktop Shortcut" SectionS
SectionInstType ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04}

	${CheckUserAborted}
	SetShellVarContext current
	SetOutPath "$INSTDIR"
	CreateShortCut "$DESKTOP\RetroBat.lnk" "$INSTDIR\retrobat.exe" "" "$INSTDIR\system\resources\retrobat.ico"

	${EndUserAborted}
SectionEnd
*/

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
!insertmacro MUI_DESCRIPTION_TEXT ${SectionLR} "Selection of Libretro cores."
!insertmacro MUI_DESCRIPTION_TEXT ${SectionRetroArch} "RetroArch v${RETROARCH_VERSION} custom build."
!insertmacro MUI_DESCRIPTION_TEXT ${SectionRetroBat} "Main softwares and configuration files needed."
!insertmacro MUI_DESCRIPTION_TEXT ${SectionThemes} "EmulationStation Theme created by the community compatible with RetroBat."
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

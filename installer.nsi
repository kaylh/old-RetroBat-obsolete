/*
********************************

	RetroBat Setup NSIS Script
	
********************************
*/

  !include "MUI2.nsh"
;  !include "FileFunc.nsh"
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
  OutFile "setup-retrobat-v${VERSION}.exe"
; OutFile "setup.exe"
  InstallDir "${BASE_INSTALL_DIR}"
  RequestExecutionLevel user 
  ShowInstDetails "nevershow"
  BrandingText "${PRODUCT} v${VERSION}"
  SpaceTexts none
  
;  !define MUI_ABORTWARNING
  !define MUI_ABORTWARNING_TEXT "Are you sure you wish to abort installation?"
  
  Var PKGNAME
  Var LRCORE
  Var CompletedText
  CompletedText $CompletedText
  
  !define MUI_ICON ".\system\resources\retrobat-icon-purple.ico"
;  !define MUI_COMPONENTSPAGE_SMALLDESC  
  !define MUI_HEADERIMAGE
  !define MUI_HEADERIMAGE_BITMAP ".\system\resources\header.bmp"
  !define MUI_HEADERIMAGE_BITMAP_STRETCH "FitControl"
  !define MUI_WELCOMEFINISHPAGE_BITMAP ".\system\resources\wizard.bmp"
  !define MUI_BGCOLOR "1C4E75"
  !define MUI_HEADER_TRANSPARENT_TEXT
  !define MUI_TEXTCOLOR "FFFFFF"

  !insertmacro MUI_PAGE_WELCOME
  !insertmacro MUI_PAGE_LICENSE ".\licence.txt"
  !insertmacro MUI_PAGE_COMPONENTS
  !insertmacro MUI_PAGE_DIRECTORY
  
  !define MUI_FINISHPAGE_NOAUTOCLOSE
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
  
  DetailPrint "Done."

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

InstType "Full integration (RetroArch ANGLE)" IT_REQUIRED_03
InstType "Partial integration (RetroArch OPENGL)" IT_REQUIRED_02
InstType "Batocera USB" IT_REQUIRED_04
InstType "Legacy ES systems list (No launcher commands)" IT_REQUIRED_01
	
SectionGroup "RetroBat"

Section "Main Files"
SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04}				
	${CheckUserAborted}
	SetOutPath "${DOWNLOAD_DIR}"	
	
	ifFileExists "${DOWNLOAD_DIR}\retrobat-v${VERSION}.zip" +2 0
	inetc::get "https://www.retrobat.ovh/repo/v3/retrobat-v${VERSION}.zip" "${DOWNLOAD_DIR}\retrobat-v${VERSION}.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\retrobat-v${VERSION}.zip" "$INSTDIR"
	
	ifFileExists "${DOWNLOAD_DIR}\bios-base.zip" +2 0
	inetc::get "https://www.retrobat.ovh/repo/v3/bios-base.zip" "${DOWNLOAD_DIR}\bios-base.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\bios-base.zip" "$INSTDIR\bios"
		
;	Delete "${DOWNLOAD_DIR}\retrobat-v${VERSION}.7z"
;	Delete "${DOWNLOAD_DIR}\bios-base.zip"
	${EndUserAborted}
SectionEnd
  
Section "-BeforeInstall" !Required
SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} 
SectionIn RO
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
	ExecWait "$INSTDIR\retrobat.exe /NOF #MakeTree"
  
SetOutPath $INSTDIR

	ifFileExists "$INSTDIR\system\install.done" 0 +2
	Delete "$INSTDIR\system\install.done"
	${EndUserAborted}	
SectionEnd

Section "EmulationStation"		
SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04}
	${CheckUserAborted} 
	SetOutPath "${DOWNLOAD_DIR}"

	ifFileExists "${DOWNLOAD_DIR}\emulationstation.zip" +2 0
	inetc::get "https://github.com/fabricecaruso/batocera-emulationstation/releases/download/continuous-stable/EmulationStation-Win32.zip" "${DOWNLOAD_DIR}\emulationstation.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\emulationstation.zip" "$INSTDIR\emulationstation"
	
	ifFileExists "${DOWNLOAD_DIR}\batocera-ports.zip" +2 0
	inetc::get "http://www.retrobat.ovh/repo/v3/batocera-ports.zip" "${DOWNLOAD_DIR}\batocera-ports.zip" /END 
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\batocera-ports.zip" "$INSTDIR\emulationstation"
	
	ifFileExists "${DOWNLOAD_DIR}\retrobat-intro.zip" +2 0
	inetc::get "http://www.retrobat.ovh/repo/v3/retrobat-intro.zip" "${DOWNLOAD_DIR}\retrobat-intro.zip" /END 
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\retrobat-intro.zip" "$INSTDIR\emulationstation\.emulationstation\video"
	
	ifFileExists "${DOWNLOAD_DIR}\es-theme-carbon.zip" +2 0
	inetc::get "http://www.retrobat.ovh/repo/v3/es-theme-carbon.zip" "${DOWNLOAD_DIR}\es-theme-carbon.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\es-theme-carbon.zip" "$INSTDIR\emulationstation\.emulationstation\themes\es-theme-carbon"

/*	Delete "${DOWNLOAD_DIR}\emulationstation.zip"
	Delete "${DOWNLOAD_DIR}\batocera-ports.zip"
	Delete "${DOWNLOAD_DIR}\retrobat-intro.zip"
	Delete "${DOWNLOAD_DIR}\es-theme-carbon.zip"
*/
	${EndUserAborted}
SectionEnd
	
SectionGroup "Optional Themes"
			
			Section "Forever"
				${CheckUserAborted}
				SetDetailsPrint textonly
					DetailPrint "Installing Forever Theme"
				SetDetailsPrint none

				StrCpy $PKGNAME "es-theme-forever.zip"
				ifFileExists "${DOWNLOAD_DIR}\$PKGNAME" +2 0
				inetc::get "https://github.com/lehcimcramtrebor/es-theme-forever/archive/master.zip" "${DOWNLOAD_DIR}\$PKGNAME" /END
				nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$PKGNAME" "$INSTDIR\emulationstation\.emulationstation\themes"
				Delete "${DOWNLOAD_DIR}\$PKGNAME"
				${EndUserAborted}
			SectionEnd
			
			Section "NextFull"
			
				${CheckUserAborted}
				SetDetailsPrint textonly
					DetailPrint "Installing NextFull Theme"
				SetDetailsPrint none

				StrCpy $PKGNAME "es-theme-nextfull.zip"
				ifFileExists "${DOWNLOAD_DIR}\$PKGNAME" +2 0				
				inetc::get "https://github.com/kaylh/es-theme-nextfull/archive/master.zip" "${DOWNLOAD_DIR}\$PKGNAME" /END
				nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$PKGNAME" "$INSTDIR\emulationstation\.emulationstation\themes"
				Delete "${DOWNLOAD_DIR}\$PKGNAME"
				${EndUserAborted}
			SectionEnd
			
			SectionGroup "Retro'Arts"
			
			Section "Retro'Arts UHD 2160p"
			
				${CheckUserAborted}
				SetDetailsPrint textonly
					DetailPrint "Installing Retro'Arts UHD 2160p Theme"
				SetDetailsPrint none

				StrCpy $PKGNAME "es-theme-retroarts-2160p.zip"
				ifFileExists "${DOWNLOAD_DIR}\$PKGNAME" +2 0
				inetc::get "https://github.com/lehcimcramtrebor/es-theme-retroarts/tree/UHD-2160p" "${DOWNLOAD_DIR}\$PKGNAME" /END
				nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$PKGNAME" "$INSTDIR\emulationstation\.emulationstation\themes"
				Delete "${DOWNLOAD_DIR}\$PKGNAME"
				${EndUserAborted}
			SectionEnd
			
			Section "Retro'Arts WQHD 1440p"
			
				${CheckUserAborted}
				SetDetailsPrint textonly
					DetailPrint "Installing Retro'Arts WQHD 1440p Theme"
				SetDetailsPrint none

				StrCpy $PKGNAME "es-theme-retroarts-1440p.zip"
				ifFileExists "${DOWNLOAD_DIR}\$PKGNAME" +2 0
				inetc::get "https://github.com/lehcimcramtrebor/es-theme-retroarts/tree/WQHD-1440p" "${DOWNLOAD_DIR}\$PKGNAME" /END
				nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$PKGNAME" "$INSTDIR\emulationstation\.emulationstation\themes"
				Delete "${DOWNLOAD_DIR}\$PKGNAME"
				${EndUserAborted}
			SectionEnd
			
			Section "Retro'Arts FULL HD 1080p"
			
				${CheckUserAborted}
				SetDetailsPrint textonly
					DetailPrint "Installing Retro'Arts FULL HD 1080p Theme"
				SetDetailsPrint none

				StrCpy $PKGNAME "es-theme-retroarts-1080p.zip"
				ifFileExists "${DOWNLOAD_DIR}\$PKGNAME" +2 0
				inetc::get "https://github.com/lehcimcramtrebor/es-theme-retroarts/tree/FULLHD-1080p" "${DOWNLOAD_DIR}\$PKGNAME" /END
				nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$PKGNAME" "$INSTDIR\emulationstation\.emulationstation\themes"
				Delete "${DOWNLOAD_DIR}\$PKGNAME"
				${EndUserAborted}
			SectionEnd
			
			Section "Retro'Arts HD Ready 720p"
			
				${CheckUserAborted}
				SetDetailsPrint textonly
					DetailPrint "Installing Retro'Arts HD Ready 720p Theme"
				SetDetailsPrint none

				StrCpy $PKGNAME "es-theme-retroarts-720p.zip"
				ifFileExists "${DOWNLOAD_DIR}\$PKGNAME" +2 0
				inetc::get "https://github.com/lehcimcramtrebor/es-theme-retroarts/tree/HDREADY-720p" "${DOWNLOAD_DIR}\$PKGNAME" /END
				nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$PKGNAME" "$INSTDIR\emulationstation\.emulationstation\themes"
				Delete "${DOWNLOAD_DIR}\$PKGNAME"
				${EndUserAborted}
			SectionEnd

			SectionGroupEnd
			
			Section "Roleta"
			
				${CheckUserAborted}
				SetDetailsPrint textonly
					DetailPrint "Installing Roleta Theme"
				SetDetailsPrint none

				StrCpy $PKGNAME "es-theme-roleta.zip"
				ifFileExists "${DOWNLOAD_DIR}\$PKGNAME" +2 0
				inetc::get "https://github.com/lorenzolamas/es-theme-retrobat-Roleta/archive/master.zip" "${DOWNLOAD_DIR}\$PKGNAME" /END
				nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$PKGNAME" "$INSTDIR\emulationstation\.emulationstation\themes"
				Delete "${DOWNLOAD_DIR}\$PKGNAME"
				${EndUserAborted}
			SectionEnd
			
	SectionGroupEnd

	Section "RetroArch"
	SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04}
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
		ifFileExists "${DOWNLOAD_DIR}\retroarch-${OS_ARCHITECTURE}.7z" +2 0
		inetc::get "http://www.retrobat.ovh/repo/v3/retroarch-${OS_ARCHITECTURE}.7z" "${DOWNLOAD_DIR}\retroarch-${OS_ARCHITECTURE}.7z" /END
		Nsis7z::ExtractWithDetails "${DOWNLOAD_DIR}\retroarch-${OS_ARCHITECTURE}.7z" "Extracting %s"

		ifFileExists "${DOWNLOAD_DIR}\retroarch-assets.zip" +2 0
		inetc::get "https://buildbot.libretro.com/assets/frontend/assets.zip" "${DOWNLOAD_DIR}\retroarch-assets.zip" /END
		nsisunz::UnzipToLog "${DOWNLOAD_DIR}\retroarch-assets.zip" "$INSTDIR\emulators\retroarch\assets"

		ifFileExists "${DOWNLOAD_DIR}\retroarch-autoconfig.zip" +2 0
		inetc::get "https://buildbot.libretro.com/assets/frontend/autoconfig.zip" "${DOWNLOAD_DIR}\retroarch-autoconfig.zip" /END
		nsisunz::UnzipToLog "${DOWNLOAD_DIR}\retroarch-autoconfig.zip" "$INSTDIR\emulators\retroarch\autoconfig"
	
		ifFileExists "${DOWNLOAD_DIR}\retroarch-database-cursors.zip" +2 0
		inetc::get "https://buildbot.libretro.com/assets/frontend/database-cursors.zip" "${DOWNLOAD_DIR}\retroarch-database-cursors.zip" /END
		nsisunz::UnzipToLog "${DOWNLOAD_DIR}\retroarch-database-cursors.zip" "$INSTDIR\emulators\retroarch\database\cursors"

		ifFileExists "${DOWNLOAD_DIR}\retroarch-database-rdb.zip" +2 0
		inetc::get "https://buildbot.libretro.com/assets/frontend/database-rdb.zip" "${DOWNLOAD_DIR}\retroarch-database-rdb.zip" /END
		nsisunz::UnzipToLog "${DOWNLOAD_DIR}\retroarch-database-rdb.zip" "$INSTDIR\emulators\retroarch\database\rdb"

		ifFileExists "${DOWNLOAD_DIR}\retroarch-info.zip" +2 0
		inetc::get "https://buildbot.libretro.com/assets/frontend/info.zip" "${DOWNLOAD_DIR}\retroarch-info.zip" /END
		nsisunz::UnzipToLog "${DOWNLOAD_DIR}\retroarch-info.zip" "$INSTDIR\emulators\retroarch\info"

		ifFileExists "${DOWNLOAD_DIR}\$PKGNAME" +2 0
		inetc::get "http://www.retrobat.ovh/repo/v3/shaders.zip" "${DOWNLOAD_DIR}\retroarch-shaders.zip" /END
		nsisunz::UnzipToLog "${DOWNLOAD_DIR}\retroarch-shaders.zip" "$INSTDIR\emulators\retroarch\shaders"
		
		ifFileExists "${DOWNLOAD_DIR}\decorations.zip" +2 0
		inetc::get "https://github.com/kaylh/RetroArch-Bezels/releases/download/1.0/retroarch-bezels.zip" "${DOWNLOAD_DIR}\decorations.zip" /END
		nsisunz::UnzipToLog "${DOWNLOAD_DIR}\decorations.zip" "$INSTDIR\decorations"

/*		
		Delete "${DOWNLOAD_DIR}\retroarch-${OS_ARCHITECTURE}.7z"
		Delete "${DOWNLOAD_DIR}\retroarch-assets.zip"
		Delete "${DOWNLOAD_DIR}\retroarch-autoconfig.zip"
		Delete "${DOWNLOAD_DIR}\retroarch-database-cursors.zip"
		Delete "${DOWNLOAD_DIR}\retroarch-database-rdb.zip"
		Delete "${DOWNLOAD_DIR}\retroarch-info.zip"
		Delete "${DOWNLOAD_DIR}\retroarch-shaders.zip"
		Delete "${DOWNLOAD_DIR}\decorations.zip"
*/		${EndUserAborted}	
	SectionEnd

Section "Libretro Cores Pack"
SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04}
	${CheckUserAborted}
	
	SetOutPath "$INSTDIR\emulators\retroarch\cores"
	
	StrCpy $LRCORE "2048"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "81"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "atari800"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "blastem"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "bluemsx"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "bsnes"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "bsnes_hd_beta"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "bsnes_mercury_balanced"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "bsnes_mercury_accuracy"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "bsnes_mercury_performance"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "bsnes2014_accuracy"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "bsnes2014_balanced"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "bsnes2014_performance"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "cap32"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "citra_canary"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "citra"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "craft"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "crocods"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "desmume"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "desmume2015"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "dolphin"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "dosbox_core"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "dosbox_svn_ce"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "dosbox_svn"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "fbalpha2012_cps1"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "fbalpha2012_cps2"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "fbalpha2012"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "fbalpha2012_neogeo"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "fbneo"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "fceumm"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "ffmpeg"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "flycast_gles2"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "flycast"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "fmsx"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "freeintv"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "frodo"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "fuse"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "gambatte"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "gearboy"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "gearsystem"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "genesis_plus_gx"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "gpsp"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "gw"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "handy"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "hatari"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "higan_sfc_balanced"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "higan_sfc"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "imageviewer"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "kronos"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "lutro"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "mame2003_plus"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "mame2016"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "mednafen_gba"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "mednafen_lynx"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "mednafen_ngp"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "mednafen_pce_fast"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "mednafen_pce"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "mednafen_pcfx"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "mednafen_psx_hw"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "mednafen_psx"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "mednafen_saturn"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "mednafen_snes"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "mednafen_supergrafx"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "mednafen_vb"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "mednafen_wswan"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "melonds"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "mesen"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "mesen-s"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "mgba"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "mrboom"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "mupen64plus_next_gles3"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "mupen64plus_next"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "nekop2"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "neocd"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "nestopia"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "np2kai"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "nxengine"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "o2em"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "opera"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "parallel_n64"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "pcsx_rearmed"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "picodrive"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "play"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "pokemini"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "ppsspp"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "prboom"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "prosystem"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "puae"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "px68k"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "quasi88"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "quicknes"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "race"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "sameboy"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "scummvm"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "smsplus"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "snes9x"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "stella"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "stella2014"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "tgbdual"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "theodore"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "tic80"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "vba_next"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "vbam"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "vecx"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "vice_x64"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "vice_x128"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "vice_xpet"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "vice_xplus4"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "vice_xvic"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "virtualjaguar"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "yabasanshiro"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	StrCpy $LRCORE "yabause"
	ifFileExists "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" +2 0
	inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores"
	
;	Delete "${DOWNLOAD_DIR}\*.zip"
	${EndUserAborted}
SectionEnd

Section "DOSBox"
SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04}
	${CheckUserAborted}
	
	StrCpy $PKGNAME "dosbox.zip"
	
	SetOutPath "${DOWNLOAD_DIR}"		
	inetc::get "https://www.retrobat.ovh/repo/v3/dosbox.zip" "${DOWNLOAD_DIR}\$PKGNAME" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$PKGNAME" "$INSTDIR\emulators\dosbox"
	${EndUserAborted}
SectionEnd

Section "-PostInstallTasks"
SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04}
	${CheckUserAborted}
SectionIn RO

	SetDetailsPrint textonly
		DetailPrint "Cleaning download folder"
	SetDetailsPrint none

	Delete "${DOWNLOAD_DIR}\*.7z"
	Delete "${DOWNLOAD_DIR}\*.zip"

SetOutPath $INSTDIR
  
	SetDetailsPrint textonly
		DetailPrint "Setting up configuration files"
	SetDetailsPrint none
  
	ifFileExists "$INSTDIR\retrobat.exe" 0 +2
	ExecWait "$INSTDIR\retrobat.exe /NOF #CopyConfig"

SetOutPath $INSTDIR
	${EndUserAborted}
SectionEnd

Section "-ConfigMode1"
SectionInstType ${IT_REQUIRED_01}
	${CheckUserAborted}

  FileOpen $4 "$INSTDIR\retrobat.ini" w
  FileWrite $4 "[RetroBat]"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "ConfigMode=1"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "InputComboMode=3"
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

Section "-ConfigMode2"
SectionInstType ${IT_REQUIRED_02}
	${CheckUserAborted}

  FileOpen $4 "$INSTDIR\retrobat.ini" w
  FileWrite $4 "[RetroBat]"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "ConfigMode=2"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "InputComboMode=3"
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

Section "-ConfigMode3"
SectionInstType ${IT_REQUIRED_03}
	${CheckUserAborted}

  FileOpen $4 "$INSTDIR\retrobat.ini" w
  FileWrite $4 "[RetroBat]"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "ConfigMode=3"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "InputComboMode=3"
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

Section "-ConfigMode4"
SectionInstType ${IT_REQUIRED_04}
	${CheckUserAborted}

  FileOpen $4 "$INSTDIR\retrobat.ini" w
  FileWrite $4 "[RetroBat]"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "ConfigMode=4"
  FileWrite $4 "$\r$\n"
  FileWrite $4 "InputComboMode=3"
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

Section "Desktop Shortcut" SectionS
	${CheckUserAborted}
;SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04}

	SetShellVarContext current
	SetOutPath "$INSTDIR"
	CreateShortCut "$DESKTOP\RetroBat.lnk" "$INSTDIR\retrobat.exe" "" "$INSTDIR\system\resources\retrobat.ico"

	${EndUserAborted}
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

Function InstFilesLeave

    StrCpy $CurrentPage ""
	
FunctionEnd

!define MUI_CUSTOMFUNCTION_ABORT onUserAbort
Function onUserAbort
  StrCpy $UserIsMakingAbortDecision "yes"
  ${If} ${Cmd} `MessageBox MB_YESNO|MB_DEFBUTTON2 "${MUI_ABORTWARNING_TEXT}" IDYES`
    ${If} $CurrentPage == "InstFiles"
      StrCpy $UserAborted "yes"
      MessageBox MB_OK "Your RetroBat's installation could be incomplete."
      StrCpy $UserIsMakingAbortDecision "no"
      Abort
    ${Else}
      MessageBox MB_OK "Your RetroBat's installation could be incomplete."
      StrCpy $UserIsMakingAbortDecision "no"
    ${EndIf}
  ${Else}
    StrCpy $UserIsMakingAbortDecision "no"
    Abort
  ${EndIf}
FunctionEnd

!insertmacro MUI_LANGUAGE "English"

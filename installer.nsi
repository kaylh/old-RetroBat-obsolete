/*
********************************

	RetroBat Setup NSIS Script
	
********************************
*/

  !define PRODUCT "RetroBat"
  !define PRODUCT_VERSION "3.10"
  !define VERSION "${PRODUCT_VERSION}"
  !define RETROARCH_VERSION "1.8.9"
  !define OS_ARCHITECTURE "x86_64"
  !define PRODUCT_PUBLISHER "RetroBat Team"
  !define PRODUCT_WEB_SITE "https://www.retrobat.ovh/"
  
  !define BASE_DIR "..\RetroBat"
  !define BASE_INSTALL_DIR "C:\$(^Name)"
; !define BASE_INSTALL_DIR "$EXEDIR"
  !define DOWNLOAD_DIR "$INSTDIR\system\download"

  SetCompressor /SOLID lzma
  Unicode true
  
  !include "LogicLib.nsh"
  !include "FileFunc.nsh"
  !include "MUI2.nsh"  
  
  !define MUI_ABORTWARNING
  !define MUI_ABORTWARNING_TEXT "Are you sure you wish to abort installation?"
  !define MUI_ICON ".\system\resources\setup.ico"
  !define MUI_COMPONENTSPAGE_SMALLDESC  
  !define MUI_HEADERIMAGE
  !define MUI_HEADERIMAGE_BITMAP ".\system\resources\header.bmp"
  !define MUI_HEADERIMAGE_BITMAP_STRETCH "FitControl"
  !define MUI_WELCOMEFINISHPAGE_BITMAP ".\system\resources\wizard.bmp"
  !define MUI_BGCOLOR "1C4E75"
  !define MUI_HEADER_TRANSPARENT_TEXT
  !define MUI_TEXTCOLOR "FFFFFF"
  !define MUI_PAGE_CUSTOMFUNCTION_SHOW InstFilesShow

; !insertmacro MUI_PAGE_WELCOME
  !insertmacro MUI_PAGE_LICENSE ".\licence.txt"
  !insertmacro MUI_PAGE_COMPONENTS
  !insertmacro MUI_PAGE_DIRECTORY
  !insertmacro MUI_PAGE_INSTFILES
  !insertmacro MUI_PAGE_FINISH
  !insertmacro MUI_LANGUAGE "English"
;  Page Custom ExtractArchives
;  Page Custom PostInstallTasks

  
  Name "${PRODUCT}"
  OutFile "Setup-${PRODUCT}-v${VERSION}.exe"
; OutFile "setup.exe"
  InstallDir "${BASE_INSTALL_DIR}"
  RequestExecutionLevel user 
  ShowInstDetails "nevershow"
  BrandingText "${PRODUCT} v${VERSION}"

Function InstFilesShow
  GetDlgItem $0 $HWNDPARENT 2
  EnableWindow $0 1
FunctionEnd
  
InstType "Required softwares with Carbon theme" IT_REQUIRED_01
InstType "Required softwares with Forever theme" IT_REQUIRED_02
InstType "Required softwares with NextFull theme" IT_REQUIRED_03
InstType "Required softwares with Retro'Arts theme" IT_REQUIRED_04
InstType "Required softwares with Roleta theme" IT_REQUIRED_05
InstType "Required softwares without emulators" IT_REQUIRED_06

Var PKG_DIR
Var PKGNAME
Var LRCORE
;Var OutputMsg

/*
Function CharStrip
Exch $R0 #char
Exch
Exch $R1 #in string
Push $R2
Push $R3
Push $R4
 StrCpy $R2 -1
 IntOp $R2 $R2 + 1
 StrCpy $R3 $R1 1 $R2
 StrCmp $R3 "" +8
 StrCmp $R3 $R0 0 -3
  StrCpy $R3 $R1 $R2
  IntOp $R2 $R2 + 1
  StrCpy $R4 $R1 "" $R2
  StrCpy $R1 $R3$R4
  IntOp $R2 $R2 - 2
  Goto -9
  StrCpy $R0 $R1
Pop $R4
Pop $R3
Pop $R2
Pop $R1
Exch $R0
FunctionEnd
!macro CharStrip Char InStr OutVar
 Push '${InStr}'
 Push '${Char}'
  Call CharStrip
 Pop '${OutVar}'
!macroend
!define CharStrip '!insertmacro CharStrip'
*/ 

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
	
SectionGroup "RetroBat"

	Section "Main Files"
	
	SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05} ${IT_REQUIRED_06}
						
	AddSize 4000
		
	;StrCpy $PKG_DIR ""
	StrCpy $PKGNAME "retrobat-v${VERSION}.zip"
	
	SetOutPath "${DOWNLOAD_DIR}"		
	inetc::get "https://www.retrobat.ovh/repo/v3/$PKGNAME" "${DOWNLOAD_DIR}\$PKGNAME" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$PKGNAME" "$INSTDIR"
	Delete "${DOWNLOAD_DIR}\$PKGNAME"

	SectionEnd
  
  Section "-Tasks Required" !Required
  
  SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05} ${IT_REQUIRED_06}
  
  SectionIn RO
  
  StrCpy $0 "$INSTDIR"
  StrCpy $0 $0 3
  ${StrStrip} "$0" "$INSTDIR" $R0
  
  Call SetInfoDirs
  
  SetOutPath $INSTDIR
  
  SetDetailsPrint textonly
	DetailPrint "Creating: RetroBat folders tree"
  SetDetailsPrint none
	ExecWait "$INSTDIR\retrobat.exe /NOF #MakeTree"
	
  SetDetailsPrint textonly
	DetailPrint "Copying: RetroBat config files for emulators"
  SetDetailsPrint none
	ExecWait "$INSTDIR\retrobat.exe /NOF #CopyConfig"
  
  SetOutPath $INSTDIR

  Delete "$INSTDIR\system\install.done"  
  
/* 
;  SetOutPath $EXEDIR
  SetOutPath $INSTDIR
  SetDetailsPrint textonly
  DetailPrint "Creating: RetroBat folders tree"
  SetDetailsPrint none
  ExecWait "$INSTDIR\retrobat.exe /NOF #MakeTree"
  SetOutPath $INSTDIR  

;  SetOutPath $EXEDIR
  SetOutPath $INSTDIR
  SetDetailsPrint textonly
  DetailPrint "Copying: RetroBat config files for emulators"
  SetDetailsPrint none
  ExecWait "$INSTDIR\retrobat.exe /NOF #CopyConfig"
  SetOutPath $INSTDIR
*/
 
  SectionEnd
 

	SectionGroup "EmulationStation"

		Section "-Binaries"
		
		SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05} ${IT_REQUIRED_06}
				
		AddSize 120000
		
		StrCpy $PKG_DIR "emulationstation"
		StrCpy $PKGNAME "emulationstation.zip"

		SetOutPath "$INSTDIR\$PKG_DIR"		
		inetc::get "https://github.com/fabricecaruso/batocera-emulationstation/releases/download/continuous-master/EmulationStation-Win32.zip" "$INSTDIR\$PKG_DIR\$PKGNAME" /END
		nsisunz::UnzipToLog "$INSTDIR\$PKG_DIR\$PKGNAME" "$INSTDIR\$PKG_DIR"
		Delete "$INSTDIR\$PKG_DIR\$PKGNAME"

		SectionEnd
		
		Section "VC++ Libraries"
		
		SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05} ${IT_REQUIRED_06}
		
				AddSize 2000
	
				StrCpy $PKG_DIR "emulationstation"
				StrCpy $PKGNAME "vcredist-dll.zip"
				
				SetOutPath "$INSTDIR\$PKG_DIR"		
				inetc::get "http://www.retrobat.ovh/repo/tools/vcredist-dll-pkg.zip" "$INSTDIR\$PKG_DIR\$PKGNAME" /END
				nsisunz::UnzipToLog "$INSTDIR\$PKG_DIR\$PKGNAME" "$INSTDIR\$PKG_DIR"
				Delete "$INSTDIR\$PKG_DIR\$PKGNAME"

		SectionEnd
		
		Section "7za Libraries"
		
		SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05} ${IT_REQUIRED_06}
		
		AddSize 200
	
		StrCpy $PKG_DIR "emulationstation"
		StrCpy $PKGNAME "7za.zip"
				
		SetOutPath "$INSTDIR\$PKG_DIR"		
		inetc::get "http://www.retrobat.ovh/repo/v3/7za.zip" "$INSTDIR\$PKG_DIR\$PKGNAME" /END
		nsisunz::UnzipToLog "$INSTDIR\$PKG_DIR\$PKGNAME" "$INSTDIR\$PKG_DIR"
		Delete "$INSTDIR\$PKG_DIR\$PKGNAME"

		SectionEnd
		
		Section "Batocera Ports"
				
		SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05} ${IT_REQUIRED_06}
		
		AddSize 500
	
		StrCpy $PKG_DIR "emulationstation"
		StrCpy $PKGNAME "batocera-ports.zip"

		SetOutPath "$INSTDIR\$PKG_DIR"		
		inetc::get "https://github.com/fabricecaruso/batocera-ports/releases/download/continuous/batocera-ports.zip" "$INSTDIR\$PKG_DIR\$PKGNAME" /END
		nsisunz::UnzipToLog "$INSTDIR\$PKG_DIR\$PKGNAME" "$INSTDIR\$PKG_DIR"
		Delete "$INSTDIR\$PKG_DIR\$PKGNAME"

		SectionEnd
		
		Section "RetroBat Intro Video"
				
		SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05} ${IT_REQUIRED_06}
		
		AddSize 500
	
		StrCpy $PKG_DIR "emulationstation\.emulationstation\video"
		StrCpy $PKGNAME "retrobat-intro.zip"

		SetOutPath "$INSTDIR\$PKG_DIR"		
		inetc::get "https://www.retrobat.ovh/repo/v3/RetroBat-intro.zip" "$INSTDIR\$PKG_DIR\$PKGNAME" /END
		nsisunz::UnzipToLog "$INSTDIR\$PKG_DIR\$PKGNAME" "$INSTDIR\$PKG_DIR"
		Delete "$INSTDIR\$PKG_DIR\$PKGNAME"

		SectionEnd

	SectionGroupEnd
	
	SectionGroup "Themes"
	
			Section "Carbon"
			
			SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_06}
			
				AddSize 32000
				
				StrCpy $PKG_DIR "emulationstation\.emulationstation\themes"
				StrCpy $PKGNAME "es-theme-carbon.zip"
		

				SetOutPath "$INSTDIR\$PKG_DIR"		
				inetc::get "https://github.com/kaylh/es-theme-carbon/archive/master.zip" "$INSTDIR\$PKG_DIR\$PKGNAME" /END
				nsisunz::UnzipToLog "$INSTDIR\$PKG_DIR\$PKGNAME" "$INSTDIR\$PKG_DIR"
				Delete "$INSTDIR\$PKG_DIR\$PKGNAME"

			SectionEnd
			
			Section "Forever"
			
			SectionInstType ${IT_REQUIRED_02}
			
				AddSize 90000
				
				StrCpy $PKG_DIR "emulationstation\.emulationstation\themes"
				StrCpy $PKGNAME "es-theme-forever.zip"
		
				SetOutPath "$INSTDIR\$PKG_DIR"		
				inetc::get "https://github.com/lehcimcramtrebor/es-theme-forever/archive/master.zip" "$INSTDIR\$PKG_DIR\$PKGNAME" /END
				nsisunz::UnzipToLog "$INSTDIR\$PKG_DIR\$PKGNAME" "$INSTDIR\$PKG_DIR"
				Delete "$INSTDIR\$PKG_DIR\$PKGNAME"

			SectionEnd
			
			Section "NextFull"
			
			SectionInstType ${IT_REQUIRED_03}
			
				AddSize 50000

				StrCpy $PKG_DIR "emulationstation\.emulationstation\themes"
				StrCpy $PKGNAME "es-theme-nextfull.zip"
		
				SetOutPath "$INSTDIR\$PKG_DIR"		
				inetc::get "https://github.com/kaylh/es-theme-nextfull/archive/master.zip" "$INSTDIR\$PKG_DIR\$PKGNAME" /END
				nsisunz::UnzipToLog "$INSTDIR\$PKG_DIR\$PKGNAME" "$INSTDIR\$PKG_DIR"
				Delete "$INSTDIR\$PKG_DIR\$PKGNAME"

			SectionEnd
			
			SectionGroup "Retro' Arts"
			
			Section "Retro'Arts UHD 2160p"

				AddSize 450000

				StrCpy $PKG_DIR "emulationstation\.emulationstation\themes"
				StrCpy $PKGNAME "es-theme-retroarts-2160p.zip"
		
				SetOutPath "$INSTDIR\$PKG_DIR"		
				inetc::get "https://github.com/lehcimcramtrebor/es-theme-retroarts/tree/UHD-2160p" "$INSTDIR\$PKG_DIR\$PKGNAME" /END
				nsisunz::UnzipToLog "$INSTDIR\$PKG_DIR\$PKGNAME" "$INSTDIR\$PKG_DIR"
				Delete "$INSTDIR\$PKG_DIR\$PKGNAME"

			SectionEnd
			
			Section "Retro'Arts WQHD 1440p"

				AddSize 290000

				StrCpy $PKG_DIR "emulationstation\.emulationstation\themes"
				StrCpy $PKGNAME "es-theme-retroarts-1440p.zip"
		
				SetOutPath "$INSTDIR\$PKG_DIR"		
				inetc::get "https://github.com/lehcimcramtrebor/es-theme-retroarts/tree/WQHD-1440p" "$INSTDIR\$PKG_DIR\$PKGNAME" /END
				nsisunz::UnzipToLog "$INSTDIR\$PKG_DIR\$PKGNAME" "$INSTDIR\$PKG_DIR"
				Delete "$INSTDIR\$PKG_DIR\$PKGNAME"

			SectionEnd
			
			Section "Retro'Arts FULL HD 1080p"
			
			SectionInstType ${IT_REQUIRED_04}
			
				AddSize 450000

				StrCpy $PKG_DIR "emulationstation\.emulationstation\themes"
				StrCpy $PKGNAME "es-theme-retroarts-1080p.zip"
		
				SetOutPath "$INSTDIR\$PKG_DIR"		
				inetc::get "https://github.com/lehcimcramtrebor/es-theme-retroarts/tree/FULLHD-1080p" "$INSTDIR\$PKG_DIR\$PKGNAME" /END
				nsisunz::UnzipToLog "$INSTDIR\$PKG_DIR\$PKGNAME" "$INSTDIR\$PKG_DIR"
				Delete "$INSTDIR\$PKG_DIR\$PKGNAME"

			SectionEnd
			
			Section "Retro'Arts HD Ready 720p"
			
				AddSize 210000

				StrCpy $PKG_DIR "emulationstation\.emulationstation\themes"
				StrCpy $PKGNAME "es-theme-retroarts-720p.zip"
		
				SetOutPath "$INSTDIR\$PKG_DIR"		
				inetc::get "https://github.com/lehcimcramtrebor/es-theme-retroarts/tree/HDREADY-720p" "$INSTDIR\$PKG_DIR\$PKGNAME" /END
				nsisunz::UnzipToLog "$INSTDIR\$PKG_DIR\$PKGNAME" "$INSTDIR\$PKG_DIR"
				Delete "$INSTDIR\$PKG_DIR\$PKGNAME"

			SectionEnd

			SectionGroupEnd
			
			Section "Roleta"
			
			SectionInstType ${IT_REQUIRED_05}
			
				AddSize 70000

				StrCpy $PKG_DIR "emulationstation\.emulationstation\themes"
				StrCpy $PKGNAME "es-theme-roleta.zip"
		
				SetOutPath "$INSTDIR\$PKG_DIR"		
				inetc::get "https://github.com/lorenzolamas/es-theme-retrobat-Roleta/archive/master.zip" "$INSTDIR\$PKG_DIR\$PKGNAME" /END
				nsisunz::UnzipToLog "$INSTDIR\$PKG_DIR\$PKGNAME" "$INSTDIR\$PKG_DIR"
				Delete "$INSTDIR\$PKG_DIR\$PKGNAME"

			SectionEnd
			
	SectionGroupEnd

/*	
SectionGroup "RetroArch Nightly"

	Section "-Binary"
	
		AddSize 13000
	
		StrCpy $PKG_DIR "emulators\retroarch"
		StrCpy $PKGNAME "retroarch-nightly-binaries.7z"
		
		SetOutPath "$INSTDIR\$PKG_DIR"		
		inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/_RetroArch.7z" "$INSTDIR\$PKG_DIR\$PKGNAME" /END
		Nsis7z::ExtractWithDetails "$INSTDIR\$PKG_DIR\$PKGNAME" "Extracting %s..."
		Delete "$INSTDIR\$PKG_DIR\$PKGNAME"
		Delete "$INSTDIR\$PKG_DIR\retroarch_debug.exe"
		Delete "$INSTDIR\$PKG_DIR\retroarch_angle.exe"

	SectionEnd
	
	Section "-Libraries"
	
		AddSize 150000
	
		StrCpy $PKG_DIR "emulators\retroarch"
		StrCpy $PKGNAME "retroarch-nightly-dll.7z"
		
		SetOutPath "$INSTDIR\$PKG_DIR"		
		inetc::get "hhttps://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/redist.7z" "$INSTDIR\$PKG_DIR\$PKGNAME" /END
		Nsis7z::ExtractWithDetails "$INSTDIR\$PKG_DIR\$PKGNAME" "Extracting %s..."
		Delete "$INSTDIR\$PKG_DIR\$PKGNAME"

	SectionEnd

SectionGroupEnd
*/
SectionGroup "RetroArch"

	Section "Binaries"
	
	SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}
	
		AddSize 320000
	
		StrCpy $PKG_DIR "emulators\retroarch"
		StrCpy $PKGNAME "retroarch-stable-binaries.7z"
		
		SetOutPath "$INSTDIR\$PKG_DIR"		
		inetc::get "https://buildbot.libretro.com/stable/${RETROARCH_VERSION}/windows/${OS_ARCHITECTURE}/_RetroArch.7z" "$INSTDIR\$PKG_DIR\$PKGNAME" /END
		Nsis7z::ExtractWithDetails "$INSTDIR\$PKG_DIR\$PKGNAME" "Extracting %s..."
		Delete "$INSTDIR\$PKG_DIR\$PKGNAME"
		Delete "$INSTDIR\$PKG_DIR\retroarch_debug.exe"

	SectionEnd
	
	Section "Libraries"
	
	SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}
	
		AddSize 150000
	
		StrCpy $PKG_DIR "emulators\retroarch"
		StrCpy $PKGNAME "retroarch-stable-dll.7z"
		
		SetOutPath "$INSTDIR\$PKG_DIR"		
		inetc::get "https://buildbot.libretro.com/stable/${RETROARCH_VERSION}/windows/${OS_ARCHITECTURE}/redist.7z" "$INSTDIR\$PKG_DIR\$PKGNAME" /END
		Nsis7z::ExtractWithDetails "$INSTDIR\$PKG_DIR\$PKGNAME" "Extracting %s..."
		Delete "$INSTDIR\$PKG_DIR\$PKGNAME"

	SectionEnd
	
	Section "assets"
	
	SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}
	
		AddSize 92000
	
		StrCpy $PKG_DIR "emulators\retroarch\assets"
		StrCpy $PKGNAME "retroarch-assets.zip"
		
		SetOutPath "$INSTDIR\$PKG_DIR"		
		inetc::get "https://buildbot.libretro.com/assets/frontend/assets.zip" "$INSTDIR\$PKG_DIR\$PKGNAME" /END
		nsisunz::UnzipToLog "$INSTDIR\$PKG_DIR\$PKGNAME" "$INSTDIR\$PKG_DIR"
		Delete "$INSTDIR\$PKG_DIR\$PKGNAME"

	SectionEnd
	
	Section "autoconfig"
	
	SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}
	
		AddSize 3000
	
		StrCpy $PKG_DIR "emulators\retroarch\autoconfig"
		StrCpy $PKGNAME "retroarch-autoconfig.zip"
		
		SetOutPath "$INSTDIR\$PKG_DIR"		
		inetc::get "https://buildbot.libretro.com/assets/frontend/autoconfig.zip" "$INSTDIR\$PKG_DIR\$PKGNAME" /END
		nsisunz::UnzipToLog "$INSTDIR\$PKG_DIR\$PKGNAME" "$INSTDIR\$PKG_DIR"
		Delete "$INSTDIR\$PKG_DIR\$PKGNAME"

	SectionEnd
	
	Section "cheats"
	
		AddSize 2000
	
		StrCpy $PKG_DIR "emulators\retroarch\cheats"
		StrCpy $PKGNAME "retroarch-cheats.zip"
		
		SetOutPath "$INSTDIR\$PKG_DIR"		
		inetc::get "https://buildbot.libretro.com/assets/frontend/cheats.zip" "$INSTDIR\$PKG_DIR\$PKGNAME" /END
		nsisunz::UnzipToLog "$INSTDIR\$PKG_DIR\$PKGNAME" "$INSTDIR\$PKG_DIR"
		Delete "$INSTDIR\$PKG_DIR\$PKGNAME"

	SectionEnd
	
	Section "database-cursors"
	
	SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}
	
		AddSize 100
	
		StrCpy $PKG_DIR "emulators\retroarch\database\cursors"
		StrCpy $PKGNAME "retroarch-database-cursors.zip"
		
		SetOutPath "$INSTDIR\$PKG_DIR"		
		inetc::get "https://buildbot.libretro.com/assets/frontend/database-cursors.zip" "$INSTDIR\$PKG_DIR\$PKGNAME" /END
		nsisunz::UnzipToLog "$INSTDIR\$PKG_DIR\$PKGNAME" "$INSTDIR\$PKG_DIR"
		Delete "$INSTDIR\$PKG_DIR\$PKGNAME"

	SectionEnd
	
		Section "database-rdb"
		
		SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}
		
		AddSize 65000
	
		StrCpy $PKG_DIR "emulators\retroarch\database\rdb"
		StrCpy $PKGNAME "retroarch-database-rdb.zip"
		
		SetOutPath "$INSTDIR\$PKG_DIR"		
		inetc::get "https://buildbot.libretro.com/assets/frontend/database-rdb.zip" "${DOWNLOAD_DIR}\$PKGNAME" /END
		nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$PKGNAME" "$INSTDIR\$PKG_DIR"
		Delete "${DOWNLOAD_DIR}\$PKGNAME"

	SectionEnd
	
	Section "info"
	
	SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}
	
		AddSize 150
	
		StrCpy $PKG_DIR "emulators\retroarch\info"
		StrCpy $PKGNAME "retroarch-info.zip"
		
		SetOutPath "$INSTDIR\$PKG_DIR"		
		inetc::get "https://buildbot.libretro.com/assets/frontend/info.zip" "${DOWNLOAD_DIR}\$PKGNAME" /END
		nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$PKGNAME" "$INSTDIR\$PKG_DIR"
		Delete "${DOWNLOAD_DIR}\$PKGNAME"

	SectionEnd
	
	Section "shaders"
	
	SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05} ${IT_REQUIRED_06}
	
		AddSize 70000
	
		StrCpy $PKG_DIR "system\shaders"
		StrCpy $PKGNAME "shaders.zip"
		
		SetOutPath "$INSTDIR\$PKG_DIR"		
		inetc::get "http://www.retrobat.ovh/repo/v3/shaders.zip" "${DOWNLOAD_DIR}\$PKGNAME" /END
		nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$PKGNAME" "$INSTDIR\$PKG_DIR"
		Delete "${DOWNLOAD_DIR}\$PKGNAME"

	SectionEnd
	
	Section "decorations"
	
	SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05} ${IT_REQUIRED_06}
	
		AddSize 280000
	
		StrCpy $PKG_DIR "decorations"
		StrCpy $PKGNAME "decorations.zip"
		
		SetOutPath "$INSTDIR\$PKG_DIR"		
		inetc::get "https://github.com/kaylh/RetroArch-Bezels/releases/download/1.0/retroarch-bezels.zip" "${DOWNLOAD_DIR}\$PKGNAME" /END
		nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$PKGNAME" "$INSTDIR\$PKG_DIR"
		Delete "${DOWNLOAD_DIR}\$PKGNAME"

	SectionEnd
	
SectionGroupEnd

SectionGroup "Libretro Cores Pack"

		Section "81"
		
		SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}
		
			AddSize 1500
		
			StrCpy $LRCORE "81"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd

/*		Section "4do"
		
		SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}
		
			AddSize 1500
		
			StrCpy $LRCORE "4do"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
*/		
		Section "atari800"
		
		SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}
		
			AddSize 1500
		
			StrCpy $LRCORE "atari800"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		Section "blastem"
		
		SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}

			AddSize 1500
		
			StrCpy $LRCORE "blastem"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		Section "bluemsx"
		
		SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}
		
			AddSize 1500
		
			StrCpy $LRCORE "bluemsx"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
SectionGroup "lr-bsnes"

		Section "bsnes"
		
		 
				
			AddSize 1500
		
			StrCpy $LRCORE "bsnes"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		Section "bsnes_hd"
		
		
		
			AddSize 1500
		
			StrCpy $LRCORE "bsnes_hd_beta"
			StrCpy $PKG_DIR "emulators\retroarch\cores" 
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		Section "bsnes2014_accuracy"
		
		 
		
			AddSize 1500
		
			StrCpy $LRCORE "bsnes_mercury_accuracy"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"			
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		Section "bsnes2014_balanced"
		
		 
		
			AddSize 1500
		
			StrCpy $LRCORE "bsnes2014_balanced"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"			
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		Section "bsnes2014_performance"
		
		 
		
			AddSize 1500
		
			StrCpy $LRCORE "bsnes2014_performance"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"			
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		Section "bsnes2014_cplusplus98"
		
		 
		
			AddSize 1500
		
			StrCpy $LRCORE "bsnes2014_cplusplus98"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"			
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		Section "bsnes_mercury_accuracy"
		
		SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}
		
			AddSize 1500
		
			StrCpy $LRCORE "bsnes_mercury_accuracy"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"			
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd

		Section "bsnes_mercury_balanced"
		
		 
				
			AddSize 1500

			StrCpy $LRCORE "bsnes_mercury_balanced"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"			
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd

		Section "bsnes_mercury_performance"
		
		 
		
			AddSize 1500

			StrCpy $LRCORE "bsnes_mercury_performance"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"			
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd

SectionGroupEnd

		Section "cap32"
		
		SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}
		
			AddSize 1500
		
			StrCpy $LRCORE "cap32"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		Section "citra"
		
		SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}
		
			AddSize 1500
		
			StrCpy $LRCORE "citra"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		Section "crocods"
		
		SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}
		
			AddSize 1500
		
			StrCpy $LRCORE "crocods"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		Section "desmume"
		
		SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}
		
			AddSize 1500
		
			StrCpy $LRCORE "desmume"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		Section "dolphin"
		
		SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}
		
			AddSize 1500
		
			StrCpy $LRCORE "dolphin"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		Section "emux_nes"
		
		 
		
			AddSize 1500
		
			StrCpy $LRCORE "emux_nes"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		Section "fceumm"
		
		 
		
			AddSize 1500
		
			StrCpy $LRCORE "fceumm"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		Section "ffmpeg"
		
		SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}
		
			AddSize 1500
		
			StrCpy $LRCORE "ffmpeg"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		SectionGroup "lr-finalburn"

		Section "fbneo"
		
		SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}
		
			AddSize 1500
		
			StrCpy $LRCORE "fbneo"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd

		Section "fbalpha2012"
		
		SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}
		
			AddSize 1500
		
			StrCpy $LRCORE "fbalpha2012"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd

		Section "fbalpha2012_neogeo"
		
		SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}
		
			AddSize 1500
		
			StrCpy $LRCORE "fbalpha2012_neogeo"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"			
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd

		Section "fbalpha2012_cps1"
		
		
			AddSize 1500

			StrCpy $LRCORE "fbalpha2012_cps1"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"			
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd

		Section "fbalpha2012_cps2"
		
		
			AddSize 1500

			StrCpy $LRCORE "fbalpha2012_cps2"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"			
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd

	SectionGroupEnd
		
		Section "flycast"
		
		SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}
		
			AddSize 1500
		
			StrCpy $LRCORE "flycast"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		Section "flycast_gles2"
		
		
			AddSize 1500
		
			StrCpy $LRCORE "flycast_gles2"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		Section "fmsx"
		
		SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}
		
			AddSize 1500
		
			StrCpy $LRCORE "fmsx"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		Section "freeintv"
		
		SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}
		
			AddSize 1500
		
			StrCpy $LRCORE "freeintv"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		Section "fuse"
		
		SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}
		
			AddSize 1500
		
			StrCpy $LRCORE "fuse"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		Section "gambatte"
		
		SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}
		
			AddSize 1500
		
			StrCpy $LRCORE "gambatte"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		Section "gearboy"
		
		SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}
		
			AddSize 1500
		
			StrCpy $LRCORE "gearboy"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		Section "gearsystem"
		
		SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}
		
			AddSize 1500
		
			StrCpy $LRCORE "gearsystem"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		Section "genesis_plus_gx"
		
		SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}
		
			AddSize 1500
		
			StrCpy $LRCORE "genesis_plus_gx"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		Section "gw"
		
		SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}
		
			AddSize 1500
		
			StrCpy $LRCORE "gw"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		Section "handy"
		
		SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}
		
			AddSize 1500
		
			StrCpy $LRCORE "handy"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		Section "hatari"
		
		SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}
		
			AddSize 1500
		
			StrCpy $LRCORE "hatari"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		Section "higan_sfc"
		
			AddSize 1500
		
			StrCpy $LRCORE "higan_sfc"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		Section "kronos"
		
		SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}
		
			AddSize 1500
		
			StrCpy $LRCORE "kronos"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		SectionGroup "lr-mame"
		
		Section "mame"
		
		
			AddSize 300000
		
			StrCpy $LRCORE "mame"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"			
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		Section "mame2016"
		
		SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}
		
			AddSize 250000
		
			StrCpy $LRCORE "mame2016"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		Section "mame2015"

		
			AddSize 1500
		
			StrCpy $LRCORE "mame2015"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd

		Section "mame2003_plus"
		
		SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}
		
			AddSize 1500
		
			StrCpy $LRCORE "mame2003_plus"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		Section "mame2003"

		
			AddSize 1500
		
			StrCpy $LRCORE "mame2003"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		Section "mame2000"
		
			AddSize 1500
		
			StrCpy $LRCORE "mame2000"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd

	SectionGroupEnd
		
		Section "mednafen_gba"
		
		SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}
		
			AddSize 1500
		
			StrCpy $LRCORE "mednafen_gba"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		Section "mednafen_lynx"
		
		SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}
		
			AddSize 1500
		
			StrCpy $LRCORE "mednafen_lynx"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		Section "mednafen_ngp"
		
		SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}
		
			AddSize 1500
		
			StrCpy $LRCORE "mednafen_ngp"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		Section "mednafen_pce_fast"
		
		SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}
		
			AddSize 1500
		
			StrCpy $LRCORE "mednafen_pce_fast"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		Section "mednafen_pce"
		
		SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}
		
			AddSize 1500
		
			StrCpy $LRCORE "mednafen_pce"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		Section "mednafen_psx_hw"
		
		SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}
		
			AddSize 1500
		
			StrCpy $LRCORE "mednafen_psx_hw"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		Section "mednafen_psx"
		
		SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}
		
			AddSize 1500
		
			StrCpy $LRCORE "mednafen_psx"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		Section "mednafen_saturn"
		
		SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}
		
			AddSize 1500
		
			StrCpy $LRCORE "mednafen_saturn"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		Section "mednafen_supergrafx"
		
		SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}
		
			AddSize 1500
		
			StrCpy $LRCORE "mednafen_supergrafx"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		Section "mednafen_vb"
		
		SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}
		
			AddSize 1500
		
			StrCpy $LRCORE "mednafen_vb"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		Section "mednafen_wswan"
		
		SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}
		
			AddSize 1500
		
			StrCpy $LRCORE "mednafen_wswan"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		Section "mesen"
		
			AddSize 1500
		
			StrCpy $LRCORE "mesen"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		Section "mgba"
		
		SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}
		
			AddSize 1500
		
			StrCpy $LRCORE "mgba"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		Section "mupen64plus_next"
		
		SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}
		
			AddSize 1500
		
			StrCpy $LRCORE "mupen64plus_next"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		Section "mupen64plus_next_gles3" 
		
			AddSize 1500
		
			StrCpy $LRCORE "mupen64plus_next_gles3"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		Section "nestopia"
		
		SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}
		
			AddSize 1500
		
			StrCpy $LRCORE "nestopia"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		Section "nxengine"
		
		SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}
		
			AddSize 1500
		
			StrCpy $LRCORE "nxengine"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		Section "o2em"
		
		SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}
		
			AddSize 1500
		
			StrCpy $LRCORE "o2em"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		Section "opera"
		
			AddSize 1500
		
			StrCpy $LRCORE "opera"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		Section "parallel_n64"
		
			AddSize 1500
		
			StrCpy $LRCORE "parallel_n64"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		Section "picodrive"
		
		SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}
		
			AddSize 1500
		
			StrCpy $LRCORE "picodrive"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		Section "play"
		
		SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}
		
			AddSize 1500
		
			StrCpy $LRCORE "play"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		Section "ppsspp"
		
		SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}
		
			AddSize 1500
		
			StrCpy $LRCORE "ppsspp"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		Section "prosystem"
		
		SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}
		
			AddSize 1500
		
			StrCpy $LRCORE "prosystem"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		Section "puae"
		
		SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}
		
			AddSize 1500
		
			StrCpy $LRCORE "puae"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		Section "quicknes"
		
		SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}
		
			AddSize 1500
		
			StrCpy $LRCORE "quicknes"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		Section "redream" 
		
			AddSize 1500
		
			StrCpy $LRCORE "redream"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		Section "scummvm"
		
		SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}
		
			AddSize 1500
		
			StrCpy $LRCORE "scummvm"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd

		Section "snes9x"
		
		SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}
		
			AddSize 1500
		
			StrCpy $LRCORE "snes9x"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		Section "stella"
		
		SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}
		
			AddSize 1500
		
			StrCpy $LRCORE "stella"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		Section "tgbdual"
		
		SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}
		
			AddSize 1500
		
			StrCpy $LRCORE "tgbdual"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		Section "vecx"
		
		SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}
		
			AddSize 1500
		
			StrCpy $LRCORE "vecx"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		Section "vice_x64"
		
		SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}
		
			AddSize 1500
		
			StrCpy $LRCORE "vice_x64"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		Section "vice_x64sc"
		
		SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}
		
			AddSize 1500
		
			StrCpy $LRCORE "vice_x64sc"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		Section "vice_xvic"
		
		SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}
		
			AddSize 1500
		
			StrCpy $LRCORE "vice_xvic"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		Section "vice_x128"
		
		SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}
		
			AddSize 1500
		
			StrCpy $LRCORE "vice_x128"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		Section "vice_xpet"
		
		SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}
		
			AddSize 1500
		
			StrCpy $LRCORE "vice_xpet"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		Section "virtualjaguar"
		
		SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}
		
			AddSize 1500
		
			StrCpy $LRCORE "virtualjaguar"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		Section "yabause"
		
		SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}
		
			AddSize 1500
		
			StrCpy $LRCORE "yabause"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd
		
		Section "yabasanshiro"
		
		SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}
		
			AddSize 1500
		
			StrCpy $LRCORE "yabasanshiro"
			StrCpy $PKG_DIR "emulators\retroarch\cores"
			SetOutPath "$INSTDIR\emulators\retroarch\cores"
			inetc::get "https://buildbot.libretro.com/nightly/windows/${OS_ARCHITECTURE}/latest/$LRCORE_libretro.dll.zip" "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" /END
			nsisunz::UnzipToLog "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip" "$INSTDIR\$PKG_DIR"		
			Delete "$INSTDIR\emulators\retroarch\cores\$LRCORE_libretro.dll.zip"

		SectionEnd

SectionGroupEnd

	Section "DOSBox"
	
	SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05}
						
	AddSize 3000
		
	StrCpy $PKG_DIR "emulators\dosbox"
	StrCpy $PKGNAME "dosbox.zip"
	
	SetOutPath "${DOWNLOAD_DIR}"		
	inetc::get "https://www.retrobat.ovh/repo/v3/dosbox.zip" "${DOWNLOAD_DIR}\$PKGNAME" /END
	nsisunz::UnzipToLog "${DOWNLOAD_DIR}\$PKGNAME" "$INSTDIR\emulators\dosbox"
	Delete "${DOWNLOAD_DIR}\$PKGNAME"

	SectionEnd

SectionGroupEnd

Section "Desktop Shortcut" SectionS

;	SectionInstType ${IT_REQUIRED_01} ${IT_REQUIRED_02} ${IT_REQUIRED_03} ${IT_REQUIRED_04} ${IT_REQUIRED_05} ${IT_REQUIRED_06}

	SetShellVarContext current
	SetOutPath "$INSTDIR"
	CreateShortCut "$DESKTOP\RetroBat.lnk" "$INSTDIR\retro.bat" "" "$INSTDIR\system\resources\retrobat.ico"

SectionEnd

/*
Function .onInit

  SectionSetText 01 "Install required components of RetroBat."
  
FunctionEnd
*/

/*  
Function PostInstallTasks
  
  SetOutPath $EXEDIR
  nsExec::ExecToLog /TIMEOUT=10000 '"$EXEDIR\retro.bat"'
  Pop $0
  Pop $1
  SetOutPath $INSTDIR

  SetOutPath $INSTDIR
  nsExec::ExecToLog /TIMEOUT=3000 '"$INSTDIR\retro.bat"'
  Pop $0
  Pop $1
  SetOutPath $INSTDIR
  
FunctionEnd
*/

  !define MUI_CUSTOMFUNCTION_ABORT onUserAbort
  Function onUserAbort
    ${If} ${Cmd} `MessageBox MB_YESNO|MB_DEFBUTTON2 "${MUI_ABORTWARNING_TEXT}" IDYES`
      MessageBox MB_OK "User aborted installation.  Your code goes here"
    ${Else}
      /*
        See the documentation for .onUserAbort as to why Abort is called here.
      */
      Abort
    ${EndIf}
  FunctionEnd
    
/*
Function .onInstSuccess

  SetOutPath $INSTDIR
  ExecWait '"$INSTDIR\retro.bat"'
  SetOutPath $INSTDIR


  SetOutPath $EXEDIR
  ExecWait '"$EXEDIR\retro.bat"'
  SetOutPath $INSTDIR

;  ExecShell "open" "${AFTER_INSTALLATION_URL}"

FunctionEnd
*/
Name "nsis7zsample"

; The file to write
OutFile "nsis7zsample.exe"

; The default installation directory
InstallDir "C:\Utils"

; Request application privileges for Windows Vista
RequestExecutionLevel user

!addplugindir "..\Debug"
!addplugindir "."

; No need to compress twice!
SetCompress off

Function CallbackTest
  Pop $R8
  Pop $R9

  SetDetailsPrint textonly
  DetailPrint "Extracting $R8 / $R9..."
  SetDetailsPrint both
FunctionEnd

; The stuff to install
Section "" ;No components page, name is not important

  ; Set output path to the installation directory.
  SetOutPath $INSTDIR
  SetCompress off
  DetailPrint "Extracting package..."
  SetDetailsPrint listonly
  File Test.7z
  SetCompress auto
;  File /nonfatal /oname=$PLUGINSDIR\nsis7z.pdb Release\nsis7z.pdb
  SetDetailsPrint both

  ; Usual mode - set unpacking prompt using DetailPrint,
  ; plugin will animate progress bar
;  DetailPrint "Installing package..."
;  Nsis7z::Extract "$INSTDIR\Test.7z" 

  ; Details mode - unpacking promt generated from second param, use
  ; %s to insert unpack details like "10% (5 / 10 MB)"
;  Nsis7z::ExtractWithDetails "$INSTDIR\Test.7z" "Installing package %s..."

  ; Callback mode - plugin will animate progress bar, you can do
  ; anything in callback function
  GetFunctionAddress $R9 CallbackTest
  Nsis7z::ExtractWithCallback "$INSTDIR\Test.7z" $R9

  Delete "$OUTDIR\Test.7z"  
SectionEnd ; end the section

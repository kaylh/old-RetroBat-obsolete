// MainAr.cpp

#include "StdAfx.h"

// #include <locale.h>

#include "../../../Common/Common.h"

#include "Windows/ErrorMsg.h"

#include "Common/StdOutStream.h"
#include "Common/NewHandler.h"
#include "Common/MyException.h"
#include "Common/StringConvert.h"

#include "../Common/ExitCode.h"
#include "../Common/ArchiveCommandLine.h"
#include "ExtractCallbackConsole.h"
#include "NSISBreak.h"

using namespace NWindows;

#ifdef _WIN32

#pragma warning(disable : 4996)

#ifndef _UNICODE
bool g_IsNT = false;
#endif
#if !defined(_UNICODE) || !defined(_WIN64)
static inline bool IsItWindowsNT()
{
  OSVERSIONINFO versionInfo;
  versionInfo.dwOSVersionInfoSize = sizeof(versionInfo);
  if (!::GetVersionEx(&versionInfo))
    return false;
  return (versionInfo.dwPlatformId == VER_PLATFORM_WIN32_NT);
}
#endif
#endif

void DoInitialize()
{
  #ifdef _WIN32
  
  #ifdef _UNICODE
  #ifndef _WIN64
  if (!IsItWindowsNT())
  {
    //(*g_StdStream) << "This program requires Windows NT/2000/2003/2008/XP/Vista";
   // return NExitCode::kFatalError;
	  return;
  }
  #endif
  #else
  g_IsNT = IsItWindowsNT();
  #endif
  
  #endif
}


extern int DoExtractArchive(UString archive, UString targetDir, bool overwrite, bool extractPathes, ExtractProgressHandler epc);

int DoExtract(LPTSTR archive, LPTSTR dir, bool overwrite, bool expath, ExtractProgressHandler epc)
{
  int res = 0;
  try
  {
#ifdef UNICODE
	  UString uarchive(archive);
	  UString udir(dir);
#else
	  UString uarchive = MultiByteToUnicodeString(AString(archive));	
	  UString udir = MultiByteToUnicodeString(AString(dir));
#endif
	res = DoExtractArchive(uarchive, udir, overwrite, expath, epc);
  }
  catch(...)
  {
    return -1;
  }
  return  res;
}

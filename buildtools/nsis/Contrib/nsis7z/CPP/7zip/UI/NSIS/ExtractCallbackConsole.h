// ExtractCallbackConsole.h

#ifndef __EXTRACTCALLBACKCONSOLE_H
#define __EXTRACTCALLBACKCONSOLE_H

#include "Common/MyString.h"
#include "Common/StdOutStream.h"
#include "../../Common/FileStreams.h"
#include "../../IPassword.h"
#include "../../Archive/IArchive.h"
#include "../Common/ArchiveExtractCallback.h"
#include "../Console/OpenCallbackConsole.h"

typedef void (*ExtractProgressHandler)(UInt64 completedSize, UInt64 totalSize);

class CExtractCallbackConsole:
  public IExtractCallbackUI,
  #ifndef _NO_CRYPTO
  public ICryptoGetTextPassword,
  #endif
  public COpenCallbackConsole,
  public CMyUnknownImp
{
public:
  MY_QUERYINTERFACE_BEGIN2(IFolderArchiveExtractCallback)
  #ifndef _NO_CRYPTO
  MY_QUERYINTERFACE_ENTRY(ICryptoGetTextPassword)
  #endif
  MY_QUERYINTERFACE_END
  MY_ADDREF_RELEASE

  STDMETHOD(SetTotal)(UInt64 total);
  STDMETHOD(SetCompleted)(const UInt64 *completeValue);

  // IFolderArchiveExtractCallback
  STDMETHOD(AskOverwrite)(
      const wchar_t *existName, const FILETIME *existTime, const UInt64 *existSize,
      const wchar_t *newName, const FILETIME *newTime, const UInt64 *newSize,
      Int32 *answer);
  STDMETHOD (PrepareOperation)(const wchar_t *name, Int32 isFolder, Int32 askExtractMode, const UInt64 *position);

  STDMETHOD(MessageError)(const wchar_t *message);
  STDMETHOD(SetOperationResult)(Int32 opRes, Int32 encrypted);

  HRESULT BeforeOpen(const wchar_t *name, bool testMode);
  HRESULT OpenResult(const CCodecs *codecs, const CArchiveLink &arcLink, const wchar_t *name, HRESULT result);
  HRESULT ThereAreNoFiles();
  HRESULT ExtractResult(HRESULT result);
 
  #ifndef _NO_CRYPTO
  HRESULT SetPassword(const UString &password);
  STDMETHOD(CryptoGetTextPassword)(BSTR *password);

  bool PasswordIsDefined;
  UString Password;

  #endif
  
  UInt64 NumArchives;
  UInt64 NumArchiveErrors;
  UInt64 NumFileErrors;
  UInt64 NumFileErrorsInCurrentArchive;

  CStdOutStream *OutStream;

  UInt64 totalSize, completedSize, lastVal;

  ExtractProgressHandler ProgressHandler;

  void Init()
  {
    NumArchives = 0;
    NumArchiveErrors = 0;
    NumFileErrors = 0;
    NumFileErrorsInCurrentArchive = 0;

	  totalSize = (UInt64)-1;
	  completedSize = 0;
		lastVal = 0;
  }

  void UpdateProgress();

};

#endif

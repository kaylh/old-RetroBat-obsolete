// ExtractCallbackConsole.h

#include "StdAfx.h"

#include "../../../Common/Common.h"
#include "ExtractCallbackConsole.h"
#include "UserInputUtils2.h"
#include "NSISBreak.h"

#include "Common/Wildcard.h"

#include "Windows/FileDir.h"
#include "Windows/FileFind.h"
#include "Windows/TimeUtils.h"
#include "Windows/Defs.h"
#include "Windows/PropVariant.h"
#include "Windows/ErrorMsg.h"
#include "Windows/PropVariantConv.h"

#include "../../Common/FilePathAutoRename.h"

#include "../Common/ExtractingFilePath.h"

using namespace NWindows;
using namespace NFile;
using namespace NDir;

extern HWND g_hwndProgress;

void CExtractCallbackConsole::UpdateProgress()
{
	if (ProgressHandler != NULL)
	{
		if (completedSize != -1 || totalSize > 0)
			ProgressHandler(completedSize, totalSize);
		else
			ProgressHandler(0, 0);
	}
}

STDMETHODIMP CExtractCallbackConsole::SetTotal(UInt64 val)
{
  totalSize = val;
  UpdateProgress();
  if (NNSISBreak::TestBreakSignal())
    return E_ABORT;
  return S_OK;
}

STDMETHODIMP CExtractCallbackConsole::SetCompleted(const UInt64 *val)
{
  completedSize = *val;
  UpdateProgress();
  if (NNSISBreak::TestBreakSignal())
    return E_ABORT;
  return S_OK;
}

STDMETHODIMP CExtractCallbackConsole::AskOverwrite(
    const wchar_t *existName, const FILETIME *, const UInt64 *,
    const wchar_t *newName, const FILETIME *, const UInt64 *,
    Int32 *answer)
{
 *answer = NOverwriteAnswer::kYesToAll;
  return S_OK;
}

STDMETHODIMP CExtractCallbackConsole::PrepareOperation(const wchar_t *name, Int32 isFolder, Int32 askExtractMode, const UInt64 *position)
{
  return S_OK;
}

STDMETHODIMP CExtractCallbackConsole::MessageError(const wchar_t *message)
{
  NumFileErrorsInCurrentArchive++;
  NumFileErrors++;
  return S_OK;
}

STDMETHODIMP CExtractCallbackConsole::SetOperationResult(Int32 opRes, Int32 encrypted)
{
  switch(opRes)
  {
    case NArchive::NExtract::NOperationResult::kOK:
      break;
    default:
    {
      NumFileErrorsInCurrentArchive++;
      NumFileErrors++;

    }
  }
  return S_OK;
}

#ifndef _NO_CRYPTO

HRESULT CExtractCallbackConsole::SetPassword(const UString &password)
{
  PasswordIsDefined = true;
  Password = password;
  return S_OK;
}

STDMETHODIMP CExtractCallbackConsole::CryptoGetTextPassword(BSTR *password)
{
  if (!PasswordIsDefined)
  {
    Password = GetPassword(OutStream);
    PasswordIsDefined = true;
  }
  return StringToBstr(Password, password);
}

#endif

HRESULT CExtractCallbackConsole::BeforeOpen(const wchar_t *name, bool testMode)
{
  NumArchives++;
  NumFileErrorsInCurrentArchive = 0;
  return S_OK;
}

HRESULT CExtractCallbackConsole::OpenResult(const CCodecs *codecs, const CArchiveLink &arcLink, const wchar_t *name, HRESULT result)
{
  if (result != S_OK)
  {
    NumArchiveErrors++;
  }
  return S_OK;
}
  
HRESULT CExtractCallbackConsole::ThereAreNoFiles()
{
  return S_OK;
}

HRESULT CExtractCallbackConsole::ExtractResult(HRESULT result)
{
  if (result == S_OK)
  {
    if (NumFileErrorsInCurrentArchive != 0)
    {
      NumArchiveErrors++;
    }
    return result;
  }
  NumArchiveErrors++;
  if (result == E_ABORT || result == ERROR_DISK_FULL)
    return result;
  return S_OK;
}

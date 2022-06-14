// UserInputUtils.h

#ifndef __USERINPUTUTILS_H
#define __USERINPUTUTILS_H

#include "Common/StdOutStream.h"

namespace NUserAnswerMode {

enum EEnum
{
  kYes,
  kNo,
  kYesAll,
  kNoAll,
  kAutoRename,
  kQuit
};
}

NUserAnswerMode::EEnum ScanUserYesNoAllQuit2(CStdOutStream *outStream);
UString GetPassword(CStdOutStream *outStream);

#endif

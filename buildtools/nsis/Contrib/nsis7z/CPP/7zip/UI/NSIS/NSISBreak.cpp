// ConsoleClose.cpp

#include "StdAfx.h"

#include "NSISBreak.h"

static int g_BreakCounter = 0;

namespace NNSISBreak {

void SendBreakSignal()
{
	g_BreakCounter++;
}

bool TestBreakSignal()
{
  /*
  if (g_BreakCounter > 0)
    return true;
  */
  return (g_BreakCounter > 0);
}

void CheckCtrlBreak()
{
  if (TestBreakSignal())
    throw CCtrlBreakException();
}

}

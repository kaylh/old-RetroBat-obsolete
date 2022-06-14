#ifndef __NSISBREAKUTILS_H
#define __NSISBREAKUTILS_H

namespace NNSISBreak {

bool TestBreakSignal();
void SendBreakSignal();

class CCtrlBreakException
{};

void CheckCtrlBreak();

}

#endif

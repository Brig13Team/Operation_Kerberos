#include "config\defineGrids.hpp"
#include "config\defineResColors.hpp"
#include "config\defineResIncl.hpp"
#include "config\defineResCommon.hpp"

#define RSC(VAR) TRIPLES(PREFIX,DLG,VAR)
#define APP(VAR) RSC(DOUBLES(COMPONENT,VAR))
#define QAPP(VAR) QUOTE(APP(VAR))
#define QRSC(VAR) QUOTE(RSC(VAR))

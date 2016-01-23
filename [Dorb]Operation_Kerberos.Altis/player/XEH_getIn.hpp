#define CBA_OFF
#include "script_component.hpp"
class Air {
    class ADDON {
        clientgetin = QUOTE([ARR_3((_this select 2),'_this call FUNC(EH_getIn)',_this)] call EFUNC(common,targetExec););
    };
};
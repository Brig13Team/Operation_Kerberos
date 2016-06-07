#define CBA_OFF
#include "script_component.hpp"
class ReammoBox_F {
    class ADDON {
        init = QUOTE([ARR_2('GVAR(setContainerWeight)',_this)] call CBA_fnc_localEvent;);
    };
};
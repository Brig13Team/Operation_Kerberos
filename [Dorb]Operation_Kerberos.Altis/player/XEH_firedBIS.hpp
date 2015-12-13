#define CBA_OFF
#include "script_component.hpp"

class CAManBase {
    class ADDON {
        scope = 2;
        clientfired = QUOTE(If (local (_this select 0)) then {_this spawn FUNC(EH_fired);};If ((hasinterface)&&(GVAR(suppression_active))) then {_this spawn FUNC(suppression_EH_fired);};);
    };
};
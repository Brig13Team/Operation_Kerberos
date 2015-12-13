#define CBA_OFF
#include "script_component.hpp"
class CAManBase {
    class ADDON {
        scope = 2;
        killed = QUOTE(If (isServer) then {_this call FUNC(EH_killed)};);
    };
};
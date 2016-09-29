#define CBA_OFF
#include "script_component.hpp"
class CAManBase {
    class ADDON {
        scope = 2;
        ClientKilled = QUOTE(_this call FUNC(XEH_killed));
    };
};

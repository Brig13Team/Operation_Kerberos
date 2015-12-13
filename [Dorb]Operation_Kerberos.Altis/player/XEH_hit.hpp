#define CBA_OFF
#include "script_component.hpp"
class CAManBase {
    class ADDON {
        scope = 2;
        clienthit = QUOTE(_this call FUNC(EH_hit););
    };
};
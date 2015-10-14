#define CBA_OFF
#include "script_component.hpp"
class Man {
    class ADDON {
        scope = 2;
        hitPart = QUOTE(_this call FUNC(EH_hitPart););
    };
};
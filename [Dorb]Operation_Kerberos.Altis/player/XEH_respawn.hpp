#define CBA_OFF
#include "script_component.hpp"
class B_Soldier_base_F {
    class ADDON {
        scope = 2;
        respawn = QUOTE(_this call FUNC(EH_respawn));
    };
};
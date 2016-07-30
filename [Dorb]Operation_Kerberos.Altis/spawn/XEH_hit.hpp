#define CBA_OFF
#include "script_component.hpp"
class LandVehicle {
    class ADDON {
        scope = 2;
        hit = QUOTE(_this call FUNC(EH_hit););
    };
};
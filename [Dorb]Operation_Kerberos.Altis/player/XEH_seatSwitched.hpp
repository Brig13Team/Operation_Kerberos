#define CBA_OFF
#include "script_component.hpp"
class Air {
    class ADDON {
        seatSwitched = QUOTE(_this call FUNC(EH_seatswitched););
    };
};
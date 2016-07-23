#define CBA_OFF
#include "script_component.hpp"
class Air {
    class ADDON {
        clientgetin = QUOTE( [ ARR_3( 'pilotcheck' , _this , (_this select 2) ) ] call CBA_fnc_targetEvent; );
    };
};

#define CBA_OFF
	#include "script_component.hpp"
#undef CBA_OFF
class B_Soldier_base_F {
    class Air {
        class ADDON {
            getin = "_this remoteExec ['dorb_player_fnc_onlypilots',(_this select 2)];";
        };
    };
};
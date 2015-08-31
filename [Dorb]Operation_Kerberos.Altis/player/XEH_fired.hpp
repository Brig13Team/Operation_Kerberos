#define CBA_OFF
	#include "script_component.hpp"
#undef CBA_OFF
class B_Soldier_base_F {
    class ADDON {
        scope = 2;
        fired = QUOTE(If (hasinterface) then {If (!local (_this select 0)) exitwith {};_this call FUNC(XEH_fired)};);
    };
};
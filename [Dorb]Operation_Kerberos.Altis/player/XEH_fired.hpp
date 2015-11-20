#define CBA_OFF
#include "script_component.hpp"
class B_Soldier_base_F {
    class ADDON {
        scope = 2;
        fired = QUOTE(If (hasinterface) then {If (GVAR(supression_active)) then {_this spawn FUNC(supression_EH_fired);};If (local (_this select 0)) then {_this spawn FUNC(EH_fired);};};);
    };
};
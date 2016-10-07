/*
 *  Author: Dorbedo
 *
 *  Description:
 *      initPost Events
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      none
 *
 */
#include "script_component.hpp"

If (isServer) then {
    ["rhs_p37", "initpost", {HASH_GET(GVAR(radars),"objects") pushBackUnique (_this select 0);},true,[],true] call CBA_fnc_addClassEventHandler;
    ["rhs_zsutank_base", "initpost", {_this call FUNC(registerAA);},true,[],true] call CBA_fnc_addClassEventHandler;
};

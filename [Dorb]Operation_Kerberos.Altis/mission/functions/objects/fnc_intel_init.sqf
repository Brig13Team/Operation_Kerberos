/*
    Author: iJesuz

    Description:
        This function should be called once!

*/
#include "script_component.hpp"

{
    private _action = [QGVAR(intel_take),localize "STR_DORB_MISSION_NEW_INTEL_TAKE","",{ [QGVAR(intel_found),[_target,profileName]] call CBA_fnc_globalEvent; },{ true }] call ace_interact_menu_fnc_createAction;
    [_x,0,["ACE_MainActions"],_action] call ace_interact_menu_fnc_addActionToClass;
} forEach _this;

/*
    Author: iJesuz

    Description:
        init intel actions

*/
#include "script_component.hpp"

{
    private _action = [QGVAR(intel_take),localize "STR_DORB_MISSION_SIDE_AIRCRAFT_INTEL_TAKE","",{
        deleteVehicle _target;
        missionNamespace setVariable [QGVAR(found_intel), (missionNamespace getVariable [QGVAR(found_intel),0]) + 1, true];
    },{ true }] call ace_interact_menu_fnc_createAction;
    [_x,0,["ACE_MainActions"],_action] call ace_interact_menu_fnc_addActionToClass;
} forEach _this;

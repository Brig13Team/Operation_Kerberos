/*
    Author: iJesuz

    Description:
        called via XEH_INIT

*/
#include "script_component.hpp"

_this params [["_obj",objNull,[objNull]]];

if (isServer) exitWith {};

private _action = [QGVAR(intel_take),localize "STR_DORB_MISSION_SIDE_AIRCRAFT_INTEL_TAKE","",{ deleteVehicle _target; missionNamespace setVariable [QGVAR(found_intel), (missionNamespace getVariable [QGVAR(found_intel),0]) + 1, true]; },{ true }] call ace_interact_menu_fnc_createAction;
[_obj,0,["ACE_MainActions"],_action] call ace_interact_menu_fnc_addActionToObject;

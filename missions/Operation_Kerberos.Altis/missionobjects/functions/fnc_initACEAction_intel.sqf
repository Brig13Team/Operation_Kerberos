/*
 *  Author: iJesuz
 *
 *  Description:
 *      init ace actions for intel objects
 *      (it's called once from clientPostInit)
 *
 *  Parameter(s):
 *      -
 *
 *  Returns:
 *      -
 */
#include "script_component.hpp"

private _action = [
    QGVAR(takeIntel),
    localize LSTRING(OBJECTS_INTEL_GRAB),
    "",
    { [QEFUNC(mission,statemachine_increaseCounter),[_target]] call CBA_fnc_serverEvent;_target setVariable [QEGVAR(mission,isActive),false,true];}, //TODO make it failproof
    { _target getVariable [QEGVAR(mission,isActive),true]; }
] call ace_interact_menu_fnc_createAction;

params ["_classes"];

{
    [_x, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToClass;
} forEach _classes;

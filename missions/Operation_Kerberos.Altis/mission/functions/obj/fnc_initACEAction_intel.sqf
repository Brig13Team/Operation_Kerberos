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
    { [QFUNC(obj__increaseCounter),[_target]] call CBA_fnc_serverEvent;_target setVariable [QGVAR(isActive),false,true];}, //TODO make it failproof
    { _target getVariable [QGVAR(isActive),true]; }
] call ace_interact_menu_fnc_createAction;

//private _classes = ["intel"] call FUNC(spawn_getObjects);
private _classes = ["Land_File1_F","Land_File2_F","Land_FilePhotos_F","Land_SatellitePhone_F","Land_MobilePhone_smart_F"];

{
    [_x, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToClass;
} forEach _classes;

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
    { [_target] call FUNC(obj__increaseCounter); deleteVehicle _target; },
    { true }
] call ace_interact_menu_fnc_createAction;

private _classes = ["intel"] call FUNC(spawn_getObjects);

{
    [_x, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToClass;
} forEach _classes;

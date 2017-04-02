/*
 *  Author: iJesuz
 *
 *  Description:
 *      init ace actions for device
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
    QGVAR(disableDevice),
    localize LSTRING(OBJECTS_DEVICE_DISABLE),
    "",
    {
        _target setVariable [QGVAR(isActive), false, true];
        [
            5,
            [_target],
            { (_this select 0) call FUNC(obj__increaseCounter); },
            { (_this select 0 select 0) setVariable [QGVAR(isActive), true, true]; },
            localize LSTRING(OBJECTS_DEVICE_DISABLING)
        ] call ace_common_fnc_progressBar;
    },
    { _target getVariable [QGVAR(isActive), false]; }
] call ace_interact_menu_fnc_createAction;

private _classes = ["device"] call FUNC(spawn_getObjects);
_classes = _classes + (["emp"] call FUNC(spawn_getObjects));

{
    [_x, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToClass;
} forEach _classes;

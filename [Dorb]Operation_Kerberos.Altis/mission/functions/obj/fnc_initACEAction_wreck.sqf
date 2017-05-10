/*
 *  Author: iJesuz
 *
 *  Description:
 *      init ace actions for wreck objects
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
    QGVAR(upload),
    localize LSTRING(OBJECTS_GATHER_INTEL),
    "",
    {
        _target setVariable [QGVAR(isActive), false, true];
        [
            30,
            [_target],
            { [QFUNC(obj__increaseCounter),[_this select 0]] call CBA_fnc_serverEvent;},
            { (_this select 0 select 0) setVariable [QGVAR(isActive), true, true]; },
            localize LSTRING(OBJECTS_GATHERING_INTEL)
        ] call ace_common_fnc_progressBar;
    },
    { (_target getVariable [QGVAR(isActive), false]) && (_target getVariable [QGVAR(isMissionTarget), false]) && (getDammage _target < 1) }
] call ace_interact_menu_fnc_createAction;

private _classes = ["wreck"] call FUNC(spawn_getObjects);

{
    [_x, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToClass;
} forEach _classes;

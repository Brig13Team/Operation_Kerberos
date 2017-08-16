/*
 *  Author: iJesuz
 *
 *  Description:
 *      init ace actions for upload objects
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
    localize LSTRING(OBJECTS_UPLOAD),
    "",
    {
        [
            120,
            [_target],
            {[QFUNC(obj__increaseCounter),_this select 0] call CBA_fnc_serverEvent; },
            {},
            localize LSTRING(OBJECTS_UPLOADING)
        ] call ace_common_fnc_progressBar;
    },
    { _target getVariable [QGVAR(isActive), false] }
] call ace_interact_menu_fnc_createAction;

//private _classes = ["upload"] call FUNC(spawn_getObjects);
private _classes = ["Land_Laptop_unfolded_F", "Land_Laptop_device_F"];

{
    [_x, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToClass;
} forEach _classes;

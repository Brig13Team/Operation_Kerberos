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
            30,
            [_target],
            { (_this select 0) call FUNC(obj__increaseCounter); },
            {},
            localize LSTRING(OBJECTS_UPLOADING)
        ] call ace_common_fnc_progressBar;
    },
    { true }
] call ace_interact_menu_fnc_createAction;

private _classes = ["upload"] call FUNC(spawn_getObjects);

{
    [_x, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToClass;
} forEach _classes;

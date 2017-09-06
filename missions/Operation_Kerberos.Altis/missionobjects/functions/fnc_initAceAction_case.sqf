/*
 *  Author: [Name of Author(s)]
 *
 *  Description:
 *      [Description]
 *
 *  Parameter(s):
 *      0 : [TYPE] - [argument name]
 *
 *  Returns:
 *      [TYPE] - [return name]
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_classes"];

{
    If (isNil QGVAR(obj_actionClasses_device)) then {
        GVAR(obj_actionClasses_device) = [];
    };
    If !(_x in GVAR(obj_actionClasses_device)) then {
        GVAR(obj_actionClasses_device) pushback _x;



        private _action = [
            QGVAR(case_carry),
            localize LSTRING(CASE_CARRY),
            "",
            LINKFUNC(doCarry),
            LINKFUNC(canCarry)
        ] call ace_interact_menu_fnc_createAction;
        [
            _x,
            0,
            ["ACE_MainActions"],
            _action
        ] call ace_interact_menu_fnc_addActionToClass;

    };
} forEach _classes;

If !(isNil QGVAR(obj_selfAction_case)) exitWith {};
GVAR(obj_selfAction_case) = true;


private _action = [
    QGVAR(case_Drop),
    localize LSTRING(CASE_DROP),
    "",
    LINKFUNC(doDrop),
    LINKFUNC(canDrop)
] call ace_interact_menu_fnc_createAction;
[
    ace_player,
    1,
    ["ACE_SelfActions"],
    _action
] call ace_interact_menu_fnc_addActionToObject;

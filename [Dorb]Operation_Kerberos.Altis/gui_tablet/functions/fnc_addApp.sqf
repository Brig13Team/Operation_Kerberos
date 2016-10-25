/*
 *  Author: Dorbedo
 *
 *  Description:
 *      add an App to the Tablet
 *
 *  Parameter(s):
 *      0 : STRING - display Name
 *      1 : CODE - function called on choosing
 *      2 : CODE - Condition to allow activation
 *      3 : STRING - Picture Path
 *
 *  Returns:
 *      none
 *
 */
#include "script_component.hpp"

_this params [
    ["_displayName","",[""]],
    ["_function",{},[{}]],
    ["_condition",{true},[{}]],
    ["_picture",QPATHTOF(data\ui\icon_empty.paa),[""]]
];

//// add Action

private _ACE_Action = [
    format [QGVAR(Action_%1),(count GVAR(Applications))],
    _displayName,
    _picture,
    _function,
    _condition
] call ace_interact_menu_fnc_createAction;

[ACE_Player, 1, ["ACE_SelfActions", QGVAR(selfactiongroup)], _ACE_Action] call ace_interact_menu_fnc_addActionToObject;



/// register into Display
GVAR(Applications) pushBack [_displayName,_function,_condition,_picture];




//

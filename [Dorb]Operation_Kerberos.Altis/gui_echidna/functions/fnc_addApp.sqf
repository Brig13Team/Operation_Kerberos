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
 *      4 : SCALAR - Picture Size (1,2,3) (small,long,big)
 *
 *  Returns:
 *      none
 *
 */
#include "script_component.hpp"
LOG_1(_this);
_this params [
    ["_displayName","",[""]],
    ["_func",{},[{}]],
    ["_condition",{true},[{}]],
    ["_picture",QPATHTOF(data\ui\icon_empty.paa),[""]],
    ["_size",1,[1]],
    ["_parameter",[],[[]]]
];

//// add Action

private _ACE_Action = [
    format [QGVAR(Action_%1),HASH_GET(GVAR(Applications),"index")],
    _displayName,
    _picture,
    _func,
    _condition
] call ace_interact_menu_fnc_createAction;

[ace_player, 1, ["ACE_SelfActions", QGVAR(selfactiongroup)], _ACE_Action] call ace_interact_menu_fnc_addActionToObject;


If !(_size in [1,2,3]) then {_size = 1;};

/// register into Display
[_displayName,_func,_condition,_picture,_size,_parameter] call FUNC(registerApp);

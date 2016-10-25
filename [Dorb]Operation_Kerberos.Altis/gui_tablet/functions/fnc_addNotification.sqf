/*
 *  Author: DOrbedo
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
#include "script_component.hpp"
_this params [
    ["_picture","",[""]],
    ["_condition",{},[{}]],
    ["_target",{},[{}]]
];
If (_picture isEqualTo "") exitWith {-1};
GVAR(lastNotification) = GVAR(lastNotification) + 1;
private _curNotification = GVAR(lastNotification);
HASH_SET(GVAR(notifications),format["%1",_curNotification],[_picture,_condition,_target]);

_curNotification;

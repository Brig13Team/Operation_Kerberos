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

if !(canSuspend) exitWIth {
    _this spawn FUNC(doCarry);
};


_this params["_suitcase","_carrier"];

_carrier action ["SwitchWeapon", _carrier, _carrier, 100];

uiSleep ANIM_TIME;

_suitcase attachTo [_carrier, ATTACH_POINT, "RightHand"];
_suitcase setDir 90;
_carrier forceWalk true;


_suitcase setVariable [QGVAR(obj_carrier),_carrier,true];
_carrier setVariable [QGVAR(obj_case),_suitcase];
_suitcase setVariable [QGVAR(obj_pickupPoint),getPosASL _suitcase,true];

[QGVAR(pickUpSuitcase), [_carrier,_suitcase]] call CBA_fnc_serverEvent;

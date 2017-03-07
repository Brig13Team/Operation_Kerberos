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

_this params ["_carrier"];

private _suitcase = _carrier getVariable [QGVAR(obj_case),objNull];
_carrier setVariable [QGVAR(obj_case),objNull];
CHECK(isNull _suitcase)

_suitcase setVariable [QGVAR(obj_carrier),objNull,true];
private _pos = ace_player getPos [0.3,(getDir player)+90];
detach _suitcase;
_suitcase setPos _pos;
_carrier forceWalk false;

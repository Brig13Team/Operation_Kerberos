/*
 *  Author: Dorbedo
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

_this params ["_vehicle"];

private _currentHash = (GVAR(fireCommands) deleteAt 0);

private _curPos = getPos _vehicle;
private _relPos = _currentHash getVariable ["dummyPosition",[]];
private _dummyPos = _curPos vectorAdd _relPos;

private _gunner = gunner _vehicle;
_gunner doWatch _dummyPos;
uisleep 2;
_gunner fireAtTarget [objNull];








//

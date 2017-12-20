/*
 *  Author: Dorbedo
 *
 *  Description:
 *      S&D has been finished
 *
 *  Parameter(s):
 *      0 : GROUP - the attacking group
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params ["_group"];

private _target = _group getVariable [QGVAR(target),locationNull];
[_target] call FUNC(strategy__onFinishSAD);

_group setVariable [QGVAR(target),locationNull];

/*
 *  Author: Dorbedo
 *
 *  Description:
 *      uses Infantery-attack
 *
 *  Parameter(s):
 *      0 : LOCATION - Attackposition
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

TRACEV_1(_this);
_this params ["_currentLocation","_strategyHash","_parameter"];
_parameter params ["_group"];

private _statementFinish = QUOTE(this call FUNC(strategy__onFinishSAD););

[_group,"attack",_currentLocation,_statementFinish] call FUNC(state_set);

_group setVariable [QGVAR(strategy),_strategyHash];

[count (units _group),_group];

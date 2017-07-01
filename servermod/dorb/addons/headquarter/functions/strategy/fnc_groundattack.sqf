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

_this params [["_currentLocation",locationNull,[locationNull]],"_strategyHash","_parameter"];
_parameter params ["_group"];

_group setVariable [QGVAR(strategy),_strategyHash];
_group setVariable [QGVAR(target),_currentLocation];

[count (units _group),_group];

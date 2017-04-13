/**
 *  Author: Dorbedo
 *
 *  Description:
 *      returns the player Value Coeff
 *
 *  Parameter(s):
 *      0 : OBJECT - the player - TODO make a player specific coeff
 *
 *  Returns:
 *      [TYPE] - [return name]
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

private _coeff = missionNamespace getVariable [QGVAR(playerCoeff),1];

_coeff max 0.5;

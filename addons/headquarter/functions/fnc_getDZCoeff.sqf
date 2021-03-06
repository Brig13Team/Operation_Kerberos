/**
 *  Author: Dorbedo
 *
 *  Description:
 *      returns the dangerzone Value Coeff
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

private _coeff = missionNamespace getVariable [QGVAR(DZCoeff),0.2];

_coeff min 1;

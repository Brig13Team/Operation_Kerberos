/**
 * Author: Dorbedo
 * hides the timer
 *
 * Arguments:
 * Nothing
 *
 * Return Value:
 * Nothing
 *
 */

#include "script_component.hpp"

GVAR(timerIsShown) = false;
([QGVAR(timer)] call BIS_fnc_rscLayer) cutText ["","PLAIN",0,true];

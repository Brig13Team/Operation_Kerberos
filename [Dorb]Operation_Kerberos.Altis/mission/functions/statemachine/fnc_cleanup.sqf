/*
*  Author: iJesuz, Dorbedo
 *
 *  Description:
 *      cleanup after the rtb has finished
 *
 *  Parameter(s):
 *      0 : LOCATION - the last MainMission
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params ["_mission"];

[QGVAR(end_server),[_mission]] call CBA_fnc_globalEvent;

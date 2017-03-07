/*
 *  Author: iJesuz
 *
 *  Description:
 *      Mission "Radar"
 *
 *  Parameter(s):
 *      0 : HASH    - mission hash
 *
 *  Returns:
 *      -
 */
#include "script_component.hpp"

_this params ["_mission", "_radar"];

[_mission, {
    (_this select 0) addEventHandler ["Killed", LINKFUNC(obj_onRadarDestroyed)];
}] call FUNC(mainmission__oneCounter);

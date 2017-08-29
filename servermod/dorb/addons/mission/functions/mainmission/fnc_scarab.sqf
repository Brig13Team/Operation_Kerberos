/*
 *  Author: iJesuz
 *
 *  Description:
 *      init mission "SCARAB"
 *
 *  Parameter(s):
 *      0 : HASH        - mission hash
 *      1 : [OBJECT]    - mission target
 *
 *  Returns:
 *      -
 */
#include "script_component.hpp"

_this params ["_mission", "_targets"];

{
    [_curTarget, GVARMAIN(side), false] call EFUNC(spawn,crew);
    {
        _x allowFleeing 0;
    } forEach (crew _x);
    (gunner _x) addEventHandler ["Killed", {
            [vehicle (_this select 0)] call FUNC(obj__increaseCounter);
        }];
    _x addEventHandler ["Killed", {
            private _mission = (_this select 0) getVariable [QGVAR(mission),locationNull];
            _mission setVariable ["progress","failed"];
            [getPos (_this select 0)] call FUNC(obj_spawnNuke);
        }];
} forEach _targets;

private _missionCfg = _mission getVariable "missioncfg";

[
    getNumber(_missionCfg >> "condition" >> "timer")
] call EFUNC(gui,setTimerGlobal);

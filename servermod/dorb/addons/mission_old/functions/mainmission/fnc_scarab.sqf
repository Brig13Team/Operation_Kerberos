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

    [_x, GVARMAIN(side), false] call EFUNC(spawn,crew);
    {
        _x allowFleeing 0;
    } forEach (crew _x);
    (gunner _x) addEventHandler ["Killed", {
            [vehicle (_this select 0)] call FUNC(statemachine_increaseCounter);
        }];
    _x addEventHandler ["Killed", {
            private _mission = (_this select 0) getVariable [QGVAR(mission),locationNull];
            if !((_mission getVariable ["progress","none"])=="failed") then {
                _mission setVariable ["progress","failed"];
                [getPos (_this select 0)] call EFUNC(missionobjects,spawnNuke);
            };
        }];
} forEach _targets;

private _missionCfg = _mission getVariable "missioncfg";


private _timeout = getNumber(_missionCfg >> "condition" >> "timeout");

[
    {
        ((_this select 0) getVariable ["timeout",-1])>0
    },
    {
        [_this select 1] call EFUNC(gui,setTimerGlobal);
    },
    [_mission,_timeout]
] call CBA_fnc_waitUntilAndExecute;

/*
 *  Author: Dorbedo
 *
 *  Description:
 *      called after the mission was created
 *
 *  Parameter(s):
 *      0 : ARRAY   - centerposition
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_centerposition",[],[[]]]];
TRACEV_1(_centerposition);

If (count _centerposition <3) then {_centerposition set[2,0];};
private _nearLoc = nearestLocations [_centerposition, ["NameCityCapital","NameCity","NameVillage"], 250];
TRACEV_1(_nearLoc);
If ((count _nearLoc)>1) then {
    [_centerposition,"",8] call FUNC(createMissionHouse);
    [_centerposition,2] call FUNC(spawnGroup_defence);
    for "_i" from 1 to 20 do {
        If ([] call FUNC(UnitLimit)) exitWith {TRACE("Unitlimit reached");};
        If ((_i mod 2)==0) then {
            [_centerposition,1] call FUNC(spawnGroup_patrol);
        }else{
            [_centerposition,1] call FUNC(spawnGroup_attack);
        };
    };
    [_centerposition,150,10] call FUNC(fallback_spawnDoorMines);
}else{
    [_centerposition,"",4] call FUNC(createMissionComposition);
    [_centerposition,2] call FUNC(spawnGroup_defence);
    for "_i" from 1 to 20 do {
        If ([] call FUNC(UnitLimit)) exitWith {TRACE("Unitlimit reached");};
        If ((_i mod 2)==0) then {
            [_centerposition,1] call FUNC(spawnGroup_patrol);
        }else{
            [_centerposition,1] call FUNC(spawnGroup_attack);
        };
    };
    [_centerposition,1500,0,8] call FUNC(spawnMinefieldACE);
};

_centerposition;

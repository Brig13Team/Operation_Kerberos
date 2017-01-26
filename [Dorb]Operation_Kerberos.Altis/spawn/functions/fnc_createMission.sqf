/*
 *  Author: Dorbedo
 *
 *  Description:
 *      called after the mission was created
 *
 *  Parameter(s):
 *      0 : ARRAY - Centerposition
 *
 *  Returns:
 *      none
 *
 */

#include "script_component.hpp"

_this params [["_centerposition",[],[[]]]];
TRACEV_1(_centerposition);
private _nearLoc = nearestLocations [_centerposition, ["NameCityCapital","NameCity","NameVillage"], 250];
TRACEV_1(_nearLoc);
If ((count _nearLoc)>1) then {
    [_centerposition,"",13] call FUNC(createMissionHouse);
    [_centerposition,3] call FUNC(spawnGroup_defence);
    for "_i" from 1 to 20 do {
        If ([] call FUNC(UnitLimit)) exitWith {};
        If ((_i mod 2)==0) then {
            [_centerposition,1] call FUNC(spawnGroup_patrol);
        }else{
            [_centerposition,1] call FUNC(spawnGroup_attack);
        };
    };
    [_centerposition,150,10] call FUNC(fallback_spawnDoorMines);
}else{
    [_centerposition,"",6] call FUNC(createMissionComposition);
    [_centerposition,6] call FUNC(spawnGroup_defence);
    for "_i" from 1 to 20 do {
        If ([] call FUNC(UnitLimit)) exitWith {};
        If ((_i mod 2)==0) then {
            [_centerposition,1] call FUNC(spawnGroup_patrol);
        }else{
            [_centerposition,1] call FUNC(spawnGroup_attack);
        };
    };
    [_centerposition,1500,8] call FUNC(createMinefields);
};

_centerposition;

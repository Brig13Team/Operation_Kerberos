/*
 *  Author: Dorbedo
 *
 *  Description:
 *      called after the mission was created
 *
 *  Parameter(s):
 *      0 : HASH    - mission hash
 *
 *  Returns:
 *      none
 *
 */
#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params ["_mission"];
private _centerposition = HASH_GET(_mission,"location") select 1;
TRACEV_1(_centerposition);

If (count _centerposition <3) then {_centerposition set[2,0];};
private _nearLoc = nearestLocations [_centerposition, ["NameCityCapital","NameCity","NameVillage"], 300];
TRACEV_1(_nearLoc);
If ((count _nearLoc)>0) then {
    [_centerposition,"",7] call FUNC(createMissionHouse);
    [_centerposition,2] call FUNC(spawnGroup_defence);
    for "_i" from 1 to 20 do {
        If ([] call FUNC(UnitLimit)) exitWith {TRACE("Unitlimit reached");};
        If ((_i mod 2)==0) then {
            [_centerposition,1] call FUNC(spawnGroup_patrol);
        }else{
            [_centerposition,1] call FUNC(spawnGroup_attack);
        };
    };
    //[_centerposition,150,10] call FUNC(fallback_spawnDoorMines);
    private _roadlist = [_centerposition] call FUNC(getRoadsInArea);
    private _amount = ceil((count _roadlist)*0.05);
    _roadlist = [_roadlist,_amount] call FUNC(spawnCivVehRoadside);
    TRACEV_1(_roadlist);
    [_roadlist,_amount] call FUNC(spawnRoadIEDs);
    [_centerposition,5] call FUNC(spawnCivCarGarage);
}else{
    [_centerposition,"",5] call FUNC(createMissionComposition);
    [_centerposition,3] call FUNC(spawnGroup_defence);
    for "_i" from 1 to 20 do {
        If ([] call FUNC(UnitLimit)) exitWith {TRACE("Unitlimit reached");};
        If ((_i mod 2)==0) then {
            [_centerposition,1] call FUNC(spawnGroup_patrol);
        }else{
            [_centerposition,1] call FUNC(spawnGroup_attack);
        };
    };
    [_centerposition,1500,0,8] call FUNC(spawnMinefieldACE);
    private _roadlist = [_centerposition] call FUNC(getRoadsInArea);
    private _amount = ceil(random 8);
    _roadlist = [_roadlist,_amount] call FUNC(spawnCivVehRoadside);
};

_centerposition;

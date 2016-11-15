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

private _nearLoc = nearestLocations [_centerposition, ["NameCityCapital","NameCity","NameVillage"], 250];

If ((count _nearLoc)>1) exitWith {
    [_centerposition,"",20] call FUNC(createMissionHouse);

    [_centerposition,3] call FUNC(spawnGroup_defence);
    private _spawnedUnits = (GVARMAIN(side) countSide allUnits);
    private _groupamount = floor(((150 - _spawnedUnits)/4)*0.3) + 1;

    [_centerposition,_groupamount] call FUNC(spawnGroup_patrol);
    [_centerposition,_groupamount*2] call FUNC(spawnGroup_attack);

};

[_centerposition,"",5] call FUNC(createMissionComposition);
[_centerposition,5] call FUNC(spawnGroup_defence);
[_centerposition,12] call FUNC(spawnGroup_patrol);
[_centerposition,12] call FUNC(spawnGroup_attack);

[_centerposition,1500,8] call FUNC(minefields);

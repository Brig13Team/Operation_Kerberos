/*
 *  Author: Dorbedo
 *
 *  Description:
 *      spawns the intel
 *
 *  Parameter(s):
 *      0 : ARRAY - centerposition
 *
 *  Returns:
 *      ARRAY - intel-objects
 *
 */
#include "script_component.hpp"

_this params [["_centerposition",[],[[]]]];

private _buildings = [_centerposition,280] call EFUNC(common,get_buildings);

private _possibleBuildings = [];

{
    private _temp = [_x,true] call FUNC(composition_chooseHouse);
    If !(_temp isEqualTo []) then {
        _possibleBuildings pushBack [_x,_temp];
    };
} forEach _buildings;

private _targetHouse = selectRandom _possibleBuildings;

private _targetPositions = _targetHouse call FUNC(composition_spawnHouse);

GVAR(targetHouses) pushBack _targetHouse;

private _targetPos = selectRandom _targetPositions;

_targetPos

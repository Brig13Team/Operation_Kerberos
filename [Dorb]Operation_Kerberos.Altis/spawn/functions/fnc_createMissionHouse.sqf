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

private _buildings = _centerposition nearObjects ["HouseBase", 280];
TRACEV_2(_centerposition,_buildings);
private _possibleBuildings = [];

{
    private _temp = [_x,true] call FUNC(composition_chooseHouse);
    //TRACEV_2(_temp,_x);
    If ((!isNil "_temp")&&{!isNull _temp}&&{!(_temp isEqualTo [])}) then {
        _possibleBuildings pushBack [_x,_temp];
    };
} forEach _buildings;
TRACEV_1(_possibleBuildings);
_possibleBuildings = _possibleBuildings - GVAR(targetHouses);
private _targetHouse = selectRandom _possibleBuildings;

private _targetPositions = _targetHouse call FUNC(composition_spawnHouse);
TRACEV_1(_targetPositions);
GVAR(targetHouses) pushBack _targetHouse;

_targetPositions;

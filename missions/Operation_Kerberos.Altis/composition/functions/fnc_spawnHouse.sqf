/**
 * Author: Dorbedo
 * creates a missionHouse Objective
 *
 * Arguments:
 * 0: <ARRAY> centerposition
 * 1: <STRING> missiontype
 * 2: <SCALAR> amount
 * 3: <SCALAR> radius
 * 4: <BOOL> return only position (default: true)
 *
 * Return Value:
 * <ARRAY> return Positions/Objectives
 *
 */

#include "script_component.hpp"

params [
    ["_centerpos", [], [[]], [2, 3]],
    ["_amount", 1, [0]],
    ["_radius", 300, [0]]
];

private _possibleHouses = [_centerpos, _radius, _amount, HASH_KEYS(GVAR(houses))] call FUNC(getRandomHouse);

{
    _x params ["_curHouse"];
    private _curHouseType = typeOf _curHouse;
    private _curCfg = selectRandom HASH_GET(GVAR(houses),_curHouseType);
    [_curCenter, _curHouse, _onlyPos] call FUNC(createMissionHouse);
} forEach _possibleHouses;

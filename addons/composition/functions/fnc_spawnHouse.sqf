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
TRACEV_3(_centerpos,_amount,_radius);

private _possibleHouses = [_centerpos, _radius, _amount, HASH_KEYS(GVAR(houses))] call FUNC(getRandomHouse);

{
    _x params [["_curHouse",objNull,[objNull]]];
    If !(isNull _curHouse) then {
        private _curHouseType = typeOf _curHouse;
        private _curCfg = selectRandom HASH_GET(GVAR(houses),_curHouseType);
        [_curHouse, _curCfg] call FUNC(createMissionHouse);
    };
} forEach _possibleHouses;

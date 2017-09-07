/**
 * Author: Dorbedo
 * creates a mission Objective
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
    ["_type", "", [""]],
    ["_amount", 1, [0]],
    ["_radius", 300, [0]],
    ["_onlyPos", true, [true]]
];

private _possibleCompositions = If (_onlyPos) then {
    GVAR(mission) select {(getText(_x >> "type") isEqualTo _type)};
} else {
    GVAR(mission) select {(getText(_x >> "type") isEqualTo _type)||{getText(_x >> "type") isEqualTo "%ALL"}};
};

private _possiblePositions = [_centerpos,_radius,_amount] call FUNC(getRandomPos);
private _return = [];
{
    _x params ["_curCenter","_curDir"];
    private _curCfg = selectRandom _possibleCompositions;
    private _temp = [_curCenter, _curCfg, _curDir, _onlyPos] call FUNC(createMissionComposition);
    _return append _temp;
} forEach _possiblePositions;

_return

#include "script_component.hpp"

/*
  Name: dorb_composition_fnc_spawnObjective
  Author: Dorbedo
  creats a mission objective

  Arguments:
    0: center position <ARRAY>
    1: mission type <STRING>
    2: amount <SCALAR>
    3: radius <SCALAR>
    4: return only position <BOOL> (default: true)

  Return Value:
    return positions/objectives <ARRAY>

  Public: Yes
*/

params [
    ["_centerpos", [], [[]], [2, 3]],
    ["_type", "", [""]],
    ["_amount", 1, [0]],
    ["_radius", 300, [0]],
    ["_onlyPos", true, [true]]
];

private _possibleCompositions = If !(_onlyPos) then {
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

TRACEV_6(_centerpos,_type,_amount,_radius,_onlyPos,_return);

_return

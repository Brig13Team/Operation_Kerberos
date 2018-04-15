#include "script_component.hpp"

/*
  Name: dorb_composition_fnc_spawn
  Author: Dorbedo
  creats a composition

  Arguments:
    0: center position <ARRAY>
    1: amount <SCALAR>
    2: radius <SCALAR>

  Return Value:
    return positions/objectives <ARRAY>

  Public: Yes
*/

params [
    ["_centerpos", [], [[]], [2, 3]],
    ["_amount", 1, [0]],
    ["_radius", 300, [0]]
];
TRACEV_3(_centerpos,_amount,_radius);

private _possiblePositions = [_centerpos,_radius,_amount] call FUNC(getRandomPos);
private _return = [];
{
    _x params ["_curCenter","_curDir"];
    private _curCfg = selectRandom GVAR(compositions);
    [_curCenter, _curCfg, _curDir] call FUNC(createMissionComposition);
} forEach _possiblePositions;

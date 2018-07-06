#include "script_component.hpp"

/*
  Name: dorb_composition_fnc_spawnEmplacement
  Author: Dorbedo
  spawns an emplacement in the field

  Arguments:
    0: center position <ARRAY>
    1: amount <SCALAR>
    2: radius <SCALAR>
    3: mission type <STRING>

  Return Value:
    return objectives <ARRAY>

  Public: Yes
*/

params [
    ["_centerpos", [], [[]], [2, 3]],
    ["_amount", 1, [0]],
    ["_radius", 300, [0]],
    ["_type", "", [""]]
];

private _possibleCompositions = if (_type isEqualTo "") then {
    GVAR(missioncompositions) select {(getText(_x >> "type") isEqualTo _type)};
} else {
    GVAR(compositions)
};

private _possiblePositions = [_centerpos,_radius,_amount] call FUNC(getRandomPos);
private _return = [];

{
    _x params ["_curCenter","_curDir"];
    private _curCfg = selectRandom _possibleCompositions;
    private _temp = [_curCenter, _curCfg, _curDir, false] call FUNC(createMissionComposition);
    _return append _temp;
} forEach _possiblePositions;

TRACEV_5(_centerpos,_type,_amount,_radius,_return);

_return

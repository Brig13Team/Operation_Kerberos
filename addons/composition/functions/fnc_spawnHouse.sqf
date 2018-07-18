#include "script_component.hpp"

/*
  Name: dorb_composition_fnc_spawnHouse
  Author: Dorbedo
  creates a mission house objective

  Arguments:
    0: center position <ARRAY>
    1: mission type <STRING>
    2: amount <SCALAR>
    3: radius <SCALAR>
    4: return only position <BOOL> (default: true)

  Return Value:
    return only positions/objectives <ARRAY>

  Public: Yes
*/

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
        TRACEV_3(_curHouse,_curCfg,_x);
        [_curHouse, _curCfg, false] call FUNC(createMissionHouse);
    };
} forEach _possibleHouses;

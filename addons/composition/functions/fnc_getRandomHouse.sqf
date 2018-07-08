#include "script_component.hpp"

/*
  Name: dorb_composition_fnc_getRandomHouse
  Author: Dorbedo
  return possible houses

  Arguments:
    0: center position <ARRAY>
    1: search radius <SCALAR>
    2: amount <SCALAR>
    3: housetypes <SCALAR>

  Return Value:
    array with houses <ARRAY>

  Public: No
*/

params [
    ["_centerpos", [], [[]], [2, 3]],
    ["_searchradius", 250, [0]],
    ["_amount", 1, [0]],
    ["_types", [], ["",[]]]
];

if (IS_STRING(_types)) then {
    _types = [_types];
};

private _typestoAdd = [];
{
    private _temp =+ ([_x] call FUNC(getSimilarHouses));
    _typesToAdd append _temp;
} forEach _types;

_types append _typesToAdd;
_types = _types arrayIntersect _types;

private _allHouses = _centerpos nearObjects ["House", _searchradius];
[_allHouses, true] call CBA_fnc_shuffle;
_types = _types apply {toLower _x};

private _return = _allHouses select {(toLower (typeof _x) in _types)&&{!(_x in GVAR(usedHouses))}};

If (count _return > _amount) then {
    _return resize _amount;
};

_return

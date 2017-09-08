/**
 * Author: Dorbedo
 * returns possible houses
 *
 * Arguments:
 * 0: <ARRAY> centerposition
 * 1: <SCALAR> searchradius
 * 2: <SCALAR> amount
 * 3: <SCALAR> missionhouse
 *
 * Return Value:
 * <TYPENAME> return name
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params [
    ["_centerpos", [], [[]], [2, 3]],
    ["_searchradius", 250, [0]],
    ["_amount", 1, [0]],
    ["_types", [], ["",[]]]
];

if (IS_STRING(_types)) then {
    _types = [_types];
};

private _allHouses = _centerpos nearObjects ["House", _searchradius];
[_allHouses, true] call CBA_fnc_shuffle;
_types = _types apply {toLower _x};

private _return = _allHouses select {(toLower (typeof _x) in _types)&&{!(_x in GVAR(usedHouses))}};
//TRACEV_2(_return,_allHouses);
_return resize _amount;
_return

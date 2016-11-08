/*
 *  Author: Dorbedo
 *
 *  Description:
 *      registers an app to a display and sorts
 *
 *  Parameter(s):
 *      0 : STRING - display Name
 *      1 : CODE - function called on choosing
 *      2 : CODE - Condition to allow activation
 *      3 : STRING - Picture Path
 *      4 : SCALAR - Picture Size (1,2,3) (small,long,big)
 *
 *  Returns:
 *      none
 *
 */
#include "script_component.hpp"
_this params ["_displayName","_function","_condition","_picture","_size"];

private _apps = HASH_GET(GVAR(applications),"0");

private _targetKey = "";
{
    private _key = _x;
    private _apps = HASH_GET(GVAR(applications),_key);
    If ((count _apps) < (28 * 0.6)) exitWith {_targetKey = _key;};
} forEach ["0","1","-1","2","-2"];

CHECK(_targetKey isEqualTo "")
/// 14x8
private _currentPage = HASH_GET(GVAR(Applications),_key);
private _usedGrids = [];

{
    private _curSize = _x param [4];
    private _grid = _x param [5];
    switch _curSize {
        case 3 : {
            _usedGrids pushBack format["%1_%2",[(_grid select 0),(_grid select 1)]];
            _usedGrids pushBack format["%1_%2",[(_grid select 0)+1,(_grid select 1)]];
            _usedGrids pushBack format["%1_%2",[(_grid select 0),(_grid select 1)+1]];
            _usedGrids pushBack format["%1_%2",[(_grid select 0)+1,(_grid select 1)+1]];
        };
        case 2 : {
            _usedGrids pushBack format["%1_%2",[(_grid select 0),(_grid select 1)]];
            _usedGrids pushBack format["%1_%2",[(_grid select 0)+1,(_grid select 1)]];
        };
        default {
            _usedGrids pushBack format["%1_%2",[(_grid select 0),(_grid select 1)]];
        };
    };
} forEach _currentPage;

private _grid = [];

for "_i" from 0 to 6 do {
    for "_j" from 0 to 3 {
        If ((_size == 3)&&
            {!(
                (format["%1_%2",_i,_j] in _usedGrids)||
                (format["%1_%2",_i+1,_j] in _usedGrids)||
                (format["%1_%2",_i,_j+1] in _usedGrids)||
                (format["%1_%2",_i+1,_j+1] in _usedGrids)
            )}
        ) then {_grid = [_i,_j]};
        If ((_size == 2)&&
            {!(
                (format["%1_%2",_i,_j] in _usedGrids)||
                (format["%1_%2",_i+1,_j] in _usedGrids)
            )}
        ) then {_grid = [_i,_j]};
        If ((_size == 1)&&
            {!(
                (format["%1_%2",_i,_j] in _usedGrids)
            )}
        ) then {_grid = [_i,_j]};
    };
};

CHECK(_grid isEqualTo [])

private _index = HASH_GET(GVAR(applications),"index");
HASH_SET(GVAR(Applications),"index",_index);
HASH_GET(GVAR(Applications),_key) pushBack [_displayName,_function,_condition,_picture,_size,_grid];

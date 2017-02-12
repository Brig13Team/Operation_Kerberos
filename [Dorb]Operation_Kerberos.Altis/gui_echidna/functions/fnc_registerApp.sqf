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
#define DEBUG_MODE_FULL
#include "script_component.hpp"
_this params ["_displayName","_function","_condition","_picture","_size",["_Page","0",[""]]];
LOG_6(_displayName,_func,_condition,_picture,_size,_page);

private _currentPage = HASH_GET(GVAR(Applications),_page);
private _usedGrids = [];

{
    private _curSize = _x param [4];
    private _grid = _x param [5];
    TRACEV_2(_curSize,_grid);
    switch _curSize do {
        case 3 : {
            _usedGrids pushBack format["%1_%2",(_grid select 0),(_grid select 1)];
            _usedGrids pushBack format["%1_%2",(_grid select 0)+1,(_grid select 1)];
            _usedGrids pushBack format["%1_%2",(_grid select 0),(_grid select 1)+1];
            _usedGrids pushBack format["%1_%2",(_grid select 0)+1,(_grid select 1)+1];
        };
        case 2 : {
            _usedGrids pushBack format["%1_%2",(_grid select 0),(_grid select 1)];
            _usedGrids pushBack format["%1_%2",(_grid select 0)+1,(_grid select 1)];
        };
        default {
            _usedGrids pushBack format["%1_%2",(_grid select 0),(_grid select 1)];
        };
    };
} forEach _currentPage;

TRACEV_2(_usedGrids,_currentPage);
private _grid = [];


for "_j" from 0 to 4 do {
    for "_i" from 0 to 2 do {
        If (_grid isEqualTo []) then {
            If ((_size == 3)&&
                {!(
                    (format["%1_%2",_i,_j] in _usedGrids)||
                    (format["%1_%2",_i+1,_j] in _usedGrids)||
                    (format["%1_%2",_i,_j+1] in _usedGrids)||
                    (format["%1_%2",_i+1,_j+1] in _usedGrids)
                )}&&
                {_i<2}&&
                {_j<4}
            ) then {_grid = [_i,_j]};
            If ((_size == 2)&&
                {!(
                    (format["%1_%2",_i,_j] in _usedGrids)||
                    (format["%1_%2",_i+1,_j] in _usedGrids)
                )}&&
                {_i<2}
            ) then {_grid = [_i,_j]};
            If ((_size == 1)&&
                {!(
                    (format["%1_%2",_i,_j] in _usedGrids)
                )}
            ) then {_grid = [_i,_j]};
        };
    };
};
LOG_1(_grid);
If (_grid isEqualTo []) exitWith {
    _page = format["%1",((parseNumber _page)+1)];
    [_displayName,_func,_condition,_picture,_size,_page] call FUNC(registerApp);
};

private _index = HASH_GET(GVAR(applications),"index");
HASH_SET(GVAR(Applications),"index",_index + 1);
HASH_GET(GVAR(Applications),_page) pushBack [_displayName,_function,_condition,_picture,_size,_grid];

/*
 *  Author: Dorbedo
 *
 *  Description:
 *      finds the peaks in the dangerzones
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      ARRAY - [[value,key], ... ]
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

#define MAXIMACOUNT 5

private _allKeys = HASH_KEYS(GVAR(dangerzones));

_allKeys = _allKeys select {IS_HASH(HASH_GET(GVAR(dangerzones),_x))};
private _maxima=[];
for "_i" from 0 to MAXIMACOUNT do {
    _maxima pushBack [0,""];
};

private _gridsize = HASH_GET(GVAR(dangerzones),"gridsize");

{
    private _curKey = _x;
    private _curVal = 0;
    private _namearray = _curKey splitString "_";
    
    _namearray params ["_xKey","_yKey"];
    _xKey = parseNumber _xKey;
    _yKey = parseNumber _yKey;
    {

        If (HASH_HASKEY(GVAR(dangerzones),_x)) then {
            _curVal = _curVal + HASH_GET_DEF(HASH_GET(GVAR(dangerzones),_curKey),"enemystrenght",0);
        };
    } forEach [
        format["%1_%2",_xKey,_yKey]
        ,format["%1_%2",_xKey+_gridsize,_yKey]
        ,format["%1_%2",_xKey-_gridsize,_yKey]
        ,format["%1_%2",_xKey,_yKey+_gridsize]
        ,format["%1_%2",_xKey,_yKey-_gridsize]/*
        ,format["%1_%2",_xKey+_gridsize,_yKey+_gridsize]
        ,format["%1_%2",_xKey-_gridsize,_yKey-_gridsize]
        ,format["%1_%2",_xKey+_gridsize,_yKey-_gridsize]
        ,format["%1_%2",_xKey-_gridsize,_yKey+_gridsize]*/
    ];
    _maxima pushBack [_curVal,format["%1_%2",_xKey,_yKey]];
    _maxima sort false;
    _maxima resize MAXIMACOUNT;
} forEach _allKeys;

_maxima sort false;
_maxima resize MAXIMACOUNT;

_maxima = _maxima - [[0,""]];
_maxima;





/*
private _gridsize = HASH_GET(GVAR(dangerzones),"gridsize");
private _keyamount = (HASH_GET(GVAR(dangerzones),"distance")*2)/_gridsize;


private _maxima=[];
for "_i" from 0 to MAXIMACOUNT do {
    _maxima pushBack [0,""];
};

private _fnc_getValue = {
    _this params ["_xVal","_yVal"];
    private _curKey = format["%1_%2",_xVal * _gridsize,_yVal * _gridsize];
    private _zoneHash = HASH_GET(GVAR(dangerzones),_curKey);
    If (isNil "_zoneHash") exitWith {0};
    private _value = HASH_GET(_zoneHash,"enemystrenght");
    If (isNil "_value") exitWith {0};
    _value;
};


private ["_last_maxima","_temp","_key"];
for "_x_key" from 0 to (_keyamount-1) do {
    _maxima sort false;
    _maxima resize MAXIMACOUNT;
    _last_maxima = (_maxima select (MAXIMACOUNT - 1))select 0;
    for "_y_key" from 0 to (_keyamount-1) do {
        _temp = ([_x_key,_y_key] call _fnc_getValue) +
            ([_x_key + 1,_y_key] call _fnc_getValue) +
            ([_x_key,_y_key+1] call _fnc_getValue) +
            ([_x_key-1,_y_key] call _fnc_getValue) +
            ([_x_key,_y_key-1] call _fnc_getValue);
        if ((_temp>_last_maxima)&&{!([_temp,format["%1_%2",_x_key,_y_key]] in _maxima)}) then {
                _maxima pushBack [_temp,format["%1_%2",_x_key,_y_key]];
        };
    };
};

for "_y_key" from 0 to (_keyamount-1) do {
    _maxima sort false;
    _maxima resize MAXIMACOUNT;
    _last_maxima = (_maxima select 4)select 0;
    for "_x_key" from 0 to (_keyamount-1) do {
        _temp = ([_x_key,_y_key] call _fnc_getValue) + ([_x_key + 1,_y_key] call _fnc_getValue) + ([_x_key,_y_key+1] call _fnc_getValue) + ([_x_key-1,_y_key] call _fnc_getValue) + ([_x_key,_y_key-1] call _fnc_getValue);
        if ((_temp>_last_maxima)&&{!([_temp,format["%1_%2",_x_key,_y_key]] in _maxima)}) then {
                _maxima pushBack [_temp,format["%1_%2",_x_key,_y_key]];
        };
    };
};

_maxima sort false;
_maxima resize MAXIMACOUNT;

// TODO - bad coding - needs rework - should do it for now


_maxima select {
    ((_x select 0)>0)&&
    (!((_x select 1) isEqualTo ""))
};
*/

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
            _curVal = _curVal + HASH_GET_DEF(HASH_GET(GVAR(dangerzones),_curKey),"enemystrength",0);
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

/*
 *  Author: Dorbedo
 *
 *  Description:
 *      reduces the DZ values at a attacklocation
 *
 *  Parameter(s):
 *      0 : LOCATION - the attacklocation
 *      0 : SCALAR - the factor to reduce (default:0 - sets the value to zero)
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"


_this params [["_attackLoc",locationNull,[locationNull]],["_factor",0,[0]]];
CHECK(isNull _attackLoc)

_factor = _factor min 1;

private _position = getPos _attackLoc;
private _gridsize = HASH_GET(GVAR(dangerzones),"gridsize");
private _curKey = [_position] call FUNC(dzconvert);
CHECK(_curKey isEqualTo "")
private _namearray = _curKey splitString "_";
_namearray params ["_xKey","_yKey"];
_xKey = parseNumber _xKey;
_yKey = parseNumber _yKey;
{
    private _curval = HASH_GET_DEF(HASH_GET_DEF(GVAR(dangerzones),_x,locationNull),"enemystrength",0) * _factor;
    // prevent stupid small values
    If (_curval < 100) then {_curval = 0;};

    HASH_SET(HASH_GET_DEF(GVAR(dangerzones),_x,"0_0"),"enemystrength",_curval);
} forEach [
    format["%1_%2",_xKey,_yKey]
    ,format["%1_%2",_xKey+_gridsize,_yKey]
    ,format["%1_%2",_xKey-_gridsize,_yKey]
    ,format["%1_%2",_xKey,_yKey+_gridsize]
    ,format["%1_%2",_xKey,_yKey-_gridsize]
    ,format["%1_%2",_xKey+_gridsize,_yKey+_gridsize]
    ,format["%1_%2",_xKey-_gridsize,_yKey-_gridsize]
    ,format["%1_%2",_xKey+_gridsize,_yKey-_gridsize]
    ,format["%1_%2",_xKey-_gridsize,_yKey+_gridsize]
];

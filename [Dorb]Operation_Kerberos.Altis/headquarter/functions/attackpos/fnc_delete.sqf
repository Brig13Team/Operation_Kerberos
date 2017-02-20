/*
 *  Author: Dorbedo
 *
 *  Description:
 *      deletes an attacklocation
 *
 *  Parameter(s):
 *      0 : LOCATION - the attacklocation to delete
 *
 *  Returns:
 *      none
 *
 */
#include "script_component.hpp"

_this params [["_location",locationNull,[locationNull]]];
TRACEV_1(_location);
CHECK(isNull _location)
private _position = getPos _location;
private _allAttackpos = HASH_GET(GVAR(attackPos),"locations");
_allAttackpos = _allAttackpos - [_location];
HASH_SET(GVAR(attackPos),"locations",_allAttackpos);


private _gridsize = HASH_GET(GVAR(dangerzones),"gridsize");
private _curKey = [_position] call FUNC(dzconvert);
private _namearray = _curKey splitString "_";
_namearray params ["_xKey","_yKey"];
_xKey = parseNumber _xKey;
_yKey = parseNumber _yKey;
{
    HASH_SET(GVAR(dangerzones),_x,0);
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

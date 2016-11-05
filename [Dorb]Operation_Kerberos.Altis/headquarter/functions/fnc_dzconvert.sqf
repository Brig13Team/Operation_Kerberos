/*
 *  Author: Dorbedo
 *
 *  Description:
 *       converts the positon into a dangerzone coordinate
 *       converts the dangerzine into a coordinate
 *
 *  Parameter(s):
 *      0 : ARRAY/STRING - Position to convert
 *
 *  Returns:
 *      STRING/ARRAY - converted position
 *
 */
#include "script_component.hpp"

_this params [["_position",[],[[],""],[2,3]]];
private _return = "";

If (_position isEqualTo []) exitWith {_return};

private _gridsize = HASH_GET(GVAR(dangerzone),"gridsize");
private _x = HASH_GET(GVAR(dangerzone),"x");
private _y = HASH_GET(GVAR(dangerzone),"y");

If (IS_ARRAY(_position)) then {
    If (    (((_position select 0)>(_x select 0))&&((_position select 0)<(_x select 1)))&&
            (((_position select 1)>(_y select 0))&&((_position select 1)<(_y select 1)))    ) then {
        _return = format["%1_%2",
            (floor((_position select 0)/_gridsize)*_gridsize) - (_x select 0),
            (floor((_position select 1)/_gridsize)*_gridsize) - (_y select 0)];
    };
}else{

    private _array = _position splitString "_";
    _array = _array apply {(parseNumber _x)+(_gridsize/2)};
    If (    (((_array select 0)>(_x select 0))&&((_array select 0)<(_x select 1)))&&
            (((_array select 1)>(_y select 0))&&((_array select 1)<(_y select 1)))    ) then {
        _return = [(_array select 0),(_array select 1),0];
    }else{
        _return = [0,0,0];
    };
};
_return;

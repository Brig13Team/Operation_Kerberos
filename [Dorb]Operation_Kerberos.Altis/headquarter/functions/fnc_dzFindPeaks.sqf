/*
    Author: Dorbedo

    Description:
        finds peaks in the dangerzones

    Parameter(s):

        0 : STRING - Variable name
        (optional)
        1 : NAMESPACE - Namepace

    Return:
        ARRAY - [[value,x,y], ... ]
*/

#include "script_component.hpp"
#define MAXIMACOUNT 5

private _keyamount = (HASH_GET(GVAR(dangerzones),"distance"))/(HASH_GET(GVAR(dangerzones),"gridsize"));

private _maxima=[];
for "_i" from 0 to MAXIMACOUNT do {
    _maxima pushBack [0,""];
};

private _fnc_getValue = {
    _this params ["_xVal","_yVal"];
    private _curKey = format["%1_%2",_xVal,_yVal];
    private _zoneHash = HASH_GET(GVAR(dangerzones),_curKey);
    If (isNil "_zoneHash") exitWith {0};
    private _value = HASH_GET(_zoneHash,"enemystrenght");
    If (isNil "_value") exitWith {0};
    _value;
};


private ["_last_maxima","_temp","_key"];
for "_x" from 0 to (_keyamount-1) do {
    _maxima sort false;
    _maxima resize MAXIMACOUNT;
    _last_maxima = (_maxima select (MAXIMACOUNT - 1))select 0;
    for "_y" from 0 to (_keyamount-1) do {
        /*
        _temp = ( HASH_GET_DEF( HASH_GET_DEF( GVAR(dangerzones),format[ARR_3("%1_%2",x,y)] ,locationNull) ,"enemystrenght" ,0) )+
            (
                if (_x>0) then {
                    HASH_GET_DEF( HASH_GET_DEF( GVAR(dangerzones),format[ARR_3("%1_%2",x-1,y)] ,locationNull) ,"enemystrenght" ,0)
                }else{0}
            )+
            (
                if (_y>0) then {
                    HASH_GET_DEF( HASH_GET_DEF( GVAR(dangerzones),format[ARR_3("%1_%2",x,y-1)] ,locationNull) ,"enemystrenght" ,0)
                }else{0}
            )+
            (
                if (_x<(_keyamount-1)) then {
                    HASH_GET_DEF( HASH_GET_DEF( GVAR(dangerzones),format[ARR_3("%1_%2",x+1,y)] ,locationNull) ,"enemystrenght" ,0)
                }else{0}
            )+
            (
                if (_y<(_keyamount-1)) then {
                    HASH_GET_DEF( HASH_GET_DEF( GVAR(dangerzones),format[ARR_3("%1_%2",x,y+1)] ,locationNull) ,"enemystrenght" ,0)
                }else{0}
            );
        */
        _temp = ([_x,_y] call _fnc_getValue) + ([_x + 1,_y] call _fnc_getValue) + ([_x,_y+1] call _fnc_getValue) + ([_x-1,_y] call _fnc_getValue) + ([_x,_y-1] call _fnc_getValue);
        if ((_temp>_last_maxima)&&{!([_temp,format["%1_%2",_x,_y]] in _maxima)}) then {
                _maxima pushBack [_temp,format["%1_%2",_x,_y]];
        };
    };
};

for "_y" from 0 to (_keyamount-1) do {
    _maxima sort false;
    _maxima resize MAXIMACOUNT;
    _last_maxima = (_maxima select 4)select 0;
    for "_x" from 0 to (_keyamount-1) do {
        /*
        _temp = ( HASH_GET_DEF( HASH_GET_DEF( GVAR(dangerzones),format[ARR_3("%1_%2",x,y)] ,locationNull) ,"enemystrenght" ,0) )+
            (
                if (_x>0) then {
                    HASH_GET_DEF( HASH_GET_DEF( GVAR(dangerzones),format[ARR_3("%1_%2",x-1,y)] ,locationNull) ,"enemystrenght" ,0)
                }else{0}
            )+
            (
                if (_y>0) then {
                    HASH_GET_DEF( HASH_GET_DEF( GVAR(dangerzones),format[ARR_3("%1_%2",x,y-1)] ,locationNull) ,"enemystrenght" ,0)
                }else{0}
            )+
            (
                if (_x<(_keyamount-1)) then {
                    HASH_GET_DEF( HASH_GET_DEF( GVAR(dangerzones),format[ARR_3("%1_%2",x+1,y)] ,locationNull) ,"enemystrenght" ,0)
                }else{0}
            )+
            (
                if (_y<(_keyamount-1)) then {
                    HASH_GET_DEF( HASH_GET_DEF( GVAR(dangerzones),format[ARR_3("%1_%2",x,y+1)] ,locationNull) ,"enemystrenght" ,0)
                }else{0}
            );
        */
        _temp = ([_x,_y] call _fnc_getValue) + ([_x + 1,_y] call _fnc_getValue) + ([_x,_y+1] call _fnc_getValue) + ([_x-1,_y] call _fnc_getValue) + ([_x,_y-1] call _fnc_getValue);
        if ((_temp>_last_maxima)&&{!([_temp,format["%1_%2",_x,_y]] in _maxima)}) then {
                _maxima pushBack [_temp,format["%1_%2",_x,_y]];
        };
    };
};

_maxima sort false;
_maxima resize MAXIMACOUNT;

// TODO - bad coding - needs rework - should do it for now

private _return = [];
{
    _x params ["_value","_key"];
    If ((_value > 0)&&(!(_key isEqualTo ""))) then {
        _maxima pushBack [_value,_key];
    };
} forEach _maxima;

_return;

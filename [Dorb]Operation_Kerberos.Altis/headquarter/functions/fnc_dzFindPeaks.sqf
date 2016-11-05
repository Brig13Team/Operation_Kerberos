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
#define MATRIX(x,y) ([HASH_GET(HASH_GET_DEF(GVAR(dangerzones),(format[ARR_3("%1_%2",x,y)],locationNull)),"enemystrenght")] param [0,0])

private _keyamount = (HASH_GET(GVAR(dangerzones),"distance"))/(HASH_GET(GVAR(dangerzones),"gridsize"));

private _maxima=[];
for "_i" from 0 to MAXIMACOUNT do {
    _maxima pushBack [0,""];
};

private ["_last_maxima","_temp","_key"];
for "_x" from 0 to (_keyamount-1) do {
    _maxima sort false;
    _maxima resize MAXIMACOUNT;
    _last_maxima = (_maxima select (MAXIMACOUNT - 1))select 0;
    for "_y" from 0 to (_keyamount-1) do {
        _temp = MATRIX(_x,_y)+
                (
                    if (_x>0) then {
                        MATRIX(_x-1,_y)
                    }else{0}
                )+
                (
                    if (_y>0) then {
                        MATRIX(_x,_y-1)
                    }else{0}
                )+
                (
                    if (_x<(_keyamount-1)) then {
                        MATRIX(_x+1,_y)
                    }else{0}
                )+
                (
                    if (_y<(_keyamount-1)) then {
                        MATRIX(_x,_y+1)
                    }else{0}
                );
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
        _temp = MATRIX(_x,_y)+(if(_x>0)then{MATRIX(_x-1,_y)}else{0})+(if(_y>0)then{MATRIX(_x,_y-1)}else{0})+(if(_x<(_keyamount-1))then{MATRIX(_x+1,_y)}else{0})+(if(_y<(_keyamount-1))then{MATRIX(_x,_y+1)}else{0});
        if ((_temp>_last_maxima)&&{!([_temp,format["%1_%2",_x,_y]] in _maxima)}) then {
                _maxima pushBack [_temp,format["%1_%2",_x,_y]];
        };
    };
};

_maxima sort false;
_maxima resize MAXIMACOUNT;

_maxima select {!((_x select 1)isEqualtTo "")};

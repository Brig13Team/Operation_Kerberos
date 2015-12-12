/*
    Author: Dorbedo

    Description:
        creates a matrix with zeroes

    Parameter(s):
        
        0 : SCARLAR - X-Size
        (optional)
        1 : SCARLAR - Y-Size
        2 : SCALAR - value
    
    Return:
        ARRAY - Matrix
*/
#include "script_component.hpp"
SCRIPT(create);

_this params [["_Xsize",0,[0]],["_Ysize",-1,[0]],["_value",0,[0]]];

CHECKRET((_Xsize<=0),[]);
If (_Ysize<=0) then {_Ysize=_Xsize;};
private _matrix=[];
For "_i" from 0 to _Xsize do {
    private _array = [];
    For "_i" from 0 to _Ysize do {
        _array pushBack _value;
    };
    _matrix pushBack _array;
};

_matrix;
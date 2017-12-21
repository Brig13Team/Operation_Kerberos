/*
    Author: Dorbedo

    Description:
        Selects weighted from an array

    Parameter(s):
        0 : ARRAY    - Array to choose from
        1 : SCALAR    - Pos of Weight inside Element
        2 : BOOL    - Return just the Pos of the Element

    Return:
        ARRAY/SCALAR - Index or Value
*/
#include "script_component.hpp"
_this params[["_array",[],[[]]],["_weightpos",-1,[0]],["_returnPos",false,[true]]];
If ((_array isEqualTo [])||(_weightpos<0)) exitWith {
    If (_returnPos) then {-1}else{[]};
};

private _weightsum = 0;
{
    _weightsum = _weightsum + abs(_x select _weightpos);
}forEach _array;

_weightsum = _weightsum * 1000;
private _choosenWeight = floor(random _weightsum);
If (_choosenWeight != 0) then {_choosenWeight = _choosenWeight / 1000;};

private _i = 0;
_weightsum = 0;
{
    _weightsum = _weightsum + abs(_x select _weightpos);
    _i = _forEachIndex;
    If (_weightsum >= _choosenWeight) exitWith {};
}forEach _array;

If (_returnPos) exitWith {_i};
(_array select _i)

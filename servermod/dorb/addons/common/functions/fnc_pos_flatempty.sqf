/*
    Author: Dorbedo

    Description:
        returns Array with Flat, Empty poisition

    Parameter(s):
        0 :    ARRAY    - Centerpos
        1 : SCALAR     - Size
        2 : SCALAR    - Searchradius
        (optional)
        3 : SCALAR    - Precize Pos
        4 : SCALAR    - Gradient (0.14 == 14%)

    Returns:
    ARRAY : Array with Positions    
*/
#include "script_component.hpp"
_this params["_position","_size","_searchradius",["_precizePos",0,[0]],["_maxGradient",0.15,[0]]];
Private["_return","_searchpositions","_temp"];
Private _return = [];
Private _searchpositions = [_position,_searchradius,40] call FUNC(pos_surrounding);
for "_i" from 0 to (count _searchpositions) do {
    Private _temp = (_searchpositions select _i) isFlatEmpty [(_size/2),_precizePos,_maxGradient,_size,0,false];
    If ((IS_ARRAY(_temp))&&{!(_temp isEqualTo [])}) exitwith {_return = _temp;};
    _temp = [];
};
_return;
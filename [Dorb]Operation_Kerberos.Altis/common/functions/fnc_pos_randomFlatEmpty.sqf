/*
    Author: Dorbedo, iJesuz

    Description:
        returns random position which is flat and empty

    Parameter(s):
        0 : ARRAY   - Centerpos
        1 : SCALAR  - Size
        2 : SCALAR  - Searchradius
        3 : SCALAR  - Tries
        4 : SCALAR  - Precize Pos (optional)
        5 : SCALAR  - Gradient (0.14 == 14%)  (optional)

    Returns:
        ARRAY   - Position or []
*/
#include "script_component.hpp"

_this params["_position","_size","_searchradius",["_tries",300,[0]],["_precizePos",0,[0]],["_maxGradient",0.15,[0]]];

private _ret = [];

scopeName "main";
for "_i" from 0 to _tries do {
    private _tmp = [_position,_searchradius,0] call FUNC(pos_random);
    if (not (_tmp isEqualTo [])) then {
        if (not (_tmp isFlatEmpty [(_size/2),_precizePos,_maxGradient,_size,0,false] isEqualTo [])) exitWith {
            _ret = _tmp;
            breakTo "main";
        };
    };
};

_ret

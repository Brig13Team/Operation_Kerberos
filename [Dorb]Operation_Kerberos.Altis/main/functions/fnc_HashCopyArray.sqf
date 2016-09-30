/*
    Author: Dorbedo

    Description:
        copys a array

    Parameter(s):
        None

    Return
        None
*/
#include "script_component.hpp"

_this params [["_array",[],[[]]]];

private _newArray = [];
{
    if(IS_HASH(_x)) then {
        _newArray pushBack (_x call FUNC(HashCopy));
    } else {
        if(IS_ARRAY(_x)) then {
            _newArray pushBack (_x call FUNC(HashCopyArray));
        } else {
            _newArray pushBack _x;
        };
    };
} forEach _array;
_newArray;

/*
 *  Author: Dorbedo
 *  Original Author: ACRE2 team (https://github.com/IDI-Systems/acre2)
 *
 *  Description:
 *      copys a hasharray
 *
 *  Parameter(s):
 *      0 : ARRAY - array to copy
 *
 *  Returns:
 *      ARRAY - Copied array
 *
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

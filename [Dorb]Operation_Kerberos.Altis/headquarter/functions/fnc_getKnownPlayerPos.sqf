/**
 *  Author: Dorbedo
 *
 *  Description:
 *      returns the positions of the known playergroups
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      ARRAY - Array with positions
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"
private _allPositions = [];
{
    If (((GVARMAIN(side) knowsAbout _x)>1.4)&&{!((vehicle _x) isKindOf "Air")}) then {
        private _pos = getPos _x;
        If !(([_pos] call FUNC(dzConvert))isEqualTo "") then {
            _allPositions pushBack _pos;
        };
    };
} forEach ([] call EFUNC(common,players));
_allPositions;

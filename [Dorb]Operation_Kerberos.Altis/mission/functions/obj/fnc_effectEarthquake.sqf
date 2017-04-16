/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Event when a earthquake happens
 *
 *  Parameter(s):
 *      0 : SCALAR - the strength
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

CHECK(!hasInterface)

if (!((vehicle player) isKindof 'Air')) then {
    _this params [["_strength",-1,[0]]];
    If (_strength < 0) then {
        _strength = (floor (random 4) + 1);
    };
    [_strength] spawn BIS_fnc_earthquake;
};

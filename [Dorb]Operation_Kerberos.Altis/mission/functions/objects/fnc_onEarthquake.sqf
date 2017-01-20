/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Event when a earthquake happens
 *
 *  Parameter(s):
 *      0 : SCALAR - the strenght
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

CHECK(!hashInterface)

if (!((vehicle player) isKindof 'Air')) then {
    _this params [["_strenght",-1,[0]]];
    If (_strenght < 0) then {
        _strenght = (floor(random 4)+1);
    };
    [_strenght]spawn BIS_fnc_earthquake;
};

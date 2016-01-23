/*
    Author: Dorbedo

    Description:
        enables TFR
        INTERNAL
    Parameter(s):
        none
    Returns:
        nothing

*/
#include "script_component.hpp"
SCRIPT(enableTFRtime);
{
    If ((GETVAR(_x,GVAR(TFR_enable),(diag_tickTime - 1)))< diag_tickTime) then {
        [_x] call FUNC(enableTFR);
    };
} forEach allPlayers;

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
    If ((GETVAR(_x,GVAR(TFR_enable),(CBA_missionTime - 1)))< CBA_missionTime) then {
        [_x] call FUNC(enableTFR);
    };
} forEach allPlayers;

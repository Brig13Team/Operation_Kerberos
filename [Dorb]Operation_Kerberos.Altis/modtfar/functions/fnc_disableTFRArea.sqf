/*
    Author: Dorbedo

    Description:
        disables TFR

    Parameter(s):
        0 : OBJECT - Unit where the TFR is disabled
    Returns:
        nothing

*/
#include "script_component.hpp"
_this params [
        ["_centerpos",[0,0,0],[[],objNull],[2,3]],
        ["_range",5000,[0]],
        ["_duration",180,[0]]
    ];
If (IS_OBJECT(_centerpos)) then {_centerpos = getPos _centerpos;};
_enableTime = CBA_missionTime + _duration;
{
    If ((_x distance _centerpos)< _range) then {
        [_x] call FUNC(disableTFR);
        SETVAR(_x,GVAR(TFR_enable),_enableTime);
    };
} forEach allPlayers;
[QUOTE(call FUNC(enableTFRtime)),[],(_duration + 2)] call CBA_fnc_waitAndExecute;

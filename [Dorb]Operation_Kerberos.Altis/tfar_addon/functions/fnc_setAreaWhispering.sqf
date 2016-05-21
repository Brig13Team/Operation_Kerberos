/*
    Author: Dorbedo

    Description:
       sets all players in an area to whispering

    Parameter(s):
        0 : ARRAY - position of center
        1 : SCALAR - radius
    Returns:
        nothing

*/
#include "script_component.hpp"
SCRIPT(disableTFR);
_this params [
    ["_position",[],[[]],[]],
    ["_radius",50,[0]]
    ];
CHECK(_position isEqualTo [])

{
    If ((_x distance2D _position)<= _radius) then {
        ["setWhispering",[],_x] call CBA_fnc_targetEvent;
    };
}forEach allPlayers;
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
        [_x,QUOTE(call FUNC(setWhispering);)] call EFUNC(events,targetExec);
    };
}forEach allPlayers;
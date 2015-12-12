/*
    Author: Dorbedo
    
    Description:
        converts the positon into a dangerzone coordinate
    
    Parameter(s):
        none

    Returns:
        none
*/
#include "script_component.hpp"
SCRIPT(dangerzone_convert);
_this params [["_position",[[]],[2,3]]];

CHECKRET((_position isEqualTo []),[-1,-1]);

_x_pos = floor(_position - (GVAR(centerpos) select 0 - (GVAR(definitions) select 0)));
_y_pos = floor((GVAR(centerpos) select 1 + (GVAR(definitions) select 0)) - _position);

CHECKRET(((_x_pos < 0)||(_y_pos < 0)),[-1,-1]);

private _x_coordinate = round(_x_pos / (GVAR(definitions) select 1));
private _y_coordinate = round(_y_pos / (GVAR(definitions) select 1));

[_x_coordinate,_y_coordinate];
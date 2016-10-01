/*
    Author: Dorbedo

    Description:


    Parameter(s):
        none

    Returns:
        none
*/
#include "script_component.hpp"

_this params ["_player"];

([getPos _player] call FUNC(dangerzone_convert)) params ["_x_coordinate","_y_coordinate"];

CHECK(_x_coordinate<0)

_value = [_player] call FUNC(strengthPlayer);

GVAR(buffer) pushBack [_x_coordinate,_y_coordinate,_value];

/*
    Author: Dorbedo
    
    Description:
        ads a vakue to the Dangeraray when a unit git killed
    
    Parameter(s):
        none

    Returns:
        none
*/
#include "script_component.hpp"
private ["_killerpos","_x_pos","_y_pos","_value"];

_this params ["_killer","_caller"];
TRACEV_2(_killer,_caller);

_killerpos = _caller gethidefrom _killer;

CHECK((_killerpos distance [0,0,0])<10);

([_killerpos] call FUNC(dangerzone_convert)) params ["_x_coordinate","_y_coordinate"];

private _strengthArray = [vehicle _killer] call FUNC(strength_player);

_value = _strengthArray select 1;

GVAR(buffer) pushBack [_x_coordinate,_y_coordinate,_value];

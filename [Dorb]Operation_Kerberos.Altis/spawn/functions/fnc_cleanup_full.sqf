/*
    Author: Dorbedo
    
    Description:
    Big Cleanup
    
*/
#include "script_component.hpp"
_this params ["_pos","_rad"];

[] call FUNC(cleanup_base);

{
    _x TILGE;
} foreach (_pos nearObjects ["ALL", _rad]);

{
    _x TILGE;
} forEach allMines;

{
    if (side _x != GVARMAIN(playerside) ) then {
        _x TILGE;
    };
} foreach allunits;

{
    if (!(alive _x)) then {
        _x TILGE;
    };
} foreach vehicles;

{
    _x TILGE;
} forEach allDead;

{
    _x TILGE;
} foreach allGroups;


ISNILS(EGVAR(mission,markerdump),[]);
EGVAR(mission,markerdump) TILGE;

nil;
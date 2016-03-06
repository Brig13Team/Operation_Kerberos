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
[{if(hasInterface)exitWith{};{deleteGroup _x;} foreach allGroups;}-1] call EFUNC(events,globalExec);    //Headless remove Groups


ISNILS(EGVAR(mission,markerdump),[]);
EGVAR(mission,markerdump) TILGE;

nil;
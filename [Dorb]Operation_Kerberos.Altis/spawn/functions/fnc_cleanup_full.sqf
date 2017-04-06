/*
    Author: Dorbedo

    Description:
    Big Cleanup

*/
#include "script_component.hpp"
_this params ["_pos","_rad"];

{
    GVAR(cleanUpDump) pushBackUnique _x;
} foreach (_pos nearObjects ["ALL", _rad]);

{
    GVAR(cleanUpDump) pushBackUnique _x;
} forEach allMines;

{
    if (side _x != GVARMAIN(playerside) ) then {
        GVAR(cleanUpDump) pushBackUnique _x;
    };
} foreach allunits;

{
    if (!(alive _x)) then {
        GVAR(cleanUpDump) pushBackUnique _x;
    };
} foreach vehicles;

{
    GVAR(cleanUpDump) pushBackUnique _x;
} forEach allDead;

[] call EFUNC(common,debug_marker_clean);

ISNILS(EGVAR(mission,markerdump),[]);
EGVAR(mission,markerdump) TILGE;

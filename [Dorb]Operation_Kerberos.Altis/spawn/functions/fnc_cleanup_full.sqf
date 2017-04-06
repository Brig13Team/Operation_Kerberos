/*
    Author: Dorbedo

    Description:
    Big Cleanup

*/
#include "script_component.hpp"
_this params ["_pos","_rad"];

{
    GVAR(cleanup_Dump_int) pushBackUnique [CBA_missiontime,_x];
} foreach (_pos nearObjects ["ALL", _rad]);

{
    GVAR(cleanup_Dump_int) pushBackUnique _x;
} forEach allMines;

{
    if (side _x != GVARMAIN(playerside) ) then {
        GVAR(cleanup_Dump_int) pushBackUnique [CBA_missiontime,_x];
    };
} foreach allunits;

{
    if (!(alive _x)) then {
        GVAR(cleanup_Dump_int) pushBackUnique [CBA_missiontime,_x];
    };
} foreach vehicles;

{
    GVAR(cleanup_Dump_int) pushBackUnique [CBA_missiontime,_x];
} forEach allDead;

{
    GVAR(cleanup_Dump_int) pushBackUnique [CBA_missiontime,_x];
    nil;
} count GVAR(cleanUpDump);
GVAR(cleanUpDump) = [];

[] call EFUNC(common,debug_marker_clean);

ISNILS(EGVAR(mission,markerdump),[]);
EGVAR(mission,markerdump) TILGE;

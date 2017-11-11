/*
    Author: Dorbedo

    Description:
    Big Cleanup

*/
#include "script_component.hpp"
_this params ["_pos",["_rad",2500,[0]]];

#define DELETE_INTERVALL 0.05

private _nexttime = CBA_missiontime + 10;


{
    If (_x getVariable [QGVARMAIN(canDelete),true]) then {
        _nexttime = _nexttime + DELETE_INTERVALL;
        GVAR(cleanup_Dump_int) pushBackUnique [_nexttime,_x];
    };
} foreach (_pos nearObjects ["ALL", _rad]);

{
    _nexttime = _nexttime + DELETE_INTERVALL;
    GVAR(cleanup_Dump_int) pushBackUnique [_nexttime,_x];
} forEach allMines;

{
    if (side _x != GVARMAIN(playerside) ) then {
        _nexttime = _nexttime + DELETE_INTERVALL;
        GVAR(cleanup_Dump_int) pushBackUnique [_nexttime,_x];
    };
} foreach allunits;

{
    if ((!(alive _x))&&{(_x getVariable [QGVARMAIN(canDelete),true])}) then {
        _nexttime = _nexttime + DELETE_INTERVALL;
        GVAR(cleanup_Dump_int) pushBackUnique [_nexttime,_x];
    };
} foreach vehicles;

{
    if ((alive _x)&&{
        _x getVariable [QGVARMAIN(canDelete),true]
        }&&{!(
            (_x distance (getMarkerPos GVARMAIN(respawnmarker)) < 500)||
            (_x distance (getMarkerPos "respawn_west_land") < 500)
        )}) then {
            _nexttime = _nexttime + DELETE_INTERVALL;
            GVAR(cleanup_Dump_int) pushBackUnique [_nexttime,_x];
    };
} foreach vehicles;

{
    _nexttime = _nexttime + DELETE_INTERVALL;
    GVAR(cleanup_Dump_int) pushBackUnique [_nexttime,_x];
} forEach ((allMissionObjects "WeaponHolder")
        + (allMissionObjects "GroundWeaponHolder")
        + (allMissionObjects "WeaponHolderSimulated")
        + (allMissionObjects "CraterLong_small")
        + (allMissionObjects "CraterLong")
        + (allMissionObjects "Ejection_Seat_Base_F"));

{
    _nexttime = _nexttime + DELETE_INTERVALL;
    GVAR(cleanup_Dump_int) pushBackUnique [_nexttime,_x];
} forEach (allMissionObjects "CraterLong");

{
    _nexttime = _nexttime + DELETE_INTERVALL;
    GVAR(cleanup_Dump_int) pushBackUnique [_nexttime,_x];
} forEach (allMissionObjects "CraterLong_small");

{
    _nexttime = _nexttime + DELETE_INTERVALL;
    GVAR(cleanup_Dump_int) pushBackUnique [_nexttime,_x];
} forEach (allMissionObjects "WeaponHolder");

{
    _nexttime = _nexttime + DELETE_INTERVALL;
    GVAR(cleanup_Dump_int) pushBackUnique [_nexttime,_x];
} forEach (allMissionObjects "GroundWeaponHolder");

{
    _nexttime = _nexttime + DELETE_INTERVALL;
    GVAR(cleanup_Dump_int) pushBackUnique [_nexttime,_x];
} forEach (allMissionObjects "GroundWeaponHolder_scripted");

{
    _nexttime = _nexttime + DELETE_INTERVALL;
    GVAR(cleanup_Dump_int) pushBackUnique [_nexttime,_x];
} forEach (allMissionObjects "Land_HelipadEmpty_F");


{
    _nexttime = _nexttime + DELETE_INTERVALL;
    GVAR(cleanup_Dump_int) pushBackUnique [_nexttime,_x];
    nil;
} count GVAR(cleanUpDump);
GVAR(cleanup_Dump_int) sort true;
GVAR(cleanUpDump) = [];

[] call EFUNC(common,debug_marker_clean);

ISNILS(EGVAR(mission,markerdump),[]);
EGVAR(mission,markerdump) TILGE;

[{GVAR(cleaningUp) = false;},[],30] call CBA_fnc_waitAndExecute;

/*
 *  Author: Dorbedo
 *
 *  Description:
 *      launches a scarab
 *
 *  Parameter(s):
 *      0 : OBJECT - the scarab
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params ["_scarab"];


private _pos = selectrandom [
    [worldSize,random worldSize,0],
    [0,random worldSize,0],
    [random worldSize,worldSize,0],
    [random worldSize,0,0]
];

private _target = "Logic" createVehicleLocal _pos;

EGVAR(spawn,cleanupDump) pushBack _target;

[_scarab,_target] spawn RHS_fnc_ss21_AI_launch;

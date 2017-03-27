/*
 *  Author: [Name of Author(s)]
 *
 *  Description:
 *      [Description]
 *
 *  Parameter(s):
 *      0 : [TYPE] - [argument name]
 *
 *  Returns:
 *      [TYPE] - [return name]
 *
 */
#define DEBUG_MODE_FULL
#include "script_component.hpp"


_this params ["_mils","_elevation"];

private _deg = 0.05625*_mils;



private _dummyPos = [0,0,0] getPos [100,_deg];

private _PosY = abs((tan _elevation)*100);

TRACEV_5(_mils,_deg,_elevation,_dummyPos,_PosY);

_dummyPos set[2,_PosY];

_dummyPos;

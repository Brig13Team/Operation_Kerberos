/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Mission "Chopper"
 *
 *  Parameter(s):
 *      0 : HASH      - mission hash
 *      1 : [OBJECT]  - mission targets
 *
 *  Returns:
 *      -
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params ["_mission", "_targets"];

private _crew = [];

{
    _crew append (([_x,GVARMAIN(side),false] call EFUNC(spawn,crew)) select 0);
    _x setFuel 0;
} forEach _targets;
TRACEV_2(_targets,_crew);
{
    _x addEventHandler ["Killed", LINKFUNC(obj__increaseCounter)];
    _x setVariable [QGVAR(mission),_mission];
} forEach _crew;

_mission setVariable ["objects",_crew];

#include "script_component.hpp"
SCRIPT(scarab_launch);

private["_dir","_zielpos"];
params["_abschussrampe"];


/*
_mapSize = getNumber(configFile >> "CfgWorlds" >> worldName >> "MapSize");
_dir = getDir _abschussrampe;

if ((_dir >=45)	&&(_dir < 135)) exitWith {[_abschussrampe,[_mapSize,(_mapSize/2),0]] call rhs_fnc_ss21_AI_launch;};
if ((_dir >=135)&&(_dir < 225)) exitWith {[_abschussrampe,[(_mapSize/2),0,0]] call rhs_fnc_ss21_AI_launch;};
if ((_dir >=225)&&(_dir < 315)) exitWith {[_abschussrampe,[0,(_mapSize/2),0]] call rhs_fnc_ss21_AI_launch;};
[_abschussrampe,[(_mapSize/2),_mapSize,0]] call rhs_fnc_ss21_AI_launch;
*/

_dir = getDir _abschussrampe;
_zielpos = [];
_zielpos = [_abschussrampe, 20000, _dir] call BIS_fnc_relPos;
[_abschussrampe,_zielpos] call rhs_fnc_ss21_AI_launch;
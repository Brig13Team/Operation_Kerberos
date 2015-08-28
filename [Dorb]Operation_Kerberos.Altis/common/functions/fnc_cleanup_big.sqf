/*
	Author: Dorbedo
	
	Description:
	Big Cleanup
	
*/
#include "script_component.hpp"
SCRIPT(cleanup_big);
PARAMS_2(_pos,_rad);

{_x TILGE;} foreach (_pos nearObjects ["ALL", _rad]); ///hier west rausnehmen
{_x TILGE;} forEach allMines;
{if (side _x != EGVAR(main,playerside)) then {_x TILGE;};} foreach allunits;

{if (!(alive _x)) then {_x TILGE;};} foreach vehicles;
{_x TILGE;} forEach allDead;

{_x TILGE;} foreach nearestObjects [(getmarkerpos DORB_RESPAWNMARKER),["CraterLong_small","CraterLong","WeaponHolder","GroundWeaponHolder"], 2000];

{_x TILGE;} foreach allGroups;

ISNILS(EGVAR(mission,markerdump),[]);
EGVAR(mission,markerdump) TILGE;

[-1,{if(hasInterface)exitWith{};{deleteGroup _x;} foreach allGroups;}] FMP;	//Headless remove Groups
ISNILS(EGVAR(mission,sideby_objects),[]);
{_x TILGE;} forEach EGVAR(mission,sideby_objects);
EGVAR(mission,sideby_objects) = [];
EGVAR(mission,fnc) = [];
publicVariable QEGVAR(mission,fnc);

/*
	Author: Dorbedo
	
	Description:
	Big Cleanup
	
*/
#include "script_component.hpp"

PARAMS_2(_pos,_rad);

{if (!(GETVAR(_x,DORB_ISRESPAWN,false))) then {_x TILGE;};} foreach (_pos nearObjects ["ALL", _rad]); ///hier west rausnehmen

{if ((side _x != DORB_PLAYERSIDE)and(!(GETVAR(_x,DORB_ISRESPAWN,false)))) then {_x TILGE;};} foreach allunits;

{if ((!(alive _x))and(!(GETVAR(_x,DORB_ISRESPAWN,false)))) then {_x TILGE;};} foreach vehicles;
{if (!(GETVAR(_x,DORB_ISRESPAWN,false))) then {_x TILGE;};} forEach allDead;

{_x TILGE;} foreach nearestObjects [(getmarkerpos DORB_RESPAWNMARKER),["CraterLong_small","CraterLong","WeaponHolder","GroundWeaponHolder"], 2000];

{_x TILGE;} foreach allGroups;

ISNILS(DORB_MARKERDUMP,[]);DORB_MARKERDUMP TILGE;

[-1,{if(hasInterface)exitWith{};{deleteGroup _x;} foreach allGroups;}] FMP;	//Headless remove Groups

{_x TILGE;} forEach DORB_SIDEBY_OBJECTS;
DORB_SIDEBY_OBJECTS = [];

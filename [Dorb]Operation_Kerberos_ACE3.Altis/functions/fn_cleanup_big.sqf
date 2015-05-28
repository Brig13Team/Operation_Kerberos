/*
	Author: Dorbedo
	
	Description:
	Big Cleanup
	
*/
#include "makros.hpp"

PARAMS_2(_pos,_rad);

d_log("Aufräumen groß start")

{if (!(GETVAR(_x,DORB_ISRESPAWN,false))) then {_x TILGE;};} foreach (_pos nearObjects ["ALL", _rad]); ///hier west rausnehmen

{if ((side _x != west)and(!(GETVAR(_x,DORB_ISRESPAWN,false)))) then {_x TILGE;};} foreach allunits;

{if ((!(alive _x))and(!(GETVAR(_x,DORB_ISRESPAWN,false)))) then {_x TILGE;};} foreach vehicles;
{if (!(GETVAR(_x,DORB_ISRESPAWN,false))) then {_x TILGE;};} forEach allDead;

{_x TILGE;} foreach nearestObjects [(getmarkerpos "Respawn_West"),["CraterLong_small","CraterLong","WeaponHolder","GroundWeaponHolder"], 2000];

{_x TILGE;} foreach allGroups;
[-1,{if(hasInterface)exitWith{};{deleteGroup _x;} foreach allGroups;}] FMP;	//Headless remove Groups

d_log("Aufräumen abgeschlossen")
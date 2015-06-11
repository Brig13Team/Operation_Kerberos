/*
	Author: Dorbedo
	
	Description:
	small cleanup
	
*/
#include "script_component.hpp"

{if ((!(alive _x))and(!(GETVAR(_x,DORB_ISTARGET,false)))) then {_x TILGE;};} foreach vehicles;
{if (!(GETVAR(_x,DORB_ISTARGET,false))) then {_x TILGE;};} forEach allDead;

{_x TILGE;} foreach nearestObjects [(getmarkerpos "Respawn_West"),["CraterLong_small","CraterLong","WeaponHolder","GroundWeaponHolder"], 2000];

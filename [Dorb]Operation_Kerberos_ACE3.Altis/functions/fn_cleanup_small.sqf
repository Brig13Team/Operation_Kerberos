/*
	Author: Dorbedo
	
	Description:
	small cleanup
	
*/
#include "makros.hpp"

{if ((!(alive _x))and(!(GETVAR(_x,DORB_ISTARGET,false)))and(!(GETVAR(_x,DORB_ISRESPAWN,false)))) then {_x TILGE;};} foreach vehicles;
{_x TILGE;} forEach allDead;

{_x TILGE;} foreach nearestObjects [(getmarkerpos "Respawn_West"),["CraterLong_small","CraterLong","WeaponHolder","GroundWeaponHolder"], 2000];

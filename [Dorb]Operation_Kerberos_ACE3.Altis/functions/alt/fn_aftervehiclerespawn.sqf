/*
	Author: Dorbedo
	
	Description:

*/
#include "makros.hpp"

PARAMS_1(_parameter);
EXPLODE_1_PVT(_unit);

[west,_unit] call BIS_fnc_addRespawnPosition;
_unit setVariable ["DORB_ISRESPAWN",true];

["AmmoboxInit",[_unit,true]] spawn BIS_fnc_arsenal;

/*
	Author: Dorbedo
	
	Description:

*/
#include "makros.hpp"

private ["_return","_unit"];
_return = _this select 0;
_unit = _return select 0;

[west,_unit] call BIS_fnc_addRespawnPosition;
_unit setVariable ["DORB_ISRESPAWN",true];

["AmmoboxInit",[_unit,true]] spawn BIS_fnc_arsenal;

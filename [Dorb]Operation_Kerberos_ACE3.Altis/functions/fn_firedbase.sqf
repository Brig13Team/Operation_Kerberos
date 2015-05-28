/*
	Author: Dorbedo
	
	Description:
	
	Requirements:
	
	Parameter(s):
		0 : ARRAY	- Example
		1 : ARRAY	- Example
		2 : STRIN	- Example
	
	Return
	BOOL
*/
#include "makros.hpp"
CHECK(!hasinterface)
_this spawn {
	CHECK((getposatl (_this select 0) distance getposatl base) >51)
	deleteVehicle (_this select 6);
	[localize "STR_DORB_BASE_FIRE",localize "STR_DORB_BASE",true] call BIS_fnc_guiMessage;
};
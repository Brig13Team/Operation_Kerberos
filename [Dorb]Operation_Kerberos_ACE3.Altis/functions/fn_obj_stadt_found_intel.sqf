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

_obj=_this select 0;


_obj addAction [localize "STR_DORB_INTEL_GRAB", {deleteVehicle (_this select 0);(_this select 1) sideChat localize "STR_DORB_INTEL_FOUND";},[], 2, true, true, "",""]
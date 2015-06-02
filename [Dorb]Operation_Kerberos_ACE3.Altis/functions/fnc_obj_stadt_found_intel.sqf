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
#include "script_component.hpp"

PARAMS_1(_obj);


_obj addAction [localize "STR_DORB_INTEL_GRAB", 
	{
		deleteVehicle (_this select 0);
		[-1,{["stadtintel",3] call FM(disp_localization)},[name player]] FMP;
	},[], 2, true, true, "",""]
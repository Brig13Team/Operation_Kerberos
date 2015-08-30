/*
	Author: Dorbedo
	
	Description:
		The FDC - Logic
		coordinates artilleryfire, sends firemissions, tries to defend artillery sites
	
	Parameter(s):
		0 : ARRAY	- params
		1 : SCALAR	- Handle
	
*/

#include "script_component.hpp"
SCRIPT(register);

If (isNil "DORB_FDC_LOGIC") exitwith {
	[_this select 1] call CBA_fnc_removePerFrameHandler;
};


private["_mortars","_artilleries","_rocket"];
_mortars = GETVAR(GVAR(fdc_logic),GVAR(fdc_mortars),[]);
_artilleries = GETVAR(GVAR(fdc_logic),GVAR(fdc_artilleries),[]);
_rocket = GETVAR(GVAR(fdc_logic),GVAR(fdc_rocket),[]);



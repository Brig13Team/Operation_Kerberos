/*
    Author: Dorbedo
    
    Description:
        
    
*/
#include "script_component.hpp"
SCRIPT(device_effect_earthquake);

_this params ["_target"];

ISNILS(GVAR(device_intervall),diag_ticktime);

If (GVAR(device_intervall)>diag_ticktime) exitWith {};
[{
	if (!(vehicle player isKindof 'Air')) then {
		_rand=(floor(random 4) + 1);
		[_rand]spawn BIS_fnc_earthquake;
	};
},-1] call EFUNC(common,NetEvent);

GVAR(earthquake_nextIntervall) = 7 * 60 + (floor(random 3)) * 60;

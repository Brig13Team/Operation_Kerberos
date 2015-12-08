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

CHECK(GVAR(fdc_firemissions) isEqualTo [])
private ["_current_firemission"];
_current_firemission = GVAR(fdc_firemissions) deleteAt 0;
private ["_current_artillerys_array"];
_current_firemission params ["_position","_type","_shelltype","_amount"];
_current_artillerys_array = switch(_type) do {
	case 0 : {GVAR(fdc_artilleries)};
	case 1 : {GVAR(fdc_mortars)};
	case 2 : {GVAR(fdc_rocket)};
	default {[]};
};

If (_current_artillerys_array isEqualTo []) exitwith {
	TRACE_1("No artilleryunit found for Mission: \n %1",_current_artillerys_array);
};

_current_artillerys_array = [_current_artillerys_array] call BIS_fnc_arrayShuffle


private "_unit";
_unit = {
	If ((_position inRangeOfArtillery [[_x],_shelltype])&&(_shelltype in getArtilleryAmmo[_x])&&(GETVAR(_x,GVAR(fdc_ready),false))) exitwith {_x};
}forEach _current_artillerys_array;

If((isNil "_unit")||{(!(IS_OBJECT(_unit)))}) exitwith {
	GVAR(fdc_firemissions) pushBack _current_firemission;
};

SETVAR(_unit,GVAR(fdc_ready),false);
TRACE_5("ArtilleryOrder = %1 - [%2,%3,%4]",_unit,_position,_shelltype,_amount);
///// Add fired Eventhandler -> removes status
_unit addEventHandler ["Fired",{SETVAR(_this select 0,GVAR(fdc_ready),true);(_this select 0) removeAllEventHandlers "Fired";}];
_unit commandArtilleryFire[_position,_shelltype,_amount];

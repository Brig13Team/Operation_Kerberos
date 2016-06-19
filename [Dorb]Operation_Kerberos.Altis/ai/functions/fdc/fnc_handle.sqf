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

If (GVAR(fdc_firemissions) isEqualTo []) exitWith {};
private _current_firemission = GVAR(fdc_firemissions) deleteAt 0;
_current_firemission params ["_position","_type","_shelltype","_amount"];

GVAR(fdc_artilleries) = GVAR(fdc_artilleries) select {alive _x;};
GVAR(fdc_mortars) = GVAR(fdc_mortars) select {alive _x;};
GVAR(fdc_rocket) = GVAR(fdc_rocket) select {alive _x;};

private _current_artillerys_array = switch(_type) do {
	case 0 : {[GETMVAR(GVAR(fdc_artilleries),[])] call BIS_fnc_arrayShuffle};
	case 1 : {[GETMVAR(GVAR(fdc_mortars),[])] call BIS_fnc_arrayShuffle};
	case 2 : {[GETMVAR(GVAR(fdc_rocket),[])] call BIS_fnc_arrayShuffle};
	default {[]};
};

If (_current_artillerys_array isEqualTo []) exitwith {
	TRACE_1("No artilleryunit found for Mission: \n %1",_current_firemission);
};
private _unit = {
	If ((_position inRangeOfArtillery [[_x],_shelltype])&&(_shelltype in getArtilleryAmmo[_x])&&(GETVAR(_x,GVAR(fdc_ready),true))) exitwith {_x};
}forEach _current_artillerys_array;

If((isNil "_unit")||{(!(IS_OBJECT(_unit)))}) exitwith {
	GVAR(fdc_firemissions) pushBack _current_firemission;
};

SETVAR(_unit,GVAR(fdc_ready),false);
TRACE_5("ArtilleryOrder = %1 - [%2,%3,%4]",_unit,_position,_shelltype,_amount);
///// Add fired Eventhandler -> removes status
_unit addEventHandler ["Fired",{(_this select 0) setVariable [ARR_2(QGVAR(fdc_ready),true)];(_this select 0) removeAllEventHandlers "Fired";}];
_unit commandArtilleryFire[_position,_shelltype,_amount];

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
	ERROR("Missing FDC-Logic");
};

private["_firemissions","_current_firemission"];
_firemissions = GETVAR(GVAR(fdc_logic),GVAR(fdc_firemissions),[]);

CHECK(_firemissions isEqualTo [])
_current_firemission = _firemissions deleteAt 0;
SETVAR(GVAR(fdc_logic),GVAR(fdc_firemissions));
private ["_current_artillerys_array"];
_current_firemission params ["_position","_type","_shelltype","_amount"];
_current_artillerys_array = switch(_type) do {
	case 0 : {[GETVAR(GVAR(fdc_logic),GVAR(fdc_artilleries),[])] call BIS_fnc_arrayShuffle};
	case 1 : {[GETVAR(GVAR(fdc_logic),GVAR(fdc_mortars),[])] call BIS_fnc_arrayShuffle};
	case 2 : {[GETVAR(GVAR(fdc_logic),GVAR(fdc_rocket),[])] call BIS_fnc_arrayShuffle};
	default {[]};
};

If (_current_artillerys_array isEqualTo []) exitwith {
	TRACE_1("No artilleryunit found for Mission: \n %1",_current_artillerys_array);
};
private "_unit";
_unit = {
	If ((_position inRangeOfArtillery [[_x],_shelltype])&&(_shelltype in getArtilleryAmmo[_x])&&(GETVAR(_x,GVAR(fdc_ready),false))) exitwith {_x};
}forEach _current_artillerys_array;

If((isNil "_unit")||{(!(IS_OBJECT(_unit)))}) exitwith {
	_temp = GETVAR(GVAR(fdc_logic),GVAR(fdc_firemissions),[]);
	_temp pushBack _current_firemission;
	SETVAR(GVAR(fdc_logic),GVAR(fdc_firemissions),_temp);
};

SETVAR(_unit,GVAR(fdc_ready),false);
TRACE_5("ArtilleryOrder = %1 - [%2,%3,%4]",_unit,_position,_shelltype,_amount);
///// Add fired Eventhandler -> removes status
_unit addEventHandler ["Fired",{SETVAR(_this select 0,GVAR(fdc_ready),true);(_this select 0) removeAllEventHandlers "Fired";}];
_unit commandArtilleryFire[_position,_shelltype,_amount];

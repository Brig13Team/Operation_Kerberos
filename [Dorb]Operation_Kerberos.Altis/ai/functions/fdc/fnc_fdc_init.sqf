/*
	Author: Dorbedo
	
	Description:
		Virtuell artillery commander
	
	Parameter(s):
		0 : ARRAY	- Position
	
*/
#define DEBUG_ENABLED_TEST
#include "script_component.hpp"
SCRIPT(fdc_init);

#define INTERVALL_FDC 120
#define INTERVALL_SEARCH 400

//// Create the virtual FDC

If (isNil "DORB_FDC_LOGIC") then {
	private ["_group"];
	_group = createGroup sideLogic;
	DORB_FDC_LOGIC = _group createUnit ["LOGIC", [0, 0, 0], [], 0, "NONE"];
};


SETVAR(DORB_FDC_LOGIC,DORB_FDC_MORTARS,[]);
SETVAR(DORB_FDC_LOGIC,DORB_FDC_ARTILLERIES,[]);
SETVAR(DORB_FDC_LOGIC,DORB_FDC_ROCKET,[]);
SETVAR(DORB_FDC_LOGIC,DORB_FDC_FIREMISSIONS,[]);
SETVAR(DORB_FDC_LOGIC,DORB_FDC_HANDLE,-1);
SETVAR(DORB_FDC_LOGIC,DORB_FDC_HANDLE_SEARCH,-1);



private "_handel";
_handel = [
	{
		_this call FUNC(fdc_handle);
	},
	INTERVALL_FDC,
	[]
	] call CBA_fnc_addPerFrameHandler;
SETVAR(DORB_FDC_LOGIC,DORB_FDC_HANDLE,_handel);

_handel = [
	{
		_this call FUNC(fdc_defend_artypos);
	},
	INTERVALL_SEARCH,
	[]
	] call CBA_fnc_addPerFrameHandler;
SETVAR(DORB_FDC_LOGIC,DORB_FDC_HANDLE_SEARCH,_handel);

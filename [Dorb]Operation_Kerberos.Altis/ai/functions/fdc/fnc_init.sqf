/*
	Author: Dorbedo
	
	Description:
		Virtuell artillery commander
	
	Parameter(s):
		0 : ARRAY	- Position
	
*/
#define DEBUG_ENABLED_TEST
#include "script_component.hpp"
SCRIPT(init);

#define INTERVALL_FDC 120
#define INTERVALL_SEARCH 400

//// Create the virtual FDC

If (isNil QGVAR(fdc_logic)) then {
	private ["_group"];
	_group = createGroup sideLogic;
	GVAR(fdc_logic) = _group createUnit ["LOGIC", [0, 0, 0], [], 0, "NONE"];
};


SETVAR(GVAR(fdc_logic),GVAR(fdc_mortars),[]);
SETVAR(GVAR(fdc_logic),GVAR(fdc_artilleries),[]);
SETVAR(GVAR(fdc_logic),GVAR(fdc_rocket),[]);
SETVAR(GVAR(fdc_logic),GVAR(fdc_firemissions),[]);
SETVAR(GVAR(fdc_logic),GVAR(fdc_handle),-1);
SETVAR(GVAR(fdc_logic),GVAR(fdc_handle_search),-1);



private "_handel";
_handel = [
	{
		_this call FUNC(fdc_handle);
	},
	INTERVALL_FDC,
	[]
	] call CBA_fnc_addPerFrameHandler;
SETVAR(GVAR(fdc_logic),GVAR(fdc_handle),_handel);

_handel = [
	{
		_this call FUNC(fdc_defend_artypos);
	},
	INTERVALL_SEARCH,
	[]
	] call CBA_fnc_addPerFrameHandler;
SETVAR(GVAR(fdc_logic),GVAR(fdc_handle_search),_handel);

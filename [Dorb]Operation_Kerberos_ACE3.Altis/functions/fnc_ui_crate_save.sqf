/*
	Author: Dorbedo

	Description:
		comunicate with save
	
	
*/
#include "script_component.hpp"
SCRIPT(ui_crate_save);
CHECK(!hasInterface)
params[["_isSave",true,[true]]];
private["_return"];
If (_isSave) exitWith {
	_return = [DORB_CRATE_CURRENT_BOXID,DORB_CRATE_CURRENT];
	["CrateSpawn",true,_return] call FM(ui_save_OpenMenu);
};
["CrateSpawn",false] call FM(ui_save_OpenMenu);
waitUntil{(!ctrlVisible 600243)};
If (isNil "DORB_SAVE_CURRENT") exitWith {};
If (DORB_SAVE_CURRENT isEqualTo []) exitWith {};
_return = DORB_SAVE_CURRENT;
DORB_CRATE_CURRENT_BOXID = _return select 0;
DORB_CRATE_CURRENT = _return select 1;
[1] call FM(ui_crate_filter);
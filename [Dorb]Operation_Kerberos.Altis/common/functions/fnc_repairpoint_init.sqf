/*
	Author: Dorbedo
	
	Description:
		Repairpoint init
	
*/
#include "script_component.hpp"
SCRIPT(repairpoint_init);
ISNILS(DORB_RESPAWN_FNC,[]);

private ["_reppoint"];
_reppoint = [];

For "_i" from 0 to 20 do {
	If (!isNil format["DORB_REPPOINT_%1",_i]) then {
		_reppoint pushback format["DORB_REPPOINT_%1",_i];
	};
};

{
	DORB_RESPAWN_FNC pushback format["%1 addAction [localize'STR_DORB_REP_POINT2',{_this call dorb_fnc_repairpoint;},[],6,true,true,'','(vehicle player != player)&&((driver (vehicle player)) == player)']",_x];
}forEach _reppoint;
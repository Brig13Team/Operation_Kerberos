/*
	Author: Dorbedo

	Description:
	Creates Mission "Return to Base".
	
	Requirements:
		SHK_Taskmaster

	Parameter(s):
		0 :	ARRAY - Position
		1 :	ARRAY - Ziele
		2 : STRING - Aufgabenname für Taskmaster
		
	Returns:
	BOOL
*/
#include "makros.hpp"
CHECK(!isServer)

private["_position","_task","_ort","_position_rescue","_pow"];
_position=_this select 0;
_task=_this select 1;
_position_home = getMarkerPos "respawn_west";

//////////////////////////////////////////////////
////// Nachricht anzeigen 					 /////
//////////////////////////////////////////////////
[-1,{_this FSPAWN(disp_info)},[localize "STR_DORB_RTB",[localize "STR_DORB_RTB_START_1"],"data\icon\icon_base.paa",false]] FMP;
//[[localize "STR_DORB_RTB",[localize "STR_DORB_RTB_START_1"],"data\icon\icon_base.paa",false],"dorb_fnc_disp_info",true] spawn BIS_fnc_MP ;

//////////////////////////////////////////////////
////// Überprüfung + Ende 					 /////
//////////////////////////////////////////////////

aufgabenstatus=true;
while {aufgabenstatus} do {
	_a=0;
	sleep 15;
	
	{If (_x distance _position_home < 300) then {_a=_a+1;};} forEach playableUnits;
	
	If (_a == (count playableUnits)) then {aufgabenstatus=false};
};
[-1,{_this FSPAWN(disp_info)},[localize "STR_DORB_RTB",[localize "STR_DORB_RTB_FINISHED",localize "STR_DORB_RTB_FINISHED2"],"data\icon\icon_base.paa",false]] FMP;
//[[localize "STR_DORB_RTB",[localize "STR_DORB_RTB_FINISHED",localize "STR_DORB_RTB_FINISHED2"],"data\icon\icon_base.paa",false],"dorb_fnc_disp_info",true] spawn BIS_fnc_MP ;

d_log("Alle zurückgekehrt")


[_position, 2000] spawn dorb_fnc_cleanup_big;

d_log("Exit RTB")
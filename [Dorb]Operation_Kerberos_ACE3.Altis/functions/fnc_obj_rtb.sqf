/*
	Author: Dorbedo

	Description:
	Creates Mission "Return to Base".
	
	Parameter(s):
		0 :	ARRAY - Position der letzten AO
		
	Returns:
	BOOL
*/
#include "script_component.hpp"
CHECK(!isServer)
PARAMS_1(_position);
private["_position_home"];
_position_home = getMarkerPos DORB_RESPAWNMARKER;

//////////////////////////////////////////////////
////// Nachricht anzeigen 					 /////
//////////////////////////////////////////////////

ISNILS(taskcancel,false);
If (taskcancel) then {
	sleep 150;
	taskcancel=false;
}else{
	sleep 30;
};

[-1,{_this spawn FM(disp_info)},["STR_DORB_RTB",["STR_DORB_RTB_START_1"],"data\icon\icon_base.paa",false]] FMP;

//////////////////////////////////////////////////
////// Überprüfung + Ende 					 /////
//////////////////////////////////////////////////

#define INTERVALL 15
#define TASK ""
#define CONDITION {_a=0;{If (_x distance (_this select 0) < 300) then {_a=_a+1;};} forEach playableUnits;If (_a == (count playableUnits)) then {true}else{false};}
#define CONDITIONARGS [_position_home]
#define SUCESSCONDITION {true}
#define ONSUCESS {LOG('Alle zurückgekehrt');[-1,{_this spawn FM(disp_info)},["STR_DORB_RTB",["STR_DORB_RTB_FINISHED","STR_DORB_RTB_FINISHED2"],"data\icon\icon_base.paa",false]] FMP;[_position, 2000] spawn FM(cleanup_big);}
[INTERVALL,TASK,CONDITION,CONDITIONARGS,SUCESSCONDITION,ONSUCESS] call FM(taskhandler);

LOG("Exit RTB");
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
SCRIPT(obj_rtb);
CHECK(!isServer)
params["_position", "_taskID"];
private["_position_home", "_player", "_tasks", "_data", "_taskVar"];
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
////// Nebenmissionen beenden				 /////
//////////////////////////////////////////////////
/*
_taskVar = "BIS_fnc_taskVar_" + _taskID + "_side";
_data = missionnamespace getvariable _taskVar;
if ( ( !(isnil "_data") ) && { !((_data select 4) in ["Succeeded","Failed","Canceled"]) } ) then {
	[_taskVar, "Canceled", false] call BIS_fnc_taskSetState;
};
*/

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

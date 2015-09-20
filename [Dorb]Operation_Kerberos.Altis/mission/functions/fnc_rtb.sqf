/*
	Author: Dorbedo

	Description:
	Creates Mission "Return to Base".
	
	Parameter(s):
		0 :	ARRAY - Position der letzten AO
		1 : STRING - Taskname
		
	Returns:
	BOOL
*/
#include "script_component.hpp"
SCRIPT(rtb);
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

[LSTRING(RTB),[LSTRING(RTB_START_1)],"data\icon\icon_base.paa",false] call EFUNC(interface,disp_info_global);

//////////////////////////////////////////////////
////// Nebenmissionen beenden				 /////
//////////////////////////////////////////////////
_sideMission = missionNamespace getVariable [QGVAR(current_sidemission),""];
if (!(_sideMission isEqualTo "")) then {
	[_sideMission,"CANCELED",false] call BIS_fnc_taskSetState; 
	missionNamespace setVariable [QGVAR(current_sidemission),""];
};

//////////////////////////////////////////////////
////// Überprüfung + Ende 					 /////
//////////////////////////////////////////////////

#define INTERVALL 15
#define TASK ""
#define CONDITION {_a=0;{If (_x distance (_this select 0) < 300) then {_a=_a+1;};} forEach playableUnits;If (_a == (count playableUnits)) then {true}else{false};}
#define CONDITIONARGS [_position_home]
#define SUCESSCONDITION {true}
#define ONSUCESS {LOG('Alle zurückgekehrt');[LSTRING(RTB),[LSTRING(RTB_FINISHED),LSTRING(RTB_FINISHED2)],"data\icon\icon_base.paa",false] call EFUNC(interface,disp_info_global);[_position, 2000] spawn EFUNC(common,cleanup_big);}
[INTERVALL,TASK,CONDITION,CONDITIONARGS,SUCESSCONDITION,ONSUCESS] call FUNC(taskhandler);

LOG("Exit RTB");

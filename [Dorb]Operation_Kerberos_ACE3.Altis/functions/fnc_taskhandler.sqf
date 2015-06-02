/*
	Author: Dorbedo
	
	Description:
		Handles the Tasks
	
	Parameter(s):
		0 : SCALAR	- Checkintervall in seconds (minimum 3 Seconds)
		1 : CODE	- Checkcondition
		2 : ARRAY	- Arguments passed to Checkcondition
		4 : CODE	- Condition for Sucess
		5 : CODE	- Code on Sucess
		6 : CODE	- Code on Failure
		7 : ARRAY	- Arguments passed to Sucess/Failure
		8 : CODE	- Code executed in each Loop
		9 : ARRAY	- Arguments passed into LoopCode
	
	Please Note:
	
		#define INTERVALL 30
		#define CONDITION {_a ={!(alive _x)}count (_this select 0);If (_a > ((count _target)-4)) then {true}else{false};}
		#define CONDITIONARGS [_target]
		[30,CONDITION,CONDITIONARGS] call FM(taskhandler);

	Return
	BOOL - isSucess
	
*/
#include "script_component.hpp"

CHECK(!isServer)
DEFAULT_PARAM(0,_intervall,30);
DEFAULT_PARAM(1,_condition,{true});
DEFAULT_PARAM(2,_conditionArgs,[]);
DEFAULT_PARAM(3,_conditionSucess,{true});
DEFAULT_PARAM(4,_onSucess,{});
DEFAULT_PARAM(5,_onFailure,{});
DEFAULT_PARAM(6,_args,[]);
DEFAULT_PARAM(7,_afterCheck,{});
DEFAULT_PARAM(8,_afterCheckArgs,[]);

_intervall = _intervall max 5;
aufgabenstatus=false;
while {!aufgabenstatus} do {
	aufgabenstatus = _conditionArgs call _condition;
	_afterCheckArgs call _afterCheck;
	uiSleep _intervall;
};

If (_args call _conditionSucess) then {
	_args call _onSucess;
	true
}else{
	_args call _onFailure;
	false
};
/*
	Author: Dorbedo
	
	Description:
		spawns attackwaves
	
	Requirements:
		EGVAR(mission,waves_remaining)
	Parameter(s):
		0 : ARRAY	- Targetposition
		1 : STRING OR SCALAR	- TaskID/Taskname
	
	Return
		None
*/
#include "script_component.hpp"
SCRIPT(attack_waves);
If (EGVAR(mission,waves_remaining) < 1) exitWith {LOG("Keine Wellen übrig");};
PARAMS_2(_position,_task);
private["_rand","_difficulty","_missionsstatus","_gegner_lebend","_z"];
["STR_DORB_DEF","STR_DORB_DEF_ATT_INB"] spawn EFUNC(interface,disp_message_global);


sleep 60;

_rand = (floor(random 9));
_difficulty = [] call EFUNC(mission,dyn_difficulty);
LOG_3(_position,_rand,_difficulty);

switch (_rand) do {
	case 0 ;
	case 1 ;
	case 2 : {
		LOG("Infanterieangriff");
		[_position,400,10,2] spawn FUNC(attack_inf);
		If (_difficulty > 1) then {
			[_position,400,2,1] spawn FUNC(attack_inf);
			sleep 30;
		};
		If (_difficulty > 2) then {
			[_position,400,2,3] spawn FUNC(attack_inf);
			sleep 30;
		};
		If (_difficulty > 3) then {
			[_position,400,3,3] spawn FUNC(attack_inf);
			sleep 30;
		};		
		If (_difficulty > 4) then {
			[_position,400,3,3] spawn FUNC(attack_inf);
		};
	};
	case 3 ;
	case 4 ;
	case 5 ;
	case 6 : {
		LOG("Fahrzeugangriff");
		[_position,400,8,0] spawn FUNC(attack_inf);
		[_position,400,5,3] spawn FUNC(attack_veh);
		If (_difficulty > 1) then {
			[_position,400,2,0] spawn FUNC(attack_inf);	
			[_position,400,0,4] spawn FUNC(attack_veh);
			sleep 30;			
		};
		If (_difficulty > 2) then {
			[_position,400,4,2] spawn FUNC(attack_inf);	
			[_position,400,0,3] spawn FUNC(attack_veh);
			sleep 30;
		};
		If (_difficulty > 3) then {
			[_position,400,0,2] spawn FUNC(attack_inf);	
			[_position,400,0,2] spawn FUNC(attack_veh);
			sleep 30;
		};		
		If (_difficulty > 4) then {
			[_position,400,2,1] spawn FUNC(attack_inf);	
			[_position,400,0,3] spawn FUNC(attack_veh);	
		};
	};
	case 7;
	case 8;
	case 9 : {
		LOG("Airdrop");
		for "_i" from 0 to (4 + _difficulty) do {
			[_position,0] spawn FUNC(attack_airdrop);
			sleep 3;
		};
	};
};
//////////////////////////////////////////////////
////// Wellenprüfung						 /////
//////////////////////////////////////////////////

sleep 200;
LOG("Erfüllungsprüfung beginnt");

#define INTERVALL 15
#define TASK ""
#define CONDITION {_a=0;_a = {(((side _x)==dorb_side)&&(alive _x))}count ((_this select 0) nearEntities 1200);If (_a<15) then {true}else{false};}
#define CONDITIONARGS [_position]
[INTERVALL,TASK,CONDITION,CONDITIONARGS] call EFUNC(mission,taskhandler);


private "_state";
_state = [_task] call BIS_fnc_taskState;
If ((taskcancel)||(_state in ["CANCELED","SUCCEEDED","FAILED"])) exitWith {EGVAR(mission,waves_remaining)=0;};




["STR_DORB_DEF","STR_DORB_DEF_WAVE_DEFENDED"] spawn EFUNC(interface,disp_message_global);

EGVAR(mission,waves_remaining) = EGVAR(mission,waves_remaining) - 1;

If (EGVAR(mission,waves_remaining) > 1) then {
	sleep 60;
	["STR_DORB_DEF","STR_DORB_DEF_WAVE_NEW"] spawn EFUNC(interface,disp_message_global);
	sleep 60;
	[_position,_task] spawn FUNC(attack_waves);
}else {
	EGVAR(mission,waves_remaining) = 0;
;}
	
/*
	Author: Dorbedo
	
	Description:
	
	Requirements:
	
	Parameter(s):
		0 : ARRAY	- Example
		1 : ARRAY	- Example
		2 : STRIN	- Example
	
	Return
	BOOL
*/
#include "script_component.hpp"
	
If (!(aufgabenstatus)) exitWith {LOG("Wellengenerierung abgebrochen");};
If (DORB_WAVES_REMAINING < 1) exitWith {LOG("Keine Wellen übrig");};
PARAMS_1(_position);
private["_rand","_difficulty","_missionsstatus","_gegner_lebend","_z"];
[-1,{_this spawn FM(disp_message)},[localize "STR_DORB_DEF",localize "STR_DORB_DEF_ATT_INB"]] FMP;


sleep 60;

_rand = (floor(random 9));
_difficulty = [] call FM(dyn_difficulty);
LOG_3(_position,_rand,_difficulty);

switch (_rand) do {
	case 0 ;
	case 1 ;
	case 2 : {
		LOG("Infanterieangriff");
		[_position,400,10,2] spawn FM(spawn_attack_inf);
		If (_difficulty > 1) then {
			[_position,400,2,1] spawn FM(spawn_attack_inf);
			sleep 30;
		};
		If (_difficulty > 2) then {
			[_position,400,2,3] spawn FM(spawn_attack_inf);
			sleep 30;
		};
		If (_difficulty > 3) then {
			[_position,400,3,3] spawn FM(spawn_attack_inf);
			sleep 30;
		};		
		If (_difficulty > 4) then {
			[_position,400,3,3] spawn FM(spawn_attack_inf);
		};
	};
	case 3 ;
	case 4 ;
	case 5 ;
	case 6 : {
		LOG("Fahrzeugangriff");
		[_position,400,8,0] spawn FM(spawn_attack_inf);
		[_position,400,5,3] spawn FM(spawn_attack_veh);
		If (_difficulty > 1) then {
			[_position,400,2,0] spawn FM(spawn_attack_inf);	
			[_position,400,0,4] spawn FM(spawn_attack_veh);
			sleep 30;			
		};
		If (_difficulty > 2) then {
			[_position,400,4,2] spawn FM(spawn_attack_inf);	
			[_position,400,0,3] spawn FM(spawn_attack_veh);
			sleep 30;
		};
		If (_difficulty > 3) then {
			[_position,400,0,2] spawn FM(spawn_attack_inf);	
			[_position,400,0,2] spawn FM(spawn_attack_veh);
			sleep 30;
		};		
		If (_difficulty > 4) then {
			[_position,400,2,1] spawn FM(spawn_attack_inf);	
			[_position,400,0,3] spawn FM(spawn_attack_veh);	
		};
	};
	case 7;
	case 8;
	case 9 : {
		LOG("Airdrop");
		for "_i" from 0 to (4 + _difficulty) do {
			[_position,0] spawn FM(spawn_attack_airdrop);
			sleep 3;
		};
	};
};
//////////////////////////////////////////////////
////// Wellenprüfung						 /////
//////////////////////////////////////////////////

sleep 400;
LOG("Erfüllungsprüfung beginnt");

_missionsstatus=true;
while {_missionsstatus} do {
	_z=0;
	sleep 30;
	_gegner_lebend = [];
	_gegner_lebend = (_position) nearEntities 1200;
	{
		If ((alive _x)&&((side _x)!=west)&&(_x isKindOf "Man")) then {
			_z=_z+1;
		};
	}forEach _gegner_lebend;
	LOG(FORMAT_1("Anzahl Gegner=%1",_z));
	
	if (_z<15) exitWith {_missionsstatus=false;};
	
};
[-1,{_this spawn FM(disp_message)},[localize "STR_DORB_DEF",localize "STR_DORB_DEF_WAVE_DEFENDED"]] FMP;

LOG("Welle abgeschlossen");
DORB_WAVES_REMAINING = DORB_WAVES_REMAINING - 1;

If (DORB_WAVES_REMAINING > 1) then {
	sleep 60;
	[-1,{_this spawn FM(disp_message)},[localize "STR_DORB_DEF",localize "STR_DORB_DEF_WAVE_NEW"]] FMP;
	sleep 60;
	[_position] spawn FM(spawn_attack_waves);
}else {
	DORB_WAVES_REMAINING = 0;
;}
	
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
#include "makros.hpp"
	
If (!(aufgabenstatus)) exitWith {d_log("Wellengenerierung abgebrochen")};
If (DORB_WAVES_REMAINING < 1) exitWith {d_log("Keine Wellen übrig")};
_position = _this select 0;
[-1,{_this FSPAWN(disp_message)},[localize "STR_DORB_DEF",localize "STR_DORB_DEF_ATT_INB"]] FMP;
//[[localize "STR_DORB_DEF",localize "STR_DORB_DEF_ATT_INB"],"dorb_fnc_disp_message",true] spawn BIS_fnc_MP ;
sleep 60;

_rand = (floor(random 9));
_difficulty = [] call dorb_fnc_difficulty;

d_log(FORMAT_3("Pos=%1 / rand=%2 / diff=%3",_position,_rand,_difficulty))

switch (_rand) do {
	case 0 ;
	case 1 ;
	case 2 : {
		d_log("Infanterieangriff")
		[_position,400,10,2] spawn dorb_fnc_spawn_attack_inf;
		If (_difficulty > 1) then {
			[_position,400,2,1] spawn dorb_fnc_spawn_attack_inf;
			sleep 30;
		};
		If (_difficulty > 2) then {
			[_position,400,2,3] spawn dorb_fnc_spawn_attack_inf;
			sleep 30;
		};
		If (_difficulty > 3) then {
			[_position,400,3,3] spawn dorb_fnc_spawn_attack_inf;
			sleep 30;
		};		
		If (_difficulty > 4) then {
			[_position,400,3,3] spawn dorb_fnc_spawn_attack_inf;
		};
	};
	case 3 ;
	case 4 ;
	case 5 ;
	case 6 : {
		d_log("Fahrzeugangriff")
		[_position,400,8,0] spawn dorb_fnc_spawn_attack_inf;
		[_position,400,5,3] spawn dorb_fnc_spawn_attack_veh;
		If (_difficulty > 1) then {
			[_position,400,2,0] spawn dorb_fnc_spawn_attack_inf;	
			[_position,400,0,4] spawn dorb_fnc_spawn_patrol_veh;
			sleep 30;			
		};
		If (_difficulty > 2) then {
			[_position,400,4,2] spawn dorb_fnc_spawn_attack_inf;	
			[_position,400,0,3] spawn dorb_fnc_spawn_patrol_veh;
			sleep 30;
		};
		If (_difficulty > 3) then {
			[_position,400,0,2] spawn dorb_fnc_spawn_attack_inf;	
			[_position,400,0,2] spawn dorb_fnc_spawn_patrol_veh;
			sleep 30;
		};		
		If (_difficulty > 4) then {
			[_position,400,2,1] spawn dorb_fnc_spawn_attack_inf;	
			[_position,400,0,3] spawn dorb_fnc_spawn_patrol_veh;	
		};
	};
	case 7;
	case 8;
	case 9 : {
		d_log("Airdrop")
		for "_i" from 0 to (4 + _difficulty) do {
			[_position,0] spawn dorb_fnc_spawn_attack_airdrop;
			sleep 3;
		};
	};
};
//////////////////////////////////////////////////
////// Wellenprüfung						 /////
//////////////////////////////////////////////////

sleep 400;
d_log("Erfüllungsprüfung beginnt")

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
	d_log(FORMAT_1("Anzahl Gegner=%1",_z))
	
	if (_z<15) exitWith {_missionsstatus=false;};
	
};
[-1,{_this FSPAWN(disp_message)},[localize "STR_DORB_DEF",localize "STR_DORB_DEF_WAVE_DEFENDED"]] FMP;
//[[localize "STR_DORB_DEF",localize "STR_DORB_DEF_WAVE_DEFENDED"],"dorb_fnc_disp_message",true] spawn BIS_fnc_MP ;
d_log("Welle abgeschlossen")
DORB_WAVES_REMAINING = DORB_WAVES_REMAINING - 1;

If (DORB_WAVES_REMAINING > 1) then {
	sleep 60;
	[-1,{_this FSPAWN(disp_message)},[localize "STR_DORB_DEF",localize "STR_DORB_DEF_WAVE_NEW"]] FMP;
	//[[localize "STR_DORB_DEF",localize "STR_DORB_DEF_WAVE_NEW"],"dorb_fnc_disp_message",true] spawn BIS_fnc_MP ;
	sleep 60;
	[_position] spawn dorb_fnc_spawn_attack_waves;
}else {
	DORB_WAVES_REMAINING = 0;
;}
	
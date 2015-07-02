/*
	Author: Dorbedo
	
	Description:
		Spawns Commandveh Tanks
	Requirements:
	
	Parameter(s):
		0 : ARRAY	- Example
		1 : ARRAY	- Example
		2 : STRIN	- Example
	
	Return
	BOOL
*/
#include "script_component.hpp"
LOG("Commandveh Tanks");
PARAMS_1(_position);
private["_spawnpos","_spawnposition","_einheit","_dir","_return","_veh","_panzer","_attack_pos","_rand","_pos","_einheit","_gruppe","_a"];
_spawnposition=[];
_einheit = dorb_commandveh_radio SELRND;
_spawnposition = [_position,200,0] call FM(random_pos);
_spawnposition = _spawnposition findEmptyPosition [1,100,_einheit];				//// to do: isFlatEmpty
if (count _spawnposition < 1) exitWith {ERROR("Keine Spawnposition | Commandveh Tanks");};

_dir = floor(random 360);
_return = [_spawnposition,_dir,_einheit,dorb_commandveh_side] call BIS_fnc_spawnVehicle;
_veh = (_return select 0);
_veh setFuel 0;
_veh lock 3;

If (DORB_PLAYERSIDE == east) then {
	[_veh,1] spawn rhs_fnc_fmtv_Deploy;
}else{
	[_veh,1,true] spawn RHS_fnc_gaz66_radioDeploy;
};

SETVAR(_veh,DORB_HASTANK,0);
_panzer=[];
while {alive _veh} do {
	LOG("COMMANDVEH-CHECK | Tanks");
	_attack_pos=[];
	_attack_pos=[getPos _veh,0] call FM(spawn_commandveh_check);
	if (((count _attack_pos)>1)&&((GETVAR(_veh,DORB_HASTANK,false))<6)) then {
			_rand=[];
			_pos = [_attack_pos,2000,2] call FM(random_pos);
			_anzahl = floor(random 3);
			INC(_anzahl);
			for "_i" from 0 to _anzahl do {
				_rand = (floor(random 8));
				if (_rand<2) then {
					_einheit = dorb_veh_aa SELRND;
				}else{
					_einheit = dorb_veh_armored SELRND;
				};
				_spawnpos = _pos findEmptyPosition [1,100,_einheit];
				if (count _spawnpos < 1) then {
					ERROR(FORMAT_1("Keine Spawnposition | %1",_spawnpos));
				}else{
					_gruppe = createGroup dorb_side;
					LOG_3(_spawnpos,_einheit,_gruppe);
					_return = [_spawnpos,(random(360)),_einheit,_gruppe] call BIS_fnc_spawnVehicle;
					_panzer pushBack (_return select 0);
					[_return select 2] call FM(moveToHC);
					/*
					_mrkr = createMarker [format["infp-%1",_return],_spawnpos];
					_mrkr setMarkerShape "ICON";
					_mrkr setMarkerColor "ColorRed";
					_mrkr setMarkerType "o_inf";
					*/
					[_gruppe, _attack_pos] call CBA_fnc_taskAttack;
				};
				
			};
			
			
			
		sleep (600 + (random 300));
	};
	_a=0;
	{If(canMove _x) then {INC(_a);};}forEach _panzer;
	LOG(FORMAT_1("Lebende Panzer=%1",_a));
	If (alive _veh) then {SETVAR(_veh,DORB_HASTANK,_a);};
	sleep 300;
};

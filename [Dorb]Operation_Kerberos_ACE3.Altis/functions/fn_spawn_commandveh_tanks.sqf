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

_position = [];
_position = _this select 0;

d_log("Commandveh Tanks")

_spawnposition=[];

_einheit = "rhs_gaz66_r142_vv";

_spawnposition = [_position,200,0] call FM(random_pos);
_spawnposition = _spawnposition findEmptyPosition [1,100,_einheit];				//// to do: isFlatEmpty
if (count _spawnposition < 1) exitWith {d_error(FORMAT_1("Keine Spawnposition Commandveh | ",_spawnpos))};

_dir = floor(random 360);
d_log(FORMAT_3("Spawnpos=%1 / dir=%2 / einheit=%3",_spawnposition, _dir, _einheit))
_return = [_spawnposition,_dir,_einheit,EAST] call BIS_fnc_spawnVehicle;
_veh = (_return select 0);
_veh setFuel 0;
_veh lock 3;

//"CamoNet_OPFOR_big_F" createVehicle (getPos _veh);

[_veh,1,true] spawn RHS_fnc_gaz66_radioDeploy;

SETVAR(_veh,DORB_HASTANK,0);
_panzer=[];
while {alive _veh} do {
	d_log("COMMANDVEH-CHECK | Tanks")
	_attack_pos=[];
	_attack_pos=[getPos _veh,0] call FM(spawn_commandveh_check);
	if (((count _attack_pos)>1)&&((GETVAR(_veh,DORB_HASTANK,false))<6)) then {
			d_log_o("COMMANDVEH | Tanks Attack")
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
					d_error(FORMAT_1("Keine Spawnposition | ",_spawnpos))
				}else{
					_gruppe = createGroup dorb_side;
					d_log(FORMAT_3("Spawnpos=%1 / Einheit=%2 / Gruppe=%3",_spawnpos,_einheit,_gruppe))
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
	d_log(FORMAT_1("Lebende Panzer=%1",_a))
	If (alive _veh) then {SETVAR(_veh,DORB_HASTANK,_a);};
	sleep 300;
};

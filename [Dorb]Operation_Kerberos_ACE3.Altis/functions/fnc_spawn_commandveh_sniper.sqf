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

LOG("Commandveh Sniper");
PARAMS_1(_position);
_spawnposition=[];
_einheit = "rhs_gaz66_r142_vdv";
_spawnposition = [_position,200,0] call FM(random_pos);
_spawnposition = _spawnposition findEmptyPosition [1,100,_einheit];	
if (count _spawnposition < 1) exitWith {ERROR("Keine Spawnposition | Commandveh Sniper");};

_dir = floor(random 360);
_return = [_spawnposition,_dir,_einheit,EAST] call BIS_fnc_spawnVehicle;
_veh = (_return select 0);
_veh setFuel 0;
_veh lock 3;

[_veh,1,true] spawn RHS_fnc_gaz66_radioDeploy;



while {alive _veh} do {
	LOG("COMMANDVEH-CHECK | Sniper");
	_attack_pos=[];
	_attack_pos=[getPos _veh,0] call FM(spawn_commandveh_check);
	if ((count _attack_pos)>1) then {
			[_position,_attack_pos] spawn {
				scriptName "dorb_fnc_spawn_commandveh_sniper_INNEN";
				_position = _this select 0;
				_attack_pos = _this select 1;
				_rand=[];
				_pos = [_position,2000,2] call FM(random_pos);
				_einheit = dorb_veh_car SELRND;
				_spawnpos = _pos findEmptyPosition [1,200,_einheit];
				_rand = dorb_grouplist_mech SELRND;
				if (count _spawnpos < 1) then {
					ERROR(FORMAT_1("Keine Spawnposition | %1",_spawnpos));
				}else{
					LOG_3(_spawnpos,_einheit,dorb_side);
					_spawn_array = [_spawnpos,(random(360)),_einheit,dorb_side] call BIS_fnc_spawnVehicle;				
					_transporter = _spawn_array select 0;
					/*
					_mrkr = createMarker [format["infp-%1",_return],_spawnpos];
					_mrkr setMarkerShape "ICON";
					_mrkr setMarkerColor "ColorRed";
					_mrkr setMarkerType "o_inf";
					*/
					_jaeger_gruppe = createGroup dorb_side;
					_jaeger_gruppe setCombatMode "RED";
					_einheit = dorb_sniper SELRND;
					for "_i" from 0 to 1 do {
						_jaeger = [_spawnpos,_jaeger_gruppe,_einheit] call FM(spawn_unit);
					};
					sleep 1;
					{
						_x assignAsCargo _transporter;
						_x moveInCargo _transporter;
					}forEach units _jaeger_gruppe;
					[_jaeger_gruppe, _position] call CBA_fnc_taskAttack;
					//[_jaeger_gruppe, _attack_pos, 400, 5, "MOVE", "AWARE", "RED", "NORMAL", "STAG COLUMN", "", [5,10,15]] call CBA_fnc_taskPatrol;
					[_jaeger_gruppe] call FM(moveToHC);
					sleep 2;
					(_spawn_array select 2) addWaypoint [_position,100];
					while {(canMove _transporter)} do {
						_transporter doMove _position;
																	
						waitUntil {((_transporter distance _position) < 700)};
							{
								unassignVehicle (_x);
								_x allowDamage false;
								moveOut _x;
								sleep 0.3;							
								_x allowDamage true;		
							} forEach units _jaeger_gruppe;
						_transporter domove _spawnpos;
						waitUntil {((_transporter distance _spawnpos) < 150)};
						if (true) exitWith {};
					};
					{deletevehicle _x} foreach crew _transporter;
					deletevehicle _transporter;
				};
			};
		sleep (300 + (random 300));
	};
	sleep 300;
};

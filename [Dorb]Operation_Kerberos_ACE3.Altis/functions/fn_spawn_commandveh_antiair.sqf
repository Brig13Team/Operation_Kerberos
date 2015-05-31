/*
	Author: Dorbedo
	
	Description:
	
*/
#include "script_component.hpp"

private["_position","_spawnpos","_spawnposition","_return","_veh","_attack_pos","_radar","_radarpos","_rand","_dir","_wp"];

_position = [];
_position = _this select 0;

d_log("Commandveh AI")

_spawnposition=[];

_einheit = ["rhs_p37","rhs_prv13"] SELRND;

_spawnposition = [_position,200,0] call FM(random_pos);
_spawnposition = _spawnposition findEmptyPosition [1,100,_einheit];				//// to do: isFlatEmpty
if (count _spawnposition < 1) exitWith {d_error(FORMAT_1("Keine Spawnposition Commandveh | ",_spawnposition))};

_dir = floor(random 360);
d_log(FORMAT_3("Spawnpos=%1 / dir=%2 / einheit=%3",_spawnposition, _dir, _einheit))
_return = [_spawnposition,_dir,_einheit,EAST] call BIS_fnc_spawnVehicle;
_veh = (_return select 0);

SETVAR(_veh,DORB_HASAI,false);

while {alive _veh} do {
	d_log("COMMANDVEH-CHECK | AI")
	_attack_pos = [];
	_attack_pos = [getPos _veh,1,_veh] call FM(spawn_commandveh_check);
	if ((count _attack_pos)>0) then {
		d_log_o("COMMANDVEH | Call AI")
		_radar=true;
		_radarpos = [];
		_radarpos = getPosATL _veh;
		_radarpos set[2,((_radarpos select 2)+1)];
		_radar = terrainIntersect[_attack_pos,_radarpos];
		d_log(FORMAT_1("RADAR=%1",_radar))
		If (!(_radar)) then {
			//d_log(FORMAT_1("HAS_Plane=%1",GETVAR(_veh,DORB_HASAI,true)))
			If (!(GETVAR(_veh,DORB_HASAI,true))) then {			
				_rand=[];
				_spawnpos = [_position,4000,2] call FM(random_pos);
				_rand = dorb_patrol_air_list SELRND;
				if (count _spawnpos < 1) then {
					d_error(FORMAT_1("Keine Spawnposition | ",_spawnpos))
				}else{
					_spawnpos set [2,1500];
					_dir = [_spawnpos, _spawnposition] call BIS_fnc_dirTo;
					d_log(FORMAT_4("Spawn CMD Air / Pos=%1 / Dir=%2 / Side=%3 / Einheit=%4",_spawnpos,_dir,dorb_side,_rand))
					
					_return = [_spawnpos,_dir,_rand,dorb_side] call BIS_fnc_spawnVehicle;				
					
					SETVAR(_veh,DORB_HASAI,true);
					/*
					_mrkr = createMarker [format["infp-%1",_return],_spawnpos];
					_mrkr setMarkerShape "ICON";
					_mrkr setMarkerColor "ColorRed";
					_mrkr setMarkerType "o_inf";
					*/
					(_return select 0) flyInHeight 600;
					_wp = (_return select 2) addWaypoint [_attack_pos, 0];
					_wp setWaypointLoiterType "CIRCLE";
					_wp setWaypointLoiterRadius 800;
					[(_return select 2)] FCALL(moveToHC);
					[(_return select 0),_veh] spawn {
						_plane = _this select 0;
						_commando = _this select 1;
						while {alive _plane} do {
						_plane setfuel 1;
						_plane setVehicleAmmo 1;
						sleep 30;
						};
						if (alive _commando) then {SETVAR(_commando,DORB_HASAI,false);}
					};
				};
			};
			sleep (300+(random 400));
		};
	};
	sleep 120;
};

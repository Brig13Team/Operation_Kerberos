/*
	Author: Dorbedo
	
	Description:
	
*/
#include "script_component.hpp"
LOG("Commandveh Airinterception");
PARAMS_1(_position);
private["_spawnpos","_spawnposition","_return","_veh","_attack_pos","_radar","_radarpos","_rand","_dir","_wp","_einheit","_plane","_commando"];
_spawnposition=[];
_einheit = ["rhs_p37","rhs_prv13"] SELRND;
_spawnposition = [_position,200,0] call FM(random_pos);
_spawnposition = _spawnposition findEmptyPosition [1,100,_einheit];
if (count _spawnposition < 1) exitWith {ERROR("Keine Spawnposition | Commandveh AI");};
_dir = floor(random 360);
_return = [_spawnposition,_dir,_einheit,dorb_commandveh_side] call BIS_fnc_spawnVehicle;
_veh = (_return select 0);

SETVAR(_veh,DORB_HASAI,false);

while {alive _veh} do {
	LOG("COMMANDVEH-CHECK | AI");
	_attack_pos = [];
	_attack_pos = [getPos _veh,1,_veh] call FM(spawn_commandveh_check);
	if ((count _attack_pos)>0) then {
		_radar=true;
		_radarpos = [];
		_radarpos = getPosATL _veh;
		_radarpos set[2,((_radarpos select 2)+1)];
		_radar = terrainIntersect[_attack_pos,_radarpos];
		If (!(_radar)) then {
			If (!(GETVAR(_veh,DORB_HASAI,true))) then {			
				_rand=[];
				_spawnpos = [_position,4000,2] call FM(random_pos);
				_rand = dorb_patrol_air_list SELRND;
				if (count _spawnpos < 1) then {
					ERROR("Keine Spawnposition | AI");
				}else{
					_spawnpos set [2,1500];
					_dir = [_spawnpos, _spawnposition] call BIS_fnc_dirTo;
					LOG_4(_spawnpos,_dir,dorb_side,_rand);
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
					[(_return select 2)] call FM(moveToHC);
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

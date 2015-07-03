/*
	Author: Dorbedo
	
	Description:
		AI-Commander BRAIINN
	
	Parameter(s):
		0 : OBJECT	- HQ
	
*/
#include "script_component.hpp"
PARAMS_1(_commander);
private ["_attackpos_air","_attackpos_tanks","_attackpos_ground"];

/// functions

_attack_ai = {
	if ((count _attackpos_air)>0) then {
		private ["_radars","_veh"];
		_radars = GETVAR(_commander,DORB_COMMANDER_RADAR,[]);
		if ((count _radars) < 1) then {SETVAR(_commander,DORB_COMMANDER_AI,false);};
		_outOfSight = true;
		
		{
			_radarpos = getPos _x;
			_radarpos set[2,((_radarpos select 2)+1)];
			_outOfSight = terrainIntersect[_attackpos_air,_radarpos];
			If (!(_outOfSight)) exitWith {};
		}forEach _radars;
		
		If (!(_outOfSight)) then {
			_planes = GETVAR(_commander,DORB_COMMANDER_PLANES,[]);

			If ((count _radars)>(count _planes)) then {
				_spawnpos = [_attackpos_air select 0,4000,2] call FM(random_pos);
				if (count _spawnpos > 1) then {
					_unit = dorb_patrol_air_list SELRND;
					_spawnpos set [2,1500];
					_dir = [_spawnpos, _attackpos_air select 0] call BIS_fnc_dirTo;
					_return = [_spawnpos,_dir,_unit,dorb_side] call BIS_fnc_spawnVehicle;				
					_veh = (_return select 0);
					_planes pushBack _veh;
					SETVAR(_commander,DORB_COMMANDER_PLANES,_planes);
					_veh flyInHeight 600;
					_wp = (_return select 2) addWaypoint [_attackpos_air select 0, 0];
					_wp setWaypointLoiterType "CIRCLE";
					_wp setWaypointLoiterRadius 800;
					[(_return select 2)] call FM(moveToHC);
					[_veh] spawn {
						private ["_plane"];
						_plane = _this select 0;
						while {alive _plane} do {
							_plane setfuel 1;
							_plane setVehicleAmmo 1;
							sleep 60;
						};
					};
				};
			};
		};
	};
};

_attack_arty_smoke = {
	PARAMS_1(_attack_pos);
	DEFAULT_PARAM(1,_count,2);
	private["_artilleries"];
	_artilleries = GETVAR(_commander,DORB_COMMANDER_ARTILLERIE,[]);
	{
		if (alive _x) then {_x commandArtilleryFire [_attack_pos, "Smoke_120mm_AMOS_White" ,_count];};
	} forEach _artilleries;
};

_attack_mech = {
	///[_commander,_attack_pos] spawn (_attack_mech);
	scriptName "dorb_fnc_spawn_commander_ar_INNEN_mech";
	private ["_position","_attack_pos","_pos"]
	_position = getPos(_this select 0);
	_attack_pos = _this select 1;
	
	_pos = [_position,2000,2] call FM(random_pos);
	_einheit = dorb_veh_truck SELRND;
	_spawnpos = _pos findEmptyPosition [1,200,_einheit];
	if (count _spawnpos > 1) then {
		_spawn_array = [_spawnpos,(random(360)),_einheit,dorb_side] call BIS_fnc_spawnVehicle;				
		_transporter = _spawn_array select 0;
		
		_jaeger_gruppe = createGroup dorb_side;
		_jaeger_gruppe setCombatMode "RED";
		_platzanzahl = _transporter emptyPositions "cargo";
		for "_i" from 0 to (_platzanzahl - 2) do {
			_einheit = dorb_menlist SELRND;
			_jaeger = [_spawnpos,_jaeger_gruppe,_einheit] call FM(spawn_unit);
		};

		sleep 1;		
		{
			_x assignAsCargo _transporter;
			_x moveInCargo _transporter;
		}forEach units _jaeger_gruppe;
		
		[_jaeger_gruppe, _position] call CBA_fnc_taskAttack;
		[_jaeger_gruppe] call FM(moveToHC);
		sleep 2;
		
		(_spawn_array select 2) addWaypoint [_position,100];
		
		while {(canMove _transporter)} do {
			_transporter doMove _position;
			waitUntil {((_transporter distance _position) < 400)};
			
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


_attack_sniper = {
	///[_commander,_attack_pos] spawn (_attack_mech);
	scriptName "dorb_fnc_spawn_commander_ar_INNEN_mech";
	private ["_position","_attack_pos","_pos"]
	_position = getPos(_this select 0);
	_attack_pos = _this select 1;
	
	_pos = [_position,2000,2] call FM(random_pos);
	_einheit = dorb_veh_car SELRND;
	_spawnpos = _pos findEmptyPosition [1,200,_einheit];
	if (count _spawnpos > 1) then {
		_spawn_array = [_spawnpos,(random(360)),_einheit,dorb_side] call BIS_fnc_spawnVehicle;				
		_transporter = _spawn_array select 0;
		
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


_attack_tanks = {
	_position = getPos(_this select 0);
	_attack_pos = _this select 1;
	_panzer = GETVAR(_commander,DORB_COMMANDER_TANKLIST,[]);
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
		if (count _spawnpos > 1) then {
			_gruppe = createGroup dorb_side;
			_return = [_spawnpos,(random(360)),_einheit,_gruppe] call BIS_fnc_spawnVehicle;
			_panzer pushBack (_return select 0);
			[_return select 2] call FM(moveToHC);
			[_gruppe, _attack_pos] call CBA_fnc_taskAttack;
		};
	};
	SETVAR(_commander,DORB_COMMANDER_TANKLIST,_panzer);
};

/// Atacktypes

_Attacktype_airdrop_smoke = {
	PARAMS_1(_attack_pos);
	[_attack_pos,1,40] spawn FM(spawn_attack_airdrop);
	uisleep 20;
	[_attack_pos,3] call (_spawn_attack_arty_smoke);
};
_Attacktype_airdrop = {
	PARAMS_1(_attack_pos);
	[_attack_pos,0,40] spawn FM(spawn_attack_airdrop);
};
_Attacktype_mechattack = {
	PARAMS_1(_attack_pos);
	[_commander,_attack_pos] spawn (_attack_mech);
};
_Attacktype_arty_auto = {
	PARAMS_1(_attack_pos);
	[_commander,_attack_pos,-1]spawn FM(spawn_commander_callArty);
};
_Attacktype_tankattack = {
	PARAMS_1(_attack_pos);
	[_commander,_attack_pos] spawn (_attack_tanks);
};
_Attacktype_heliattack = {
	PARAMS_1(_attack_pos);
	[_attack_pos,400,1,0,2000] spawn FM(spawn_attack_air);
};
_Attacktype_sniperattack = {
	PARAMS_1(_attack_pos);
	[_commander,_attack_pos] spawn (_attack_sniper);
};



//// BRAIINN

while {alive _commander} do {
	private ["_temp","_sleep","_checkunits"];
	_sleep = 5;
	_attackpos_air = [];
	_attackpos_tanks = [];
	_attackpos_ground = [];
	
	//// SEARCH
	If (DORB_COMMANDER_AI) do {
		for "_i" from 0 to (count GETVAR(_commander,DORB_COMMANDER_RADAR,[]) do {
			_temp = [getPos _commander,1] call FM(spawn_commander_check);
			_attackunit_air pushBack _temp;
		};
	};
	_attackpos_air = [];
	{_attackpos_air pushBack (getPosATL _x);}forEach _attackunit_air;
	
	_attackunit_ground = [getPos _commander,3] call FM(spawn_commander_check);
	_attackunit_tanks = [getPos _commander,2] call FM(spawn_commander_check);
	
	_temp = [];
	{If (!((vehicle _x) in _temp)) then {_temp pushBack (vehicle _x);};}forEach _attackunit_tanks;
	_attackunit_tanks=_temp;
	
	
	
	//// CHECK
	If (DORB_COMMANDER_TANKS) then {
		_checkunits = GETVAR(_commander,DORB_COMMANDER_TANKLIST,[]);
		_temp = [];
		{if (canMove _x) then {_temp pushBack _x;};} forEach _checkunits;
		SETVAR(_commander,DORB_COMMANDER_TANKLIST,_temp);
	};
	
	If (DORB_COMMANDER_AI) do {
		// Radar
		_checkunits = GETVAR(_commander,DORB_COMMANDER_RADAR,[]);
		_temp = [];
		{if (alive _x) then {_temp pushBack _x;};} forEach _checkunits;
		SETVAR(_commander,DORB_COMMANDER_RADAR,_temp);
		// Planes
		_checkunits = GETVAR(_commander,DORB_COMMANDER_PLANES,[]);
		_temp = [];
		{if (alive _x) then {_temp pushBack _x;};} forEach _checkunits;
		SETVAR(_commander,DORB_COMMANDER_PLANES,_temp);
	};
	
	//// Do Brainwork and attack
	// Air interception
	[] call (_attack_ai);
	
	// get good attack-locations and give them weight
	_attackunits_all = _attackunit_ground + _attackunit_tanks;
	_attackunits_weight = [];
	
	for "_i" from 0 to ((count _attackunits_all)-1) do {
		/// Set Unitweight
		If ((_attackunits_all select _i)isKindOf "LandVehicle") then {
			If ((_attackunits_all select _i)isKindOf "Tank") then {
				_attackunits_weight set [_i,10];
			}else{
				_attackunits_weight set [_i,4];
			};
		}else{
			_attackunits_weight set [_i,1];
		};
		/// Increase when additional Units are near
		
		_cur_unit = (_attackunits_all select _i);
		for "_j" from 0 to ((count _attackunit_ground)-1) do {
			If (((_attackunit_ground select _j)distance(_cur_unit))<30) then {
				_attackunits_weight set [_i,((_attackunits_weight select _i)+1)];
			};
		};
		for "_j" from 0 to ((count _attackunit_tanks)-1) do {
			If (((_attackunit_tanks select _j)distance(_cur_unit))<30) then {
				If ((_attackunit_tanks select _j)isKindOf "Tank") then {
					_attackunits_weight set [_i,((_attackunits_weight select _i)+7)];
				}else{
					_attackunits_weight set [_i,((_attackunits_weight select _i)+3)];
				};
			};
		};
	};
	
	// Choose the locations
	private ["_notadded","_attackunit_sortet_weight","_attackunit_sortet"];
	If (!(_attackunits_all isEqualTo [])) then {
		_attackunit_sortet = [_attackunits_all select 0];
		_attackunit_sortet_weight = [_attackunits_weight select 0];
		for "_i" from 1 to ((count _attackunits_all)-1) do {
			_notadded = true;
			for "_j" from 0 to ((count _attackunit_sortet_weight)-1) do {
				If ((_attackunit_sortet_weight select _j)<(_attackunits_weight select _i)) exitWith {
					_notadded = false;
					_attackunit_sortet = [_attackunit_sortet, [_attackunits_all select _i], _j] call BIS_fnc_arrayInsert
					_attackunit_sortet_weight = [_attackunit_sortet_weight, [_attackunits_weight select _i], _j] call BIS_fnc_arrayInsert
				};
			};
			If (_notadded) then {
				_attackunit_sortet pushBack (_attackunits_all select _i);
				_attackunit_sortet_weight pushBack (_attackunits_weight select _i);
			};
		};
	}else{
		_attackunit_sortet = [];
		_attackunit_sortet_weight = [];
	};
	
	_attackpos_filtered = [];
	_attackpos_filtered_weight = [];
	{
		_temp = _x;
		_add = 0;
		_add = {((_temp distance _x)<30)}count _attackpos_filtered;
		if (_add < 1) then {
			_attackpos_filtered pushBack (getPos _x);
			_attackpos_filtered_weight pushBack (_attackunit_sortet_weight select _forEachIndex);
		};
	}forEach _attackunit_sortet;
	
	
	// Find the proper attack and do it
	
	for "_i" from 0 to ((count _attackpos_filtered)-1) do {
		
		/// Heavy Attack some Veh + Inf or Tanks
		If ((_attackpos_filtered_weight select _i) > 19) then {
			_rand = floor (random 4);
			
			/// Artilleriestrike + Infanterie
			If ((_rand <1)&&(DORB_COMMANDER_MECH || DORB_COMMANDER_AIRDROP)&&(DORB_COMMANDER_ART)) exitWith {
				[(_attackpos_filtered_weight select _i)] call _Attacktype_arty_auto;
				If ((DORB_COMMANDER_MECH)&&(DORB_COMMANDER_AIRDROP)) then {
					_rand = floor (random 2);
					If (_rand >0) then {
						_rand = floor (random 2);
						If (_rand >0) then {
							[(_attackpos_filtered_weight select _i)] call _Attacktype_airdrop;
						}else{
							[(_attackpos_filtered_weight select _i)] call _Attacktype_airdrop_smoke;
						};
					}else{
						[(_attackpos_filtered_weight select _i)] call _Attacktype_mechattack;
					};
				}else{
					If (DORB_COMMANDER_MECH) then {[(_attackpos_filtered_weight select _i)] call _Attacktype_mechattack;};
					If (DORB_COMMANDER_AIRDROP) then {
						_rand = floor (random 2);
						If (_rand >0) then {
							[(_attackpos_filtered_weight select _i)] call _Attacktype_airdrop;
						}else{
							[(_attackpos_filtered_weight select _i)] call _Attacktype_airdrop_smoke;
						};
					};
				};
				_sleep = _sleep + 5;
			};
			
			/// Infanterie + Tanks
			If ((_rand <2)&&(DORB_COMMANDER_TANKS && DORB_COMMANDER_MECH)) exitWith {
				[(_attackpos_filtered_weight select _i)] call _Attacktype_mechattack;
				[(_attackpos_filtered_weight select _i)] call _Attacktype_tankattack;
				_sleep = _sleep + 5;
			};
			
			/// Helicopter
			If ((_rand <3)&&(DORB_COMMANDER_HELICOPTER)) exitWith {
				[(_attackpos_filtered_weight select _i)] call _Attacktype_heliattack;
				_sleep = _sleep + 4.5;
			};
			
			/// Arty
			If (DORB_COMMANDER_ART) exitWith {	
				[(_attackpos_filtered_weight select _i)] call _Attacktype_arty_auto;
				_sleep = _sleep + 2;
			};
			/// Tanks
			If ((DORB_COMMANDER_TANKS)) exitWith {	
				[(_attackpos_filtered_weight select _i)] call _Attacktype_tankattack;
				_sleep = _sleep + 4;
			};
			/// Airdrop
			If ((DORB_COMMANDER_AIRDROP)) exitWith {	
				[(_attackpos_filtered_weight select _i)] call _Attacktype_airdrop;
				_sleep = _sleep + 3;
			};
			/// MEch
			If ((DORB_COMMANDER_MECH)) exitWith {	
				[(_attackpos_filtered_weight select _i)] call _Attacktype_mechattack;
				_sleep = _sleep + 3;
			};
			
		}else{
			/// Medium Attack
			If ((_attackpos_filtered_weight select _i) > 10) then {
				_rand = floor (random 5);
				If ((_rand <1)&&(DORB_COMMANDER_MECH || DORB_COMMANDER_AIRDROP)&&(DORB_COMMANDER_ART)) exitWith {
					[(_attackpos_filtered_weight select _i)] call _Attacktype_arty_auto;
					If ((DORB_COMMANDER_MECH)&&(DORB_COMMANDER_AIRDROP)) then {
						_rand = floor (random 2);
						If (_rand >0) then {
							_rand = floor (random 2);
							If (_rand >0) then {
								[(_attackpos_filtered_weight select _i)] call _Attacktype_airdrop;
							}else{
								[(_attackpos_filtered_weight select _i)] call _Attacktype_airdrop_smoke;
							};
						}else{
							[(_attackpos_filtered_weight select _i)] call _Attacktype_mechattack;
						};
					}else{
						If (DORB_COMMANDER_MECH) then {[(_attackpos_filtered_weight select _i)] call _Attacktype_mechattack;};
						If (DORB_COMMANDER_AIRDROP) then {
							_rand = floor (random 2);
							If (_rand >0) then {
								[(_attackpos_filtered_weight select _i)] call _Attacktype_airdrop;
							}else{
								[(_attackpos_filtered_weight select _i)] call _Attacktype_airdrop_smoke;
							};
						};
					};
					_sleep = _sleep + 5;
				};
				/// Tanks + Mech
				If ((_rand <2)&&(DORB_COMMANDER_TANKS && DORB_COMMANDER_MECH)) exitWith {
					[(_attackpos_filtered_weight select _i)] call _Attacktype_mechattack;
					[(_attackpos_filtered_weight select _i)] call _Attacktype_tankattack;
					_sleep = _sleep + 5;
				};
				/// Tanks
				If ((_rand <3)&&(DORB_COMMANDER_TANKS)) exitWith {
					[(_attackpos_filtered_weight select _i)] call _Attacktype_tankattack;
					_sleep = _sleep + 4;
				};
				/// Arty
				If ((_rand <4)&&(DORB_COMMANDER_ART)) exitWith {
					[(_attackpos_filtered_weight select _i)] call _Attacktype_arty_auto;
					_sleep = _sleep + 2;
				};
				/// Airdrop
				If ((DORB_COMMANDER_AIRDROP)) exitWith {	
					[(_attackpos_filtered_weight select _i)] call _Attacktype_airdrop;
					_sleep = _sleep + 3;
				};
				/// MEch
				If ((DORB_COMMANDER_MECH)) exitWith {	
					[(_attackpos_filtered_weight select _i)] call _Attacktype_mechattack;
					_sleep = _sleep + 3;
				};
			}else{
				_rand = floor (random 2);
				/// Sniper
				If ((_rand <1)&&(DORB_COMMANDER_SNIPER)) exitWith {
					[(_attackpos_filtered_weight select _i)] call _Attacktype_sniperattack;
					_sleep = _sleep + 2;
				};
				/// Airdrop
				If ((DORB_COMMANDER_AIRDROP)) exitWith {	
					[(_attackpos_filtered_weight select _i)] call _Attacktype_airdrop;
					_sleep = _sleep + 3;
				};
				/// MEch
				If ((DORB_COMMANDER_MECH)) exitWith {	
					[(_attackpos_filtered_weight select _i)] call _Attacktype_mechattack;
					_sleep = _sleep + 3;
				};
			};
		};
	};
	
	//// SLEEP because brainwork is hard
	uisleep (60 * _sleep);
};




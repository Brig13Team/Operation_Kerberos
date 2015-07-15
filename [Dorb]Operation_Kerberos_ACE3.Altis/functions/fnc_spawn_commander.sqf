/*
	Author: Dorbedo
	
	Description:
		AI-Commander HQ
	
	Parameter(s):
		0 : ARRAY	- Position
	
*/
#define DEBUG_ENABLED_TEST
#include "script_component.hpp"
PARAMS_1(_position);


_difficulty = [] call FM(dyn_difficulty);



//// Create Commander-HQ
_spawnposition=[];
_einheit = dorb_commandveh_radio SELRND;
_spawnposition = [_position,200,0] call FM(random_pos);
_spawnposition = _spawnposition findEmptyPosition [1,100,_einheit];
if (count _spawnposition < 1) exitWith {ERROR("Keine Spawnposition | Commander-HQ");};
_return = [_spawnposition,(floor(random 360)),_einheit,dorb_commandveh_side] call BIS_fnc_spawnVehicle;
_commander = (_return select 0);
_commander setFuel 0;
_commander lock 3;
If (DORB_PLAYERSIDE == east) then {
	[_commander,1] spawn rhs_fnc_fmtv_Deploy;
}else{
	[_commander,1,true] spawn RHS_fnc_gaz66_radioDeploy;
};

// to interact with it externally
DORB_CURRENT_HQ = _commander;


//// Abiillities
SETVAR(_commander,DORB_COMMANDER_AI,false);
SETVAR(_commander,DORB_COMMANDER_ART,false);
SETVAR(_commander,DORB_COMMANDER_MECH,false);
SETVAR(_commander,DORB_COMMANDER_TANKS,false);
SETVAR(_commander,DORB_COMMANDER_SNIPER,false);
SETVAR(_commander,DORB_COMMANDER_AIRDROP,false);
SETVAR(_commander,DORB_COMMANDER_HELICOPTER,false);

// Helicopter Support - Nato Side gets faster helicopter support
If ((_difficulty > 2)||((dorb_side_nr > 20)&&(_difficulty>1))) then {
	SETVAR(_commander,DORB_COMMANDER_HELICOPTER,true);
};

// Air interception
If (!(worldName in ["pja305"])) then {
	_rand = floor (random 4);
	If (_rand < 2) then {SETVAR(_commander,DORB_COMMANDER_AI,true);};
};

// Arty
_rand = floor (random 4);
If (_rand < 2) then {SETVAR(_commander,DORB_COMMANDER_ART,true);};


// Tanks
_rand = floor (random 4);
If (_rand < 2) then {SETVAR(_commander,DORB_COMMANDER_TANKS,true);};


// Sniper
_rand = floor (random 4);
If (_rand < 2) then {SETVAR(_commander,DORB_COMMANDER_SNIPER,true);};

// Russian factions specialisation
If ((dorb_side_nr > 2)&&(dorb_side_nr < 6)) then {
	If ((dorb_side_nr > 2)&&(dorb_side_nr < 6)) then {
		/// VDV (Airdrop)
		SETVAR(_commander,DORB_COMMANDER_AIRDROP,true);
	}else{
		/// MSV (Mechanized infanterie)
		SETVAR(_commander,DORB_COMMANDER_MECH,true);
	};
}else{
	// Mech
	_rand = floor (random 4);
	If (_rand < 2) then {SETVAR(_commander,DORB_COMMANDER_MECH,true);};
	// Airdrop
	_rand = floor (random 4);
	If (_rand < 2) then {SETVAR(_commander,DORB_COMMANDER_AIRDROP,true);};
};




//// Create Additional Units
// Radars
If (GETVAR(_commander,DORB_COMMANDER_AI,[])) then {
	for [{_i= 1},{_i <= _difficulty},{_i = _i + 2}] do {
		_einheit = ["rhs_p37","rhs_prv13"] SELRND;
		_spawnposition = [_position,200,0] call FM(random_pos);
		_spawnposition = _spawnposition findEmptyPosition [1,100,_einheit];
		if (count _spawnposition < 1) exitWith {ERROR("Keine Spawnposition | Commandveh AI");};
		_dir = floor(random 360);
		_return = [_spawnposition,_dir,_einheit,dorb_commandveh_side] call BIS_fnc_spawnVehicle;
		_veh = (_return select 0);
		_temp = GETVAR(_commander,DORB_COMMANDER_RADAR,[]);
		_temp pushBack _veh;
		SETVAR(_commander,DORB_COMMANDER_RADAR,_temp);
	};
};
// Artypos
If (GETVAR(_commander,DORB_COMMANDER_ART,[])) then {
	for "_i" from 0 to 2 do {
		_spawnposition=[];
		_spawnposition = [_position,1800,1] call FM(random_pos);
		if ((count _spawnposition)>1) then {
			_unit = [_spawnposition,100] call FM(spawn_artypos);
			if (alive _unit) then {
				_temp = GETVAR(_commander,DORB_COMMANDER_ARTILLERIE,[]);
				_temp pushBack _unit;
				SETVAR(_commander,DORB_COMMANDER_ARTILLERIE,_temp);
			};
		}else{ERROR("Keine Spawnposition");};
	};
};


//// Call BRAIN

[_commander] call FM(spawn_commander_ai);

DORB_CURRENT_HQ = ObjNull;
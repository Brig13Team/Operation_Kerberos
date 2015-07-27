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
private["_difficulty"];

If (isNil "DORB_COMMANDER_LOGIC") then {
	private ["_center","_group"];
	_center = createCenter sideLogic;
	_group = createGroup _center;
	DORB_COMMANDER_LOGIC = _group createUnit ["LOGIC", [0, 0, 0], [], 0, "NONE"];
};

SETVAR(DORB_COMMANDER_LOGIC,DORB_COMMANDER_CURRENT_POS,_position);
SETVAR(DORB_COMMANDER_LOGIC,DORB_COMMANDER_CURRENT_HQs,[]);
SETVAR(DORB_COMMANDER_LOGIC,DORB_COMMANDER_AI,false);
SETVAR(DORB_COMMANDER_LOGIC,DORB_COMMANDER_ART,false);
SETVAR(DORB_COMMANDER_LOGIC,DORB_COMMANDER_MECH,false);
SETVAR(DORB_COMMANDER_LOGIC,DORB_COMMANDER_TANKS,false);
SETVAR(DORB_COMMANDER_LOGIC,DORB_COMMANDER_SNIPER,false);
SETVAR(DORB_COMMANDER_LOGIC,DORB_COMMANDER_AIRDROP,false);
SETVAR(DORB_COMMANDER_LOGIC,DORB_COMMANDER_HELICOPTER,false);


_difficulty = [] call FM(dyn_difficulty);

private "_allCommander";
_allCommander=[];
//// Create Commander-HQ
for "_i" from 0 to (_difficulty + 1) do {
	private["_einheit","_spawnpos","_return","_commander","_temp"];
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
	_temp = GETVAR(DORB_COMMANDER_LOGIC,DORB_COMMANDER_CURRENT_HQs,[]);
	_temp pushBack _commander;
	SETVAR(DORB_COMMANDER_LOGIC,DORB_COMMANDER_CURRENT_HQs,_temp);
};

//// Abiillities

// Helicopter Support - Nato Side gets faster helicopter support
If ((_difficulty > 2)||((dorb_side_nr > 20)&&(_difficulty>1))) then {
	SETVAR(DORB_COMMANDER_LOGIC,DORB_COMMANDER_HELICOPTER,true);
};
private "_rand";
// Air interception
If (!(worldName in ["pja305"])) then {
	_rand = floor (random 4);
	If (_rand < 3) then {SETVAR(DORB_COMMANDER_LOGIC,DORB_COMMANDER_AI,true);};
};

// Arty
_rand = floor (random 4);
If (_rand < 3) then {SETVAR(DORB_COMMANDER_LOGIC,DORB_COMMANDER_ART,true);};


// Tanks
_rand = floor (random 4);
If (_rand < 3) then {SETVAR(DORB_COMMANDER_LOGIC,DORB_COMMANDER_TANKS,true);};


// Sniper
_rand = floor (random 4);
If (_rand < 3) then {SETVAR(DORB_COMMANDER_LOGIC,DORB_COMMANDER_SNIPER,true);};

// Russian factions specialisation
If ((dorb_side_nr > 2)&&(dorb_side_nr < 6)) then {
	If ((dorb_side_nr > 2)&&(dorb_side_nr < 6)) then {
		/// VDV (Airdrop)
		SETVAR(DORB_COMMANDER_LOGIC,DORB_COMMANDER_AIRDROP,true);
	}else{
		/// MSV (Mechanized infanterie)
		SETVAR(DORB_COMMANDER_LOGIC,DORB_COMMANDER_MECH,true);
	};
}else{
	// Mech
	_rand = floor (random 4);
	If (_rand < 2) then {SETVAR(DORB_COMMANDER_LOGIC,DORB_COMMANDER_MECH,true);};
	// Airdrop
	_rand = floor (random 4);
	If (_rand < 2) then {SETVAR(DORB_COMMANDER_LOGIC,DORB_COMMANDER_AIRDROP,true);};
};




//// Create Additional Units
// Radars
If (GETVAR(DORB_COMMANDER_LOGIC,DORB_COMMANDER_AI,false)) then {
	for [{_i= 1},{_i <= _difficulty},{_i = _i + 2}] do {
		private["_einheit","_spawnpos","_spawnposition","_dir","_return","_veh","_temp"];
		_einheit = ["rhs_p37","rhs_prv13"] SELRND;
		_spawnposition = [_position,(150+(random 150)),1] call FM(random_pos);
		_spawnpos = _spawnposition findEmptyPosition [1,50,_einheit];
		if (!((_spawnpos isEqualTo []))) then {_spawnposition = _spawnpos;};
		_dir = floor(random 360);
		_return = [_spawnposition,_dir,_einheit,dorb_commandveh_side] call BIS_fnc_spawnVehicle;
		_veh = (_return select 0);
		_temp = GETVAR(DORB_COMMANDER_LOGIC,DORB_COMMANDER_RADAR,[]);
		_temp pushBack _veh;
		SETVAR(DORB_COMMANDER_LOGIC,DORB_COMMANDER_RADAR,_temp);
	};
};
// Artypos
If (GETVAR(DORB_COMMANDER_LOGIC,DORB_COMMANDER_ART,[])) then {
	for "_i" from 0 to 2 do {
		private["_spawnposition","_unit","_temp"];
		_spawnposition=[];
		_spawnposition = [_position,1800,1] call FM(random_pos);
		if ((count _spawnposition)>1) then {
			_unit = [_spawnposition,100] call FM(spawn_artypos);
			if (IS_OBJECT(_unit)&&{alive _unit}) then {
				_temp = GETVAR(DORB_COMMANDER_LOGIC,DORB_COMMANDER_ARTILLERIE,[]);
				_temp pushBack _unit;
				SETVAR(DORB_COMMANDER_LOGIC,DORB_COMMANDER_ARTILLERIE,_temp);
			};
		}else{ERROR("Keine Spawnposition");};
	};
};


//// Call BRAIN

[] call FM(spawn_commander_ai);

SETVAR(DORB_COMMANDER_LOGIC,DORB_COMMANDER_CURRENT_POS,_position);
SETVAR(DORB_COMMANDER_LOGIC,DORB_COMMANDER_CURRENT_HQs,[]);
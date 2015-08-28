/*
	Author: Dorbedo
	
	Description:
		AI-Commander HQ
	
	Parameter(s):
		0 : ARRAY	- Position
	
*/
#define DEBUG_ENABLED_TEST
#include "script_component.hpp"
SCRIPT(spawn_commander_init);
PARAMS_1(_position);
private["_difficulty"];

If (isNil QGVAR(commander_logic)) then {
	private ["_center","_group"];
	_center = createCenter sideLogic;
	_group = createGroup _center;
	GVAR(commander_logic) = _group createUnit ["LOGIC", [0, 0, 0], [], 0, "NONE"];
};

SETVAR(GVAR(commander_logic),GVAR(commander_current_pos),_position);
SETVAR(GVAR(commander_logic),GVAR(commander_current_hqs),[]);
SETVAR(GVAR(commander_logic),GVAR(commander_ai),false);
SETVAR(GVAR(commander_logic),GVAR(commander_art),false);
SETVAR(GVAR(commander_logic),GVAR(commander_mech),false);
SETVAR(GVAR(commander_logic),GVAR(commander_tanks),false);
SETVAR(GVAR(commander_logic),GVAR(commander_sniper),false);
SETVAR(GVAR(commander_logic),GVAR(commander_airdrop),false);
SETVAR(GVAR(commander_logic),GVAR(commander_helicopter),false);


_difficulty = [] call EFUNC(mission,dyn_difficulty);

private "_allCommander";
_allCommander=[];
//// Create Commander-HQ
for "_i" from 0 to (_difficulty + 1) do {
	private["_einheit","_spawnpos","_return","_commander","_temp"];
	_einheit = dorb_commandveh_radio SELRND;
	_spawnposition = [_position,350,0] call EFUNC(common,random_pos);
	_spawnposition = _spawnposition findEmptyPosition [1,100,_einheit];
	if (count _spawnposition < 1) exitWith {ERROR("Keine Spawnposition | Commander-HQ");};
	_return = [_spawnposition,(floor(random 360)),_einheit,dorb_commandveh_side] call BIS_fnc_spawnVehicle;
	_commander = (_return select 0);
	_commander setFuel 0;
	_commander lock 3;
	If (EGVAR(main,playerside) == east) then {
		[_commander,1] spawn rhs_fnc_fmtv_Deploy;
	}else{
		[_commander,1,true] spawn RHS_fnc_gaz66_radioDeploy;
	};
	_temp = GETVAR(GVAR(commander_logic),GVAR(commander_current_hqs),[]);
	_temp pushBack _commander;
	SETVAR(GVAR(commander_logic),GVAR(commander_current_hqs),_temp);
};

//// Abiillities

// Helicopter Support - Nato Side gets faster helicopter support
If ((_difficulty > 2)||((dorb_side_nr > 20)&&(_difficulty>1))) then {
	SETVAR(GVAR(commander_logic),GVAR(commander_helicopter),true);
};
private "_rand";
// Air interception
If (!(worldName in ["pja305"])) then {
	_rand = floor (random 4);
	If (_rand < 3) then {SETVAR(GVAR(commander_logic),GVAR(commander_ai),true);};
};

If (worldName in ["australia"]) then {
	SETVAR(GVAR(commander_logic),GVAR(commander_ai),true);
};

// Arty
_rand = floor (random 4);
If (_rand < 3) then {SETVAR(GVAR(commander_logic),GVAR(commander_art),true);};


// Tanks
_rand = floor (random 4);
If (_rand < 3) then {SETVAR(GVAR(commander_logic),GVAR(commander_tanks),true);};


// Sniper
_rand = floor (random 4);
If (_rand < 3) then {SETVAR(GVAR(commander_logic),GVAR(commander_sniper),true);};

// Russian factions specialisation
If ((dorb_side_nr > 2)&&(dorb_side_nr < 6)) then {
	If ((dorb_side_nr > 2)&&(dorb_side_nr < 6)) then {
		/// VDV (Airdrop)
		SETVAR(GVAR(commander_logic),GVAR(commander_airdrop),true);
	}else{
		/// MSV (Mechanized infanterie)
		SETVAR(GVAR(commander_logic),GVAR(commander_mech),true);
	};
}else{
	// Mech
	_rand = floor (random 4);
	If (_rand < 2) then {SETVAR(GVAR(commander_logic),GVAR(commander_mech),true);};
	// Airdrop
	_rand = floor (random 4);
	If (_rand < 2) then {SETVAR(GVAR(commander_logic),GVAR(commander_airdrop),true);};
};




//// Create Additional Units
// Radars
If (GETVAR(GVAR(commander_logic),GVAR(commander_ai),false)) then {
	for [{_i= 1},{_i <= _difficulty},{_i = _i + 2}] do {
		private["_einheit","_spawnpos","_spawnposition","_dir","_return","_veh","_temp"];
		_einheit = ["rhs_p37","rhs_prv13"] SELRND;
		_spawnposition = [_position,(150+(random 150)),1] call EFUNC(common,random_pos);
		_spawnpos = _spawnposition findEmptyPosition [1,50,_einheit];
		if (!((_spawnpos isEqualTo []))) then {_spawnposition = _spawnpos;};
		_dir = floor(random 360);
		_return = [_spawnposition,_dir,_einheit,dorb_commandveh_side] call BIS_fnc_spawnVehicle;
		_veh = (_return select 0);
		_temp = GETVAR(GVAR(commander_logic),DORB_COMMANDER_RADAR,[]);
		_temp pushBack _veh;
		SETVAR(GVAR(commander_logic),DORB_COMMANDER_RADAR,_temp);
	};
};
// Artypos
If (GETVAR(GVAR(commander_logic),GVAR(commander_art),[])) then {
	for "_i" from 0 to 2 do {
		private["_spawnposition","_unit","_temp"];
		_spawnposition=[];
		_spawnposition = [_position,1800,1] call EFUNC(common,random_pos);
		if ((count _spawnposition)>1) then {
			_unit = [_spawnposition,100] call EFUNC(spawn,artypos);
			if (IS_OBJECT(_unit)&&{alive _unit}) then {
				_temp = GETVAR(GVAR(commander_logic),GVAR(commander_artillerie),[]);
				_temp pushBack _unit;
				SETVAR(GVAR(commander_logic),GVAR(commander_artillerie),_temp);
			};
		}else{ERROR("Keine Spawnposition");};
	};
};


//// Call BRAIN

[] call FUNC(commander_ai);

SETVAR(GVAR(commander_logic),GVAR(commander_current_pos),_position);
SETVAR(GVAR(commander_logic),GVAR(commander_current_hqs),[]);
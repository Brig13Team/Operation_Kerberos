	/*
	Author: Dorbedo

	Description:
		Creates Mission "TOWER".

	Parameter(s):
		0 :	ARRAY - Position

	Returns:
	BOOL
*/
#include "script_component.hpp"
SCRIPT(tower);
_this params ["_position"];
TRACEV_1(_position)

/********************
	create Target
********************/
private ["_targets","_spawnposition","_rand","_einheit","_unit"];
_targets=[];
_spawnposition=[];
_rand = ((floor(random 2)) + 1);
for "_i" from 1 to _rand do{
	_einheit = GVAR(list_tower) SELRND;
	_spawnposition = [_position,25,200,15,0.15] call EFUNC(common,pos_flatempty);
	If (_spawnposition isEqualTo []) then {
		_spawnposition = [_position,25,200,15,0.22] call EFUNC(common,pos_flatempty);
	};
	If (_spawnposition isEqualTo []) then {
		_spawnposition = [_position,200,0] call EFUNC(common,pos_random);
		_spawnposition = _spawnposition findEmptyPosition [1,100,_einheit];
		if !(_spawnposition isEqualTo []) then {
			_unit = createVehicle [_einheit,_spawnposition, [], 0, "NONE"];
			_unit setVectorUp [0,0,1];
			_targets pushBack _unit;
		};
	}else{
		_unit = createVehicle [_einheit,_spawnposition, [], 0, "NONE"];
		_unit setVectorUp [0,0,1];
		_targets pushBack _unit;
	};	
};
/********************
	godmode
********************/
{
	_x setdamage 0;
	SETVAR(_x,GVAR(target_dead),false);
	_x addEventHandler ["HandleDamage", {_this call EFUNC(common,handledamage_C4);}];	
} forEach _target;

/********************
	taskhandler
********************/

[
	QUOTE(params['_targets'];private '_a';_a = {GETVAR(_x,GVAR(target_dead),false);}count _targets;If (_a == (count _targets)) then {true}else{false};),
	_targets,
	"true"
]
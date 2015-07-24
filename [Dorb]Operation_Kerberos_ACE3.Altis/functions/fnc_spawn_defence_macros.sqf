/*
	Author: Dorbedo

	Description:
		spawns predefines defence-Makros

	Parameter(s):
		0 :	ARRAY	- Centerpos
		1 : SCALAR 	- Radius
		2 : SCALAR	- Number of spawned positions


	Returns:
	ARRAY : Array with Positions

	
	
	Limitations: it can happen that the direction of the makro is turned onto a hill, if the gradient of the terrain behind the hill is high.
	
	
	
*/
#include "script_component.hpp"

PARAMS_1(_position);
DEFAULT_PARAM(1,_radius,1000);
DEFAULT_PARAM(2,_anzahl_spawnpos,3);
DEFAULT_PARAM(3,_isTown,false);
_town=0;
If(_isTown)then{_town=1;};
_all_spawnpos = [];
_searchrad = 150 min (_radius / 4);
_errorcounter = 0; // prevents infinitive loop






//// Random Positions -> moved to open Area
//// If not enaugh positions are found, the amount of spawned macros is reduced

For "_i" from 0 to _anzahl_spawnpos do {
	_temp = [_position,_radius,_town] call FM(random_pos);
	If (_isTown) then {
		_temp = [_position,( ( floor(random( abs(_radius - 300) )) ) + 300),_town] call FM(random_pos);
	};
	_spawnpos = [_temp,15,_searchrad,15,0.18] call FM(pos_flatempty);
	If (_spawnpos isEqualTo []) then {
		_spawnpos = [_temp,15,_searchrad,15,0.3] call FM(pos_flatempty);
	};
	If (!(_spawnpos isEqualTo [])) then {
		_addpos = true;
		for "_j" from 0 to ((count _all_spawnpos)-1) do {
			if (((_all_spawnpos select _j)distance _spawnpos)<25) then {
				_addpos = false;
			};
		};
		if (_addpos) then {
			_all_spawnpos pushBack _spawnpos;
		}else{
			DEC(_i);
			INC(_errorcounter);
		};
	};
	CHECK(_errorcounter>100)
};


///// spawns makros in the best direction
_makros = 		["small_veh_tank_high","small_veh_tank_low","small_veh_zsu","big_static_AA","big_veh_zsu","big_tower_mg","big_bunker","big_mortar_3","big_mortar_1","bunker_medium","camp_medium","camp_small","AT_medium"];
_markos_weight =[		0.4,				0.15,					1,			0.9,			0.8,			0.5,		0.3,			0.3,		0.5,			0.2,			0.6,		0.7,			0.6	];
/*
If (DORB_MODS_RDS) then {
	_makros append [100];
	_markos_weight append [100];
};
*/
{
	/// Get gooddirs -> good sight from the defined pos
	_gooddirs = [];
	private "_i";
	for [{_i= 1},{_i <= 360},{_i = _i + 10}] do {
		_defencepos = _x;
		_defencepos set [2,((_defencepos select 2)+0.9)];
		_aimpos = [_x, 450, 50] call BIS_fnc_relPos;
		//_aimpos set[2,(_defencepos select 2)];
		_gooddir = terrainIntersect[_defencepos,_aimpos];
		If (!_gooddir) then {
			_gooddirs pushBack _i;
		};
	};
	
	/// choose the best dir
	
	_bestdir = 0;
	_bestdir_level = 0;
	_defencepos = ATLtoASL _x;
	for "_j" from 0 to ((count _gooddirs)-1) do {
		_templevel = 0;
		for [{_k= 1},{_k <= 450},{_k = _k + 20}] do {
			_aimpos = [_x, _k, (_gooddirs select _j)] call BIS_fnc_relPos;
			_aimpos = ATLtoASL _aimpos;
			_differenz = ((_defencepos select 2)-(_aimpos select 2));
			_currentlevel = _differenz * ((floor((23-(_k/20))/3))max 0.2);
			_templevel = _templevel + _currentlevel;
		};
		If (_templevel > _bestdir_level) then {
			_bestdir = (_gooddirs select _j);
			_bestdir_level = _templevel;
		};
	};
	
	
	// If there is no bestdir (because of terrain) -> randomize
	
	If (_bestdir == 0) then {_bestdir = random 360;};
	
	
	/// debug
	
	if (dorb_debug) then {
		_mrkr = createMarker [format["defencepos-%1",_x],_x];
		_mrkr setMarkerShape "ICON";
		_mrkr setMarkerColor "ColorBlue";
		_mrkr setMarkerType "mil_arrow2";
		_mrkr setMarkerDir _bestdir;
	};
	
	///// spawn defence
	_currentmakro = -1;
	_currentmakro = [_makros,_markos_weight] call BIS_fnc_selectRandomWeighted;
	_configarray = ["missionConfigFile","defence_positions","terrain"];
	_configarray pushBack _currentmakro;
	
	[_x,_configarray,_bestdir] call FM(spawn_macro_exec3d);
	
}forEach  _all_spawnpos;





















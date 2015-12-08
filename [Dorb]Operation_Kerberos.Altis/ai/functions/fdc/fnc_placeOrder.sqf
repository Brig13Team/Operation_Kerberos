/*
	Author: Dorbedo
	
	Description:
		places an artillery order
	
	Parameter(s):
		0 : ARRAY	- Position / Start Position
		1 : SCALAR	- Type AUTO=-1 , ARTY = 0 , MORTAR = 1 , ROCKET = 2
		2 : SCALAR	- Amount (might be overwritten by MODE)
		(optional)
		3 : ARRAY	- ["MODE",[Parameter]]
							* ["creeping",direction,range,size in m (200m Standard)]
							* ["smoke"]
							* ["flare"]
*/

#include "script_component.hpp"
SCRIPT(placeOrder);
#define CREEPING_DISTANCE 80


params[["_attackpos",[],[[]],[2,3]],["_type",-1,[0]],["_amount",-1,[0]],["_modearray",[],[[]]]];
TRACEV_4(_attackpos,_type,_amount,_modearray);
If (_attackpos isEqualTo []) exitWith {false};
private "_cancel";
_cancel = false;
If ((count _attackpos)<2) then {
	_attackpos pushBack 0;
};

If (!(_modearray isEqualTo [])) then {
	_cancel=true;
	_modearray params [["_mode","",[""]],["_direction",-1,[2]],["_range",100,[0]],["_size",200,[0]]];
	TRACEV_3(_mode,_goalpos,_size);
	switch (_mode) do {
		case "creeping" : {
			CHECK(_direction < 0)
			private ["_side_shots","_direction_shots","_temp_center","_positions_array"];
			_side_shots = (floor((_size/2)/ CREEPING_DISTANCE)) min 2;
			_direction_shots = (floor((_range)/ CREEPING_DISTANCE)) min 6;
			_positions_array = [];
			_temp_center = _attackpos;
			
			for "_i" from 0 to _direction_shots do {
				_positions_array pushBack _temp_center;
				
				for "_j" from 1 to _side_shots do {
					_positions_array pushBack [_temp_center,CREEPING_DISTANCE*_j,(_direction+90)] call BIS_fnc_relPos;
					_positions_array pushBack [_temp_center,CREEPING_DISTANCE*_j,(_direction+270)] call BIS_fnc_relPos;
				};
				
				_temp_center = [_attackpos,CREEPING_DISTANCE*(_i+1),_direction] call BIS_fnc_relPos;
			};
			
			{
				[_x,0,1] call FUNC(fdc_placeOrder);
			}forEach _positions_array;
		};
		case "smoke" : {
			GVAR(fdc_firemissions) pushBack [_position,_type,"Smoke_120mm_AMOS_White",_amount];
			TRACEV_3(_position,_type,_amount);
		};
		case "flare" : {
			GVAR(fdc_firemissions) pushBack [_position,1,"Flare_82mm_AMOS_White",_amount];
			TRACEV_3(_position,1,_amount);
		};
	};
};



if(_cancel) exitWith {false;};
_cancel = switch (_type) do {
	case -1 : {
				true
	
			};
	case 0 : {
				If (GVAR(fdc_artilleries) isEqualTo []) exitWith {true};
				_unit = GVAR(fdc_artilleries) SELRND;
				_shelltype = ((getArtilleryAmmo [_unit])select 0);
				If (_amount < 0) then {_amount = 6;};
				false;
			};
	case 1 : {
				If (GVAR(fdc_mortars) isEqualTo []) exitWith {true};
				_unit = GVAR(fdc_mortars) SELRND;
				_shelltype = ((getArtilleryAmmo [_unit])select 0);
				If (_amount < 0) then {_amount = 3;};
				false
			};
	case 2 : {
				If (GVAR(fdc_rocket) isEqualTo []) exitWith {true};
				_unit = GVAR(fdc_rocket) SELRND;
				_shelltype = ((getArtilleryAmmo [_unit])select 0);
				_ammo = getText(configFile>>"CfgMagazines">> _shelltype >> "ammo");
				_submun = getText(configFile>>"CfgAmmo">>_ammo>>"submunitionAmmo");
				_strength = getNumber(configFile>>"CfgAmmo">>_submun>>"hit");
				_ammo = floor(3000/(_strength)) min 1;
				false
			};
};


if(_cancel) exitWith {false};
GVAR(fdc_firemissions) pushBack [_position,_type,_shelltype,_amount];

true


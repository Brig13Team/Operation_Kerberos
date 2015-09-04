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
If (isNil QGVAR(fdc_logic)) exitWith {false};

params[["_attackpos",[],[[]],[2,3]],["_type",-1,[0]],["_amount",-1,[0]],["_modearray",[],[[]]]];
TRACEV_4(_attackpos,_type,_amount,_modearray);
If (_attackpos isEqualTo []) exitWith {false};
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
			_side_shots = (floor((size/2)/CREEPING_DISTANCE))min 2;
			_direction_shots = (floor((_range)/CREEPING_DISTANCE))min 6;
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
		};		
	};
};

if(_cancel) exitWith {false};
_cancel = switch (_type) do {
	case -1 : {
				true
	
			};
	case 0 : {
				_shelltype = ((getArtilleryAmmo [_unit])select 0);
				_artilleries = GETVAR(GVAR(fdc_logic),GVAR(fdc_artilleries),[]);
				If (_artilleries isEqualTo []) exitWith {false};
				If (_amount < 0) then {_amount = 6;};
				true
			};
	case 1 : {
				_shelltype = ((getArtilleryAmmo [_unit])select 0);
				_artilleries = GETVAR(GVAR(fdc_logic),GVAR(fdc_mortars),[]);
				If (_artilleries isEqualTo []) exitWith {false};
				If (_amount < 0) then {_amount = 3;};
				true
			};
	case 2 : {
				_shelltype = ((getArtilleryAmmo [_unit])select 0);
				_artilleries = GETVAR(GVAR(fdc_logic),GVAR(fdc_rocket),[]);
				If (_artilleries isEqualTo []) exitWith {false};
				_ammo = getText(configFile>>"CfgMagazines">> _shelltype >> "ammo");
				_submun = getText(configFile>>"CfgAmmo">>_ammo>>"submunitionAmmo");
				_strength = getNumber(configFile>>"CfgAmmo">>_submun>>"hit");
				_ammo = floor(3000/(_strength)) min 1
				true
			};
};


if(_cancel) exitWith {false};
_temp = GETVAR(GVAR(fdc_logic),GVAR(fdc_firemissions),[]);
_temp pushBack [_position,_type,_shelltype,_amount];
TRACEV_4(_position,_type,_shelltype,_amount);
SETVAR(GVAR(fdc_logic),GVAR(fdc_firemissions),_temp);

true


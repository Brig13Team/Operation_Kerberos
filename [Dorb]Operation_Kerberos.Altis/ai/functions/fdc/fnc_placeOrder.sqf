/*
	Author: Dorbedo
	
	Description:
		places an artillery order
	
	Parameter(s):
		0 : ARRAY	- Position
		1 : SCALAR	- Type AUTO=-1 , ARTY = 0 , MORTAR = 1 , ROCKET = 2
*/

#include "script_component.hpp"
SCRIPT(placeOrder);

If (isNil QGVAR(fdc_logic)) exitWith {false};

params[["_attackpos",[],[[]],[2,3]],["_type",-1,[0]],["_amount",-1,[0]]];

If (_attackpos isEqualTo []) exitWith {false};
_cancel = false;
If ((count _attackpos)<2) then {
	_attackpos pushBack 0;
};

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
			};
};


if(_cancel) exitWith {false};
_temp = GETVAR(GVAR(fdc_logic),GVAR(fdc_firemissions),[]);
_temp pushBack [_position,_type,_shelltype,_amount];
SETVAR(GVAR(fdc_logic),GVAR(fdc_firemissions),_temp);

true


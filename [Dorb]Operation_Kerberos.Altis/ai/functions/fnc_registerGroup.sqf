/*
	Author: Dorbedo
	
	Description:
		registers a group for the HQ
	
	Parameter(s):
		0:GROUP	- the group to be registered

	Returns:
		none
*/
#include "script_component.hpp"
SCRIPT(registerGroup);
_this params[["_group",grpnull,[grpnull]]];
TRACEV_1(_group);
CHECK(isNull _group)
CHECK(GETVAR(_group,GVAR(registered),false))


private["_units","_vehicles","_temp"];
_temp = [_group];
_vehicles = [];
_units = units _group;
TRACEV_1(_units);

{
	If !(vehicle _x != _x) then {
		_vehicles pushback (vehicle _x);
	};
	
}forEach _units;

if (_vehicles isEqualTo []) exitWith {
	SETVAR(_group,GVAR(registered),true);
	_temp pushback (GETMVAR(GVAR(Infanterie),[]));
	SETMVAR(GVAR(Infanterie),_group);
};

If ((_vehicles select 0) isKindOf "Air") exitWith {
	If ((toLower(getText(configFile >> "CfgVehicles" >> (typeOf (_vehicles select 0)) >> "simulation")))in ["helicopterrtd","helicopterx"]) then {
		If (ISCASVEHICLE(_vehicles select 0)) then {
			SETVAR(_group,GVAR(registered),true);
			_temp pushback (GETMVAR(GVAR(Attack_Helicopter),[]));
			SETMVAR(GVAR(Attack_Helicopter),_group);
		}else{
			SETVAR(_group,GVAR(registered),true);
			_temp pushback (GETMVAR(GVAR(Transport_Helicopter),[]));
			SETMVAR(GVAR(Transport_Helicopter),_group);
		};
	}else{
		If (ISCASVEHICLE(_vehicles select 0)) then {
			SETVAR(_group,GVAR(registered),true);
			_temp pushback (GETMVAR(GVAR(CAS_Plane),[]));
			SETMVAR(GVAR(CAS_Plane),_group);
		}else{
			SETVAR(_group,GVAR(registered),true);
			_temp pushback (GETMVAR(GVAR(Air_other),[]));
			SETMVAR(GVAR(Air_other),_group);
		};
	};
};

If ((_vehicles select 0)isKindOf "Armored") exitWith {
	SETVAR(_group,GVAR(registered),true);
	_temp pushback (GETMVAR(GVAR(Tank),[]));
	SETMVAR(GVAR(Tank),_group);	
};

If ((_vehicles select 0)isKindOf "Autonomous") exitWith {
	SETVAR(_group,GVAR(registered),true);
	_temp pushback (GETMVAR(GVAR(Drone),[]));
	SETMVAR(GVAR(Drone),_group);	
};

If ((_vehicles select 0)isKindOf "Car") exitWith {
	SETVAR(_group,GVAR(registered),true);
	_temp pushback (GETMVAR(GVAR(Car),[]));
	SETMVAR(GVAR(Car),_group);	
};

If ((_vehicles select 0)isKindOf "Ship") exitWith {
	SETVAR(_group,GVAR(registered),true);
	_temp pushback (GETMVAR(GVAR(marine),[]));
	SETMVAR(GVAR(marine),_group);
};

SETVAR(_group,GVAR(registered),true);
_temp pushback (GETMVAR(GVAR(Other),[]));
SETMVAR(GVAR(Other),_group);


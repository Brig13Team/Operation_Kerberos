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
CHECK(isNull _group)
CHECK(GETVAR(_group,GVAR(HQ_registered),false))


private["_units","_vehicles"];
_vehicles = [];
_units = units group;


{
	If (_x != (vehicle _x)) then {
		_vehicles pushback (vehicle _x);
	};
}forEach _units;

if (_vehicles isEqualTo []) exitWith {
	SETVAR(_group,GVAR(HQ_registered),true);
	private "_temp";
	_temp = GETMVAR(GVAR(HQ_Infanterie),[]);
	_temp pushback _group;
	SETMVAR(GVAR(HQ_Infanterie),_group);
};

If ((_vehicles select 0) isKindOf "Air") exitWith {
	If ((toLower(getText(configFile >> "CfgVehicles" >> (typeOf (_vehicles select 0)) >> "simulation")))in ["helicopterrtd","helicopterx"]) then {
		If (IS_ATTACK_HELI(_vehicles select 0)) then {
			SETVAR(_group,GVAR(HQ_registered),true);
			private "_temp";
			_temp = GETMVAR(GVAR(HQ_Attack_Helicopter),[]);
			_temp pushback _group;
			SETMVAR(GVAR(HQ_Attack_Helicopter),_group);
		}else{
			SETVAR(_group,GVAR(HQ_registered),true);
			private "_temp";
			_temp = GETMVAR(GVAR(HQ_Transport_Helicopter),[]);
			_temp pushback _group;
			SETMVAR(GVAR(HQ_Transport_Helicopter),_group);
		};
	}else{
		If (IS_ATTACK_PLANE(_vehicles select 0)) then {
			SETVAR(_group,GVAR(HQ_registered),true);
			private "_temp";
			_temp = GETMVAR(GVAR(HQ_CAS_Plane),[]);
			_temp pushback _group;
			SETMVAR(GVAR(HQ_CAS_Plane),_group);
		}else{
			SETVAR(_group,GVAR(HQ_registered),true);
			private "_temp";
			_temp = GETMVAR(GVAR(HQ_Air_other),[]);
			_temp pushback _group;
			SETMVAR(GVAR(HQ_Air_other),_group);
		};
	};
};

If ((_vehicles select 0)isKindOf "Armored") exitWith {
	SETVAR(_group,GVAR(HQ_registered),true);
	private "_temp";
	_temp = GETMVAR(GVAR(HQ_Tank),[]);
	_temp pushback _group;
	SETMVAR(GVAR(HQ_Tank),_group);	
};

If ((_vehicles select 0)isKindOf "Autonomous") exitWith {
	SETVAR(_group,GVAR(HQ_registered),true);
	private "_temp";
	_temp = GETMVAR(GVAR(HQ_Drone),[]);
	_temp pushback _group;
	SETMVAR(GVAR(HQ_Drone),_group);	
};

If ((_vehicles select 0)isKindOf "Car") exitWith {
	SETVAR(_group,GVAR(HQ_registered),true);
	private "_temp";
	_temp = GETMVAR(GVAR(HQ_Car),[]);
	_temp pushback _group;
	SETMVAR(GVAR(HQ_Car),_group);	
};

If ((_vehicles select 0)isKindOf "Ship") exitWith {
	SETVAR(_group,GVAR(HQ_registered),true);
	private "_temp";
	_temp = GETMVAR(GVAR(HQ_marine),[]);
	_temp pushback _group;
	SETMVAR(GVAR(HQ_marine),_group);
};

SETVAR(_group,GVAR(HQ_registered),true);
private "_temp";
_temp = GETMVAR(GVAR(HQ_Other),[]);
_temp pushback _group;
SETMVAR(GVAR(HQ_Other),_group);


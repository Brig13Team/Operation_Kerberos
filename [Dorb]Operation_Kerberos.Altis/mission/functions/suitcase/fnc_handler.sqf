/*
	Author: Dorbedo
	
	Description:
		init function
	
*/
#include "script_component.hpp"
SCRIPT(init);

CHECK(!isServer)


params["_params","_handle"];
_params params ["_suitcase"];


_carrier = _suitcase getVariable [QGVAR(suitcase_carrier),objNull];

if (isNull _carrier) exitWith {
	_pos = _suitcase getVariable [QGVAR(suitcase_pos),[]];
	If !(_pos isEqualTo []) then {
		_suitcase setPos _pos;
	};
	_suitcase setVariable [QGVAR(suitcase_carrierInCar),false];
	[_handle] call CBA_fnc_removePerFrameHandler;
};

If ( (!(isNull attachedTo _suitcase)) && {(vehicle _carrier) != _carrier} ) exitWith {
	detach _suitcase;
	if (isMultiplayer) then {
		_suitcase enableSimulationGlobal false;
	} else {
		_suitcase enableSimulation false;
	};
	_carrier forceWalk false;
	_suitcase setPosASL [0,0,1000];
};

If ( ((isNull attachedTo _suitcase)) && {(vehicle _carrier) == _carrier} ) exitWith {
	if (isMultiplayer) then {
		_suitcase enableSimulationGlobal true;
	} else {
		_suitcase enableSimulation true;
	};
	[_suitcase,_carrier] spawn {
		params ["_suitcase","_carrier"];

		_carrier action ["SwitchWeapon", _carrier, _carrier, 100];

		uiSleep ANIM_TIME;
		_suitcase attachTo [_carrier, ATTACH_POINT, "RightHand"];
		_suitcase setDir 90;
		_carrier forceWalk true;	
	};
};




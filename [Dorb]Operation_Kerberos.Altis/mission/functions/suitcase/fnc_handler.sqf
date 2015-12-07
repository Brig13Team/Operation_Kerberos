/*
	Author: Dorbedo
	
	Description:
		init function
	
*/
#include "script_component.hpp"
SCRIPT(init);

CHECK(!hasinterface)


#define ATTACH_POINT [0,0,-0.1]



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
	_suitcase setPos [0,0,0];
	if (isMultiplayer) then {
		_suitcase enableSimulationGlobal false;
	} else {
		_suitcase enableSimulation false;
	};
	_player forceWalk false;
};

If ( ((isNull attachedTo _suitcase)) && {(vehicle _carrier) == _carrier} ) exitWith {
	if (isMultiplayer) then {
		_suitcase enableSimulationGlobal true;
	} else {
		_suitcase enableSimulation true;
	};
	_suitcase attachTo [_carrier, ATTACH_POINT, "RightHand"];
	_suitcase setDir 90;
	_carrier forceWalk true;
	};	
};




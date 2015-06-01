/*
	Author: Dorbedo
	
	Description:
		Only Pilots can fly
	
	Parameter(s):
		0 : OBJ	- unit
		1 : ARRAY- Position in Vehicle
		2 : Obj	- player
*/
#include "script_component.hpp"

_this addEventHandler ["GetIn",
{
	PARAMS_3(_veh,_pos,_unit);
	
	_type = typeOf _unit;
	//_crew = [""];
	_pilot = ["B_Pilot_F","B_Helipilot_F"];
	_kick = false;
	
	//if (_veh iskindOf "LandVehicle" AND !(_type in _crew)) then {_kick = true};
	if (_veh iskindOf "Air" AND ((!(_type in _pilot))or(GETVAR(_unit,DORB_ISPILOT,false)))) then {_kick = true;};
		
	if (_pos == "driver" or _unit == _veh turretunit [0]) then {
			if (_kick) then {
				if (isEngineOn _veh) then {_veh engineOn false};
				unassignVehicle _unit;
				_unit action ["Eject", _veh];
				_unit action ["GetOut", _veh];
				if (_unit == player) then {
					hint format[localize "STR_DORB_NURPILOTEN",name player];
				};
			};
	} else {
		if (_kick) then {
			_allowed = _unit spawn {
				_veh = vehicle _this;
				while {alive _this AND (vehicle _this) == _veh} do {
					if (alive _this AND (vehicle _this) == _veh AND ((driver _veh) == _this OR _this == _veh turretunit [0])) then {
						if (isEngineOn _veh) then {_veh engineOn false};
						unassignVehicle _this;
						_this action ["Eject", _veh];
						_this action ["GetOut", _veh];
						if (_this == player) then {
							hint format[localize "STR_DORB_NURPILOTEN",name player];
						};
					};
					sleep 1;
				};
			};
		};
	};
}];
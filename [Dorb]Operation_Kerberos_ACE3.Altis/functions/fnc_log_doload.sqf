/*
	Author: Dorbedo
	
	Description:
		Checks if Unit can load
		
	Parameter(s):
		0 : OBJECT - Target
		
	Returns:
		BOOL
*/
#include "script_component.hpp"
SCRIPT(log_doload);
PARAMS_1(_target);

	CHECK(GETVAR(player,DORB_ISLOADING,false))
	private["_nearObjects","_object"];
	_nearObjects = nearestObjects[(_target modelToWorld (getArray(missionConfigFile >> "logistics" >> "vehicles" >> (typeOf _target) >> "load_point"))), ["AllVehicles","ThingX"], 3];
	_object = objNull;
	{
		If (isClass(missionConfigFile >> "logistics" >> "cargos" >> (typeOf _x))) exitWith {
			_object = _x;
		};
	}forEach _nearObjects;
	If (!isNull _object) then {
		SETVAR(player,DORB_ISLOADING,true);
		[
			5,
			{true},
			{_this call FM(log_load);SETVAR(player,DORB_ISLOADING,false);},
			{SETVAR(player,DORB_ISLOADING,false);},
			[_object,_target]
		] call FM(disp_progressbar);
		//[_object,_target] call FM(log_load);
		
		//SETVAR(player,DORB_ISLOADING,false);
	};


/*
private["_nearObjects","_object"];
_nearObjects = nearestObjects[(_target modelToWorld (getArray(missionConfigFile >> "logistics" >> "vehicles" >> (typeOf _target) >> "load_point"))), ["AllVehicles","ThingX"], 3];
_object = objNull;
{
	If (isClass(missionConfigFile >> "logistics" >> "cargos" >> (typeOf _x))) exitWith {
		_object = _x;
	};
}forEach _nearObjects;
If (!isNull _object) then {[_object,_target] call FM(log_load)};
SETVAR(player,DORB_ISLOADING,false);

*/
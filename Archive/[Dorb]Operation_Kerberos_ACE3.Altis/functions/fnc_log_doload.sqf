/*
	Author: Dorbedo
	
	Description:
		loads an object
		
	Parameter(s):
		0 : OBJECT - Target
		
	Returns:
		BOOL
*/
#include "script_component.hpp"
SCRIPT(log_doload);
#define LOADTIME 3
PARAMS_1(_target);

CHECK(GETVAR(player,DORB_ISLOADING,false))
private["_nearObjects","_object"];
_nearObjects = nearestObjects[(_target modelToWorld (getArray(missionConfigFile >> "logistics" >> "vehicles" >> (typeOf _target) >> "load_point"))), ["AllVehicles","ThingX"], 3];
_object = objNull;

{
	If (!(([typeOf _x] call FM(log_getCargoCfg))isEqualTo "")) exitWith {
		_object = _x;
	};
}forEach _nearObjects;

If (!isNull _object) then {
	SETVAR(player,DORB_ISLOADING,true);
	DORB_ISLOADING_POS=getPos player;
	private["_anim"];
	_anim = getText(missionConfigFile >> "logistics" >> "vehicles" >> (typeOf _target) >> "hatch_isclosed");
	If (!(_anim isEqualTo "")) then {
		If (_target call compile _anim) then {
			_target call (compile (getText(missionConfigFile >> "logistics" >> "vehicles" >> (typeOf _target) >> "hatch_open")));
			private "_isopened";
			_isopened = compile (getText(missionConfigFile >> "logistics" >> "vehicles" >> (typeOf _target) >> "hatch_isopened"));
			waitUntil{uisleep 0.2;_target call _isopened;};
		};
	};
	DORB_LOG_ACEACTIONS = [false,false];
	If (GETVAR(_object,ACE_dragging_canDrag,false)) then {
		DORB_LOG_ACEACTIONS set [0,true];
		SETPVAR(_object,ACE_dragging_canDrag,false);
	};
	If (GETVAR(_object,ACE_dragging_canCarry,false)) then {
		DORB_LOG_ACEACTIONS set [1,true];
		SETPVAR(_object,ACE_dragging_canCarry,false);
	};
	SETPVAR(_object,DORB_LOG_ACEACTIONS,DORB_LOG_ACEACTIONS);
	[
		LOADTIME,
		{(((getPos player) distance DORB_ISLOADING_POS)<1)},
		{_this call FM(log_load);SETVAR(player,DORB_ISLOADING,false);},
		{SETVAR(player,DORB_ISLOADING,false);},
		[_object,_target]
	] call FM(disp_progressbar);
};

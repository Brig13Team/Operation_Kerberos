/*
	Author: Dorbedo
	
	Description:
		revon
	
	Parameter(s):
		none

	Returns:
		none
*/
#include "script_component.hpp"
SCRIPT(strategy_airborne);
_this params ["_currentLogic"];

private _currentPos = getPos _currentLogic;

private _position = [_currentPos,200,1] call EFUNC(common,random_pos);
private _spawnpos = [GVAR(centerpos),(GVAR(definitions) select 0)+500,1] call EFUNC(common,random_pos);
_spawnpos set [2,400];
private _transporthelicopter = getArray(missionconfigfile >> "unitlists" >> str GVARMAIN(side) >> GVARMAIN(side_type)>> "callIn" >> "airborne" >> "transport");

private _dir = [_spawnpos, _position] call BIS_fnc_dirTo;
private _einheit = _transporthelicopter SELRND;

([_spawnpos,GVARMAIN(side),_einheit,_dir,true,true,"FLY"] call EFUNC(spawn,vehicle)) params ["_transporterGroup","_transporter"];

_transporter setpos [_spawnpos];
_transporter flyInHeight 400;
_transporter setSpeedMode "FULL";
_transporter setBehaviour "CARELESS";

#ifdef DEBUG_MODE_FULL
	[_spawnpos,"","ColorRed","o_plane",_dir] call EFUNC(common,debug_marker_create);
#endif

private _jaeger = getArray(missionconfigfile >> "unitlists" >> str GVARMAIN(side) >> GVARMAIN(side_type)>> "callIn" >> "airinterception" >> "units");

private _jaeger_gruppe = createGroup GVARMAIN(side);
SETVAR(_jaeger_gruppe,EGVAR(mission,istarget),true);
_jaeger_gruppe setCombatMode "RED";

for "_i" from 0 to 5 do {
	_einheit = _jaeger SELRND;
	[[(_spawnpos select 0),(_spawnpos select 1),0],_jaeger_gruppe,_einheit] call FUNC(unit);
};

uisleep 1;

{
	_x assignAsCargo _transporter;
	_x moveInCargo _transporter;
}forEach units _jaeger_gruppe;

SETVAR(_jaeger_gruppe,GVAR(target),_currentPos);
SETVAR(_jaeger_gruppe,GVAR(state),'attack');
[_jaeger_gruppe] call FUNC(state_change);

uisleep 2;
(_spawn_array select 2) addWaypoint [_position,100];
(_spawn_array select 2) addWaypoint [_spawnpos,100];
[_position,_spawnpos,_jaeger_gruppe,_transporter] spawn {
	params["_position","_spawnpos","_jaeger_gruppe","_transporter"];
	while {(alive _transporter) and (canMove _transporter)} do {
		_transporter doMove _position;
		[_jaeger_gruppe] call FUNC(state_change);
		waitUntil {((_transporter distance _position) < (_flughoehe + 110))};
		
		SETVAR(_jaeger_gruppe,EGVAR(mission,istarget),false);
		
		{
			_x enableAI "Move";
			unassignVehicle (_x);
			_x allowDamage false;
			moveOut _x;
			sleep 0.2;
			private _fallschirm = createVehicle ["NonSteerable_Parachute_F",(getPos _x), [], 0, "FLY"];
			_x moveInDriver _fallschirm;
			sleep 0.2;
			_x allowDamage true;		
		} forEach units _jaeger_gruppe;
		
		_transporter domove _spawnpos;
		waitUntil {((_transporter distance _spawnpos) < (_flughoehe + 100))};
		if (true) exitWith {};
	};
	SETVAR(_jaeger_gruppe,EGVAR(mission,istarget),false);
	{deletevehicle _x} foreach crew _transporter;
	deletevehicle _transporter;
};
([_jaeger_gruppe] call FUNC(strength)) params ["_type","_strength"];
_strength;
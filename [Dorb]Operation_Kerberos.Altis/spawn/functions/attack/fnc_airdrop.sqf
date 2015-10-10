/*
	Author: Dorbedo
	
	Description:
	
	Requirements:
	
	Parameter(s):
		0 : ARRAY	- Example
		1 : ARRAY	- Example
		2 : STRIN	- Example
	
	Return
	BOOL
*/
#include "script_component.hpp"
SCRIPT(airdrop);
CHECK(!isServer)

private ["_spawnpos","_dir","_einheit","_transporter","_jaeger_gruppe","_jaeger","_platzanzahl"];
params["_position",["_type",400,[0]],["_dropradius",200,[0]],["_spawnradius",1700,[0]],["_flughoehe",400,[0]]];
LOG_5(_position,_type,_dropradius,_spawnradius,_flughoehe);


_position = [_position,100,0] call EFUNC(common,random_pos);

sleep (random 9);
_spawnpos = [_position,_spawnradius,1] call EFUNC(common,random_pos);
_spawnpos_inf = _spawnpos;
_spawnpos set [2,_flughoehe];
_dir = [_spawnpos, _position] call BIS_fnc_dirTo;
_einheit = dorb_transport_heli_list call BIS_fnc_selectRandom;

LOG_4(_spawnpos,_dir,_einheit,GVARMAIN(side));

_spawn_array = [_spawnpos, _dir, _einheit, GVARMAIN(side)] call BIS_fnc_spawnVehicle;
_transporter = _spawn_array select 0;

_transporter setpos [_spawnpos];
_transporter flyInHeight _flughoehe;
_transporter setSpeedMode "FULL";
_transporter setBehaviour "CARELESS";


if (dorb_debug) then {
	_mrkr = createMarker [format["airdrop-%1",_transporter],_spawnpos];
	_mrkr setMarkerShape "ICON";
	_mrkr setMarkerColor "ColorRed";
	_mrkr setMarkerType "o_plane";
};



_jaeger_gruppe = createGroup GVARMAIN(side);
SETVAR(_jaeger_gruppe,EGVAR(mission,istarget),true);
_jaeger_gruppe setCombatMode "RED";
_platzanzahl = _transporter emptyPositions "cargo";
for "_i" from 0 to (_platzanzahl - 2) do {
	_einheit = dorb_menlist call BIS_fnc_selectRandom;
	_jaeger = [[(_spawnpos select 0),(_spawnpos select 1),0],_jaeger_gruppe,_einheit] call FUNC(unit);
	//sleep 0.1;
	
	//_jaeger assignAsCargo _transporter;
	//_jaeger assignAsCargo  [_transporter, _i];
	//sleep 0.3;
	//_jaeger moveInCargo _transporter;
	//_jaeger moveInCargo _transporter;
	//sleep 0.4;
	//_jaeger disableAI "Move";
	
};

sleep 1;

{
	_x assignAsCargo _transporter;
	_x moveInCargo _transporter;
}forEach units _jaeger_gruppe;

[_jaeger_gruppe, _position, 400, 5, "MOVE", "AWARE", "RED", "NORMAL", "STAG COLUMN", "", [5,10,15]] call EFUNC(spawn,taskPatrol);

sleep 2;
(_spawn_array select 2) addWaypoint [_position,100];
(_spawn_array select 2) addWaypoint [_spawnpos,100];

If (_type < 1) then {
	while {(alive _transporter) and (canMove _transporter)} do {
		//_transporter addWaypoint [_position,100];
		//_transporter doMove _position;
		//sleep 4;
		_transporter doMove _position;
		LOG(FORMAT_1("Entfernung=%1",_transporter distance _position));
		//LOG(FORMAT_1("Flughoehe=%1",ADD(_flughoehe,100)));
		
		waitUntil {((_transporter distance _position) < (_flughoehe + 100))};
			{
				_x enableAI "Move";
				unassignVehicle (_x);
				_x allowDamage false;
				moveOut _x;
				sleep 0.2;
				_fallschirm = createVehicle ["NonSteerable_Parachute_F",(getPos _x), [], 0, "FLY"];
				_x moveInDriver _fallschirm;
				sleep 0.2;
				_x allowDamage true;		
			} forEach units _jaeger_gruppe;
		//[_jaeger_gruppe, _position, 400, 5, "MOVE", "AWARE", "RED", "NORMAL", "STAG COLUMN", "", [5,10,15]] call EFUNC(spawn,taskPatrol);
		
		SETVAR(_jaeger_gruppe,EGVAR(mission,istarget),false);
		_transporter domove _spawnpos;
		waitUntil {((_transporter distance _spawnpos) < (_flughoehe + 100))};
		if (true) exitWith {};
	};
	{deletevehicle _x} foreach crew _transporter;
	deletevehicle _transporter;
}else{
	_transporter doMove _position;
	waitUntil {((_transporter distance _position) < (_flughoehe + 100))};
	_jaeger_gruppe leaveVehicle _transporter;
	waitUntil {(_transporter emptyPositions "cargo" == _platzanzahl)};
	[_jaeger_gruppe, _position, 400, 5, "MOVE", "AWARE", "RED", "NORMAL", "STAG COLUMN", "", [5,10,15]] call EFUNC(spawn,taskPatrol);
	_transporter domove _spawnpos;
	waitUntil {((_transporter distance _spawnpos) < (_flughoehe + 100))};
	{deletevehicle _x} foreach crew _transporter;
	deletevehicle _transporter;
};


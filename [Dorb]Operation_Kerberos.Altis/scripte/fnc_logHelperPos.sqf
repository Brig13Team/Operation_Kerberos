/*
	Author: Dorbedo
	
	hint typeOf cursorTarget;[cursortarget] execVM "functions\scripte\fnc_logHelperPos.sqf";
*/

params[["_vehicle",objNull,[objNull]]];

if(isNull _vehicle) exitWith {hint "Kein Fahrzeug übergeben"};

DORB_HELPER_VEH = _vehicle;
DORB_HELPER_CARGOPOS = [];
DORB_HELPER_CARGOPOS_ALL = [];
DORB_HELPER_CARGOPOS_UNIT = [];

If (!(isNil "DORB_HELPER_ARROW")) then {
	{deleteVehicle _x} forEach DORB_HELPER_ARROW;
};
DORB_HELPER_UPDATE = false;

If (!(isNil "DORB_HELPER_ID")) then {
	[DORB_HELPER_ID] call CBA_fnc_removePerFrameHandler;
};
private["_oldDirPlayer","_oldPosPlayer"];
_oldPosPlayer = getPos player;
_oldDirPlayer = getDir player;

private ["_CountCargo"];
_CountCargo = DORB_HELPER_VEH emptyPositions "cargo";
For "_i" from 0 to (_CountCargo -1) do {
	private "_temp";
	player moveInCargo [DORB_HELPER_VEH,_i];
	uiSleep 0.5;
	_temp = DORB_HELPER_VEH worldToModel (getPos player);
	DORB_HELPER_CARGOPOS_ALL pushBack [(DORB_HELPER_VEH getCargoIndex player),_temp];
	DORB_HELPER_CARGOPOS pushBack (DORB_HELPER_VEH getCargoIndex player);
	moveOut player;
};
player setPos _oldPosPlayer;
player setDir _oldDirPlayer;


DORB_HELPER_ARROW = [];
DORB_HELPER_ID = [{
	private["_pos"];
	If (isNull DORB_HELPER_VEH) exitWith {[_this select 1] call CBA_fnc_removePerFrameHandler;{deleteVehicle _x} forEach DORB_HELPER_ARROW;};
	If (DORB_HELPER_UPDATE) exitWith {};
	
	{
		If (_x > (count DORB_HELPER_CARGOPOS_ALL)) then {DORB_HELPER_CARGOPOS deleteAt _forEachIndex;};
	}forEach DORB_HELPER_CARGOPOS;
	
	If ((count DORB_HELPER_CARGOPOS)!=(count DORB_HELPER_ARROW)) then {
		DORB_HELPER_UPDATE = true;
		{deleteVehicle _x} forEach DORB_HELPER_ARROW;
		DORB_HELPER_ARROW = [];
		{
			DORB_HELPER_ARROW pushBack (createVehicle ["Sign_Arrow_F", [0,0,0], [], 0, "CANCOLLIDE"]);
		} forEach DORB_HELPER_CARGOPOS;
		DORB_HELPER_UPDATE = false;
	};
	
	{
		private "_pos";
		_pos = DORB_HELPER_VEH modelToWorld ((DORB_HELPER_CARGOPOS_ALL select _x)select 1);
		(DORB_HELPER_ARROW select _x) setPos _pos;
	}forEach DORB_HELPER_CARGOPOS;
}, 0, []] call CBA_fnc_addPerFrameHandler;
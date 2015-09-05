/*
	Author: iJesuz
	
	Description:
	
	Parameter(s):
		0 : OBJECT - drone
		1 : OBJECT - target
	
*/
#include "script_component.hpp"
SCRIPT(attack);

params [["_drone",objNull,[objNull]],["_target",objNull,[objNull]]];
private ["_muzzle"];

if (isNull _drone) exitWith { false };
if (isNull _target) exitWith { false };
if (damage _target == 1) exitWith { false };
if (!isText (missionConfigFile >> "drones" >> typeOf _drone >> "muzzle")) exitWith { false };

_muzzle = getText (missionConfigFile >> "drones" >> typeOf _drone >> "muzzle");

_drone fireAtTarget [_target,_muzzle]

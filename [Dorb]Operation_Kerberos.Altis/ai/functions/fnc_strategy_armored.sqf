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
SCRIPT(strategy_armored);
_this params ["_currentLogic"];

private _currentPos = getPos _currentLogic;

private _spawnpos = [_currentPos,6000,2] call EFUNC(common,random_pos);
CHECKRET((_spawnpos isEqualTo []),0);

GVAR(callInArray) params ["_airborne","_airinterception","_armored","_cas","_fortifications","_motorized","_drones"];
GVAR(callInArray) = [_airborne,_airinterception,(_armored-1),_cas,_fortifications,_motorized,_drones];

private _allTanks = getNumber(missionconfigfile >> "unitlists" >> str GVARMAIN(side) >> GVARMAIN(side_type)>> "callIn" >> "armored" >> "units");
private _TankVehType = _allTanks SELRND;
_spawnpos set [2,1500];
_dir = [_spawnpos, _currentPos] call BIS_fnc_dirTo;

([_spawnpos,GVARMAIN(side),_TankVehType,_dir,true,true,"FLY"] call EFUNC(spawn,vehicle)) params ["_tankGroup","_tankVeh"];

SETVAR(_tankGroup,GVAR(target),_currentPos);
SETVAR(_tankGroup,GVAR(state),'attack');
[_tankGroup] call FUNC(state_change);

([_tankGroup] call FUNC(strength)) params ["_type","_strength"];
_strength;
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
SCRIPT(strategy);
_this params [
	["_attacklogics",[],[[]]],
	["_groups",[],[[]]]
	];


private _attackarray = [];
{
	private _currentLogic = _attacklogics select _i;
	private _currentEnemy = _currentLogic getVariable [QGVAR(enemy),0];
	private _currentTroops = _currentLogic getVariable [QGVAR(troopsNeeded),0];
	_attackarray pushBack [_currentTroops,_currentEnemy,_currentLogic];
} forEach _attacklogics;

_attackarray sort true;



for "_i" from 0 to (count _attackarray - 1) do {
	(_attackarray select _i) params ["_currenttroopsNeeded","_currentEnemy","_currentLogic"];
	private _currentStrategy = _currentLogic getVariable [QGVAR(strategy),[]];
	
	If (_currentStrategy isEqualTo []) then {
		// if the strategy failed
		If (_currentEnemy*0.2>_currenttroopsNeeded) then {
			[_currentLogic] call FUNC(strategy_failed);
			[(_attackarray select _i),_groups] call FUNC(strategy_choose);
		};
	}else{
		(_attackarray select _i) call FUNC(strategy_choose);
	};
};


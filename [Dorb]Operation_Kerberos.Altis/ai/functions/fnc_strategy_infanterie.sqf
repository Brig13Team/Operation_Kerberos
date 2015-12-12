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
SCRIPT(strategy_infanterie);
_this params ["_currentLogic","_attackgroups"];

private _currentPos = getPos _currentLogic;
private _currentEnemy = _currentLogic getVariable [QGVAR(enemy),0];
private _currentTroops = _currentLogic getVariable [QGVAR(troopsNeeded),0];


for "_i" from 0 to ((count _currentTroops) -1) do {
	if (_currentTroops <= 0) exitWith {};
	private _currentGroup = _currentTroops select _i;
	SETVAR(_currentGroup,GVAR(target),_currentPos);
	SETVAR(_currentGroup,GVAR(state),"attack");
	[_currentGroup] call FUNC(state_change);
	([_tankgroup] call FUNC(strenght))params ["_type","_strength"];
	
	_currentTroops = _currentTroops - _strength;
};


_currentTroops;


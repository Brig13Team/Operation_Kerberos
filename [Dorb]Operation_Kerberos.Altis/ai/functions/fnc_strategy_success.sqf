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
SCRIPT(strategy_success);
_this params ["_currentLogic"];

private _Strategy_Memory = GETPRVAR(GVAR(strategy_memory),[]);

private _currentStrategie = GETVAR(_currentLogic,GVAR(strategy),[]);

CHECK(_currentStrategie isEqualTo [])

_currentStrategie params ["_enemyID","_strategyID"];

private _currentEnemy = (_Strategy_Memory select _enemyID);
private _currentStrat = _currentEnemy select _strategyID;

_currentStrat set [2,(_currentStrat select 2)+1];

_currentEnemy set [_strategyID,_currentStrat];

_Strategy_Memory set [_enemyID,_currentEnemy];

SETPRVAR(GVAR(strategy_memory),_Strategy_Memory);

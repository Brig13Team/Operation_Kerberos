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
_this params ["_currentLogic"];

_Strategy_Memory = GETPRVAR(GVAR(strategy_memory),[]);

/*
private _nearHelicopters = [];
private _nearSoldiers = [];
private _nearTanks = [];
private _nearVehicles = [];

{
	if (side _x == GVARMAIN(playerside)) then {
		_nearSoldiers pushBack _x;
	};
}forEach ((getPos _currentLogic) nearEntities ["CAManBase",400]);

{
	if (side _x == GVARMAIN(playerside)) then {
		_nearTanks pushBack _x;
	};
}forEach ((getPos _currentLogic) nearEntities ["Tank",400]);

{
	if (side _x == GVARMAIN(playerside)) then {
		_nearHelicopters pushBack _x;
	};
}forEach ((getPos _currentLogic) nearEntities ["Helicopter",400]);

{
	if (side _x == GVARMAIN(playerside)) then {
		_nearVehicles pushBack _x;
	};
}forEach ((getPos _currentLogic) nearEntities ["Car",400]);
*/

private _nearSoldiers = GVARMAIN(playerside) countSide ((getPos _currentLogic) nearEntities ["CAManBase",400]);

private _nearTanks = GVARMAIN(playerside) countSide ((getPos _currentLogic) nearEntities ["Tank",400]);

private _nearHelicopters = GVARMAIN(playerside) countSide ((getPos _currentLogic) nearEntities ["Helicopter",400]);

private _nearVehicles = GVARMAIN(playerside) countSide ((getPos _currentLogic) nearEntities ["Car",400]);

private _enemyArray = [_nearHelicopters,_nearTanks,_nearVehicles,_nearSoldiers];


/*
	[
		[_enemyHelicopters,_enemyTanks,_enemyVehicles,_enemySoldiers],
		[_chosenStrategie,_fails,_wins],
		[_chosenStrategie,_fails,_wins],
		[_chosenStrategie,_fails,_wins],
		[_chosenStrategie,_fails,_wins],
		[_chosenStrategie,_fails,_wins],
		....
	]
*/


private _enemyID = -1;

{
	if ((_x select 0) == _enemyArray) exitWith {
		_enemyID = _forEachIndex;
	};
}forEach _Strategy_Memory;


private _strategyArray = [];

#define ANZAHL_STRAT
If (_enemyID < 0) then {
	_Strategy_Memory pushBack [
		[_enemyHelicopters,_enemyTanks,_enemyVehicles,_enemySoldiers],
		["_strategie_1",0,0],
		["_strategie_2",0,0],
		["_strategie_3",0,0],
		["_strategie_4",0,0],
		["_strategie_5",0,0],
		["_strategie_6",0,0],
		["_strategie_7",0,0],
		["_strategie_8",0,0]
	];
	SETPRVAR(GVAR(strategy_memory),_Strategy_Memory);
	_enemyID = (count _Strategy_Memory)-1;
};

for "_i" from 1 to (count (_Strategy_Memory select _enemyID) -1) do {
	((_Strategy_Memory select _enemyID)select _i) params ["_tempStrategie","_fails","_wins"];
	private _probability = If ((_fails == 0)||(_wins == 0)) then {
			If (_wins > 0) then {
				1
			}else{
				If (_fails > 0) then {
					0.1
				}else{
					0.5
				};
			};
		}else{
			((_fail + _wins)/_wins)
		};
	_strategyArray pushBack [_tempStrategie,_probability];
};



_chosenStrategie = [_strategyArray,1] call FUNC(common,sel_array_weighted);

_currentLogic call (missionnamespace getVariable [format["%1_%2",QGVAR(fnc_strategy),_chosenStrategie],{}]);



SETVAR(_currentLogic,GVAR(strategy),_chosenStrategie);

GVAR(callInArray) = [_airborne,_airinterception,_armored,_cas,_fortifications,_motorized];
















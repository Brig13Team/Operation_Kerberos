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
SCRIPT(strategy_choose);

_this params ["_attackarray","_groups"];
_attackarray params ["_currenttroopsNeeded","_currentEnemy","_currentLogic"];

GVAR(callInArray) params ["_airborne","_airinterception","_armored","_cas","_fortifications","_motorized","_drones"];

_Strategy_Memory = GETPRVAR(GVAR(strategy_memory),[]);

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
	
	private _strategies = [];
	private _config = missionnamespace>>"strategy";
	for "_i" from 0 to (count _config -1) do {
		_strategies pushBack [configname (_config select _i),0,0];
	};
	
	private _temp = [[_enemyHelicopters,_enemyTanks,_enemyVehicles,_enemySoldiers]] pushBack _strategies;
	
	_Strategy_Memory pushBack _temp;
	SETPRVAR(GVAR(strategy_memory),_Strategy_Memory);
	_enemyID = (count _Strategy_Memory)-1;
};

for "_i" from 1 to (count (_Strategy_Memory select _enemyID) -1) do {
	((_Strategy_Memory select _enemyID)select _i) params ["_tempStrategie","_fails","_wins"];
	private _condition = getText(missionnamespace>>"strategy">>_tempStrategie);
	If (call compile _condition) then {	
		private _probability = If ((_fails == 0)||(_wins == 0)) then {
				If (_wins > 0) then {
					1
				}else{
					If (_fails > 0) then {
						0.1
					}else{
						getNumber(missionnamespace>>"strategy">>_tempStrategie>>"probability")
					};
				};
			}else{
				((_fail + _wins)/_wins)
			};
		_strategyArray pushBack [_tempStrategie,_probability];
	};
};



_chosenStrategie = [_strategyArray,1] call FUNC(common,sel_array_weighted);

private _params = compile (getText(missionnamespace>>"strategy">>_chosenStrategie>>"parameter"));
_newTroops = _params call (missionnamespace getVariable [format["%1_%2",QGVAR(fnc_strategy),_chosenStrategie],{}]);



SETVAR(_currentLogic,GVAR(strategy),_chosenStrategie);

GVAR(callInArray) = [_airborne,_airinterception,_armored,_cas,_fortifications,_motorized,_drones];
















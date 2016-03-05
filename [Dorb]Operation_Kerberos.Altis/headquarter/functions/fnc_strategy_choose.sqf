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

_this params ["_currenttroopsNeeded","_currentEnemy","_currentLocation","_groups"];
TRACEV_4(_currenttroopsNeeded,_currentEnemy,_currentLocation,_groups);


_Strategy_Memory = GETPRVAR(GVAR(strategy_memory),[]);

private _enemySoldiers = GVARMAIN(playerside) countSide ((getPos _currentLocation) nearEntities ["CAManBase",400]);
private _enemyTanks = GVARMAIN(playerside) countSide ((getPos _currentLocation) nearEntities ["Tank",400]);
private _enemyHelicopters = GVARMAIN(playerside) countSide ((getPos _currentLocation) nearEntities ["Helicopter",400]);
private _enemyVehicles = GVARMAIN(playerside) countSide ((getPos _currentLocation) nearEntities ["Car",400]);
_enemySoldiers = 50;


private _enemyArray = [_enemyHelicopters,_enemyTanks,_enemyVehicles,_enemySoldiers];


TRACEV_4(_nearSoldiers,_nearTanks,_nearHelicopters,_nearVehicles);
TRACEV_1(_Strategy_Memory);
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

If ((!IS_ARRAY(_Strategy_Memory select 0))||{!IS_ARRAY((_Strategy_Memory select 0)select 0)}) then {
    _Strategy_Memory = [];
};


private _enemyID = -1;

{
    if ((_x select 0) isEqualTo _enemyArray) exitWith {
        _enemyID = _forEachIndex;
    };
}forEach _Strategy_Memory;


private _strategyArray = [];


If (_enemyID < 0) then {
    
    private _strategies = [];
    private _config = (missionconfigfile>>"strategy");
    for "_i" from 0 to ((count _config) -1) do {
        _strategies pushBack [configname (_config select _i),0,0];
    };
    TRACEV_1(_strategies);
    private _temp = [[_enemyHelicopters,_enemyTanks,_enemyVehicles,_enemySoldiers]];
    _temp append _strategies;
    TRACEV_1(_temp);
    _Strategy_Memory pushBack _temp;
    TRACEV_1(_Strategy_Memory);
    SETPRVAR(GVAR(strategy_memory),_Strategy_Memory);
    _enemyID = (count _Strategy_Memory)-1;
};
TRACEV_2(_enemyID,GVAR(strategy_memory));

private _tankGroups = [];
private _infanterieGroups = [];
private _helicoptersGroups = [];
{
    private _currentGroup = _x;
    private _currentType = "soldier";
    {
        If ((vehicle _x) isKindOf "Air") exitWith {_currentType = "air";};
        If ((vehicle _x) isKindOf "Armored") exitWith {_currentType = "tank";};
    }forEach (units _currentGroup);
    switch (_currentType) do {
        case "air" : {_helicoptersGroups pushBack _currentGroup;};
        case "tank" : {_tankGroups pushBack _currentGroup;};
        default {_infanterieGroups pushBack _currentGroup};
    };
}forEach _groups;



for "_i" from 1 to (count (_Strategy_Memory select _enemyID) -1) do {
    _test = ((_Strategy_Memory select _enemyID)select _i);
    TRACEV_1(_test);
    ((_Strategy_Memory select _enemyID)select _i) params ["_tempStrategie","_fails","_wins"];
    private _condition = getText(missionconfigfile>>"strategy">>_tempStrategie>>"condition");
    _test = (call compile _condition);
    TRACEV_1(_test);
    If (call compile _condition) then {    
        private _probability = If ((_fails == 0)||(_wins == 0)) then {
                If (_wins > 0) then {
                    1
                }else{
                    If (_fails > 0) then {
                        0.1
                    }else{
                        getNumber(missionconfigfile>>"strategy">>_tempStrategie>>"probability")
                    };
                };
            }else{
                ((_fail + _wins)/_wins)
            };
        _strategyArray pushBack [_tempStrategie,_probability];
    };
};


TRACEV_1(_strategyArray);
CHECK(_strategyArray isEqualTo [])
_chosenStrategie = ([_strategyArray,1] call EFUNC(common,sel_array_weighted))select 0;
TRACEV_1(_chosenStrategie);
private _parameter = call compile (getText(missionconfigfile>>"strategy">>_chosenStrategie>>"parameter"));
TRACEV_1(_parameter);
_newTroops = _parameter call (missionnamespace getVariable [format["%1_%2",QGVAR(fnc_strategy),_chosenStrategie],{}]);


SETVAR(_currentLocation,GVAR(troopsNeeded),_newTroops);
SETVAR(_currentLocation,GVAR(strategy),_chosenStrategie);


















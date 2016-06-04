/*
    Author: Dorbedo
    
    Description:
        choosing the strategy from config
    
    Parameter(s):
        none

    Returns:
        none
*/
#include "script_component.hpp"

_this params ["_currenttroopsNeeded","_cost","_currentLocation","_type","_strengtharray","_groups"];
TRACEV_4(_currenttroopsNeeded,_cost,_currentLocation,_type,_strengtharray,_groups);


/*
    Strategy memory
    
    [
        [_type,_cost,_strengtharray],
        [_chosenStrategie,_fails,_wins],
        [_chosenStrategie,_fails,_wins],
        [_chosenStrategie,_fails,_wins],
        [_chosenStrategie,_fails,_wins],
        [_chosenStrategie,_fails,_wins],
        ....
    ]
*/

// get the history and choose the similar one

_Strategy_Memory = GETPRVAR(GVAR(strategy_memory),[]);
If ((!IS_ARRAY(_Strategy_Memory select 0))||{!IS_ARRAY((_Strategy_Memory select 0)select 0)}) then {
    _Strategy_Memory = [];
};

private _enemyID = -1;
{
    if ((_x select 0) isEqualTo _enemyArray) exitWith {
        _enemyID = _forEachIndex;
    };
}forEach _Strategy_Memory;

private _current_Memory_Strategy = [];
If (_enemyID >= 0) then {
    _current_Memory_Strategy = _Strategy_Memory select _enemyID;
};

//// Update the Variables
private _tankGroups = [];
private _infanterieGroups = [];
private _helicoptersGroups = [];
{
    
    
} forEach _groups;





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






// get all possible Strategys

private _strategyCfg = (missionConfigFile >> "strategy");
private _possibleStrategys = [];

For "_i" from 0 to ((count _strategyCfg)-1) do {
    private _isPossible = true;
    private _currentStrategy = _strategyCfg select _i;
    private _conditionCfg = (_currentStrategy >> "conditions");
    for "_j" from 1 to 99 do {
        private _condition = getText(_currentStrategy >> "conditions" >> format["c%1",_j]);
        If (_condition isEqualTo "") exitWith {};
        If !(compile(_condition)) exitWith {
            _isPossible = false;
        };
    };
    If (_isPossible) then {
        _possibleStrategys pushBack (configName _currentStrategy);
    };
};


// addWeight to all Strategys
_strategies_weighted = [];
{
    private _found = false;
    If ((!(_current_Memory_Strategy isEqualTo []))) then {
        For "_i" from 1 to ((count _current_Memory_Strategy)-1) do {
            if (((_current_Memory_Strategy select _i)select 0) == _x) then {
                ((_current_Memory_Strategy select _i)select 0) params ["_strat","_win","_loose"];
                _win = _win max 0.01;
                _loose = _loose max 0.01;
                _strategies_weighted pushBack [(_win/(_win+_loose)),_x];
                _found = true;
            };
        };
    };
    If !(_found) then {
        _strategies_weighted pushBack [0.5,_x];
    };
} forEach _possibleStrategys;


If (_strategies_weighted isEqualTo []) exitWith {};

// randomize the strategy

private _chosenStrategie = ([_strategies_weighted,0] call EFUNC(common,sel_array_weighted))select 1;
TRACEV_1(_chosenStrategie);

/// execute the strategy
private _parameter = call compile (getText(missionconfigfile>>"strategy">>_chosenStrategie>>"parameter"));
TRACEV_1(_parameter);
_newTroops = _parameter call (missionnamespace getVariable [format["%1_%2",QGVAR(fnc_strategy),_chosenStrategie],{}]);


SETVAR(_currentLocation,GVAR(troopsNeeded),_newTroops);
SETVAR(_currentLocation,GVAR(strategy),_chosenStrategie);









/*
    Author: Dorbedo
    
    Description:
        execues the strategie
    
    Parameter(s):
        none

    Returns:
        none
*/
#include "script_component.hpp"
_this params [
    ["_attacklocations",[],[[]]],
    ["_groups",[],[[]]]
    ];
TRACEV_2(_attacklocations,_groups);

private _attackarray = [];
{
    private _currentLocation = _x;
    private _currentEnemy =  importance _currentLocation;
    private _nearPlayers = allPlayers select {((_x distance _currentLocation) < ATTACKPOS_DISTANCE)};
    private _strengtharray = [_nearPlayers] call FUNC(strength_player);
    private _currentTroops = _currentLocation getVariable QGVAR(troopsNeeded);
    If (isNil "_currentTroops") then {
        _currentTroops = _currentEnemy;
        _currentLocation setVariable [QGVAR(troopsNeeded),_currentTroops];
    };
    _attackarray pushBack [_currentTroops,_currentEnemy,_currentLocation,_strengtharray select 0,_strengtharray select 2];
} forEach _attacklocations;

_attackarray sort true;

{
    (_attackarray select _i) params ["_currenttroopsNeeded","_currentEnemy","_currentLocation","_type","_strengtharray"];
    private _currentStrategy = _currentLocation getVariable [QGVAR(strategy),[]];
    If (_currentStrategy isEqualTo []) then {
        [_currenttroopsNeeded,_currentEnemy,_currentLocation,_type,_strengtharray,_groups] call FUNC(strategy__choose);
    }else{
        // strategy failed
        If ((_currentEnemy*0.2)>_currenttroopsNeeded) then {
            [_currentLocation] call FUNC(strategy_failed);
            [_currenttroopsNeeded,_currentEnemy,_currentLocation,_type,_strengtharray,_groups] call FUNC(strategy__choose);
        };
    };
} forEach _attackarray;

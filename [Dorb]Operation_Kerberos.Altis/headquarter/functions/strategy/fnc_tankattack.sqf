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
_this params ["_currentLocation","_attackgroups"];
TRACEV_2(_currentLocation,_attackgroups);
private _currentPos = getPos _currentLocation;
private _currentEnemy = importance _currentLocation;
private _currentTroops = _currentLocation getVariable [QGVAR(troopsSend),0];


for "_i" from 0 to ((count _attackgroups) -1) do {
    if (_currentTroops <= 0) exitWith {};
    private _currentGroup = _attackgroups select _i;
    SETVAR(_currentGroup,GVAR(target),_currentPos);
    SETVAR(_currentGroup,GVAR(state),"attack");
    [_currentGroup] call FUNC(state_change);
    ([_currentGroup] call FUNC(strenght)) params ["_type","_strength"];
    
    _currentTroops = _currentTroops - _strength;
};


_currentTroops;







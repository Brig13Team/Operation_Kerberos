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
_this params ["_currentLogic"];
private _currentTroops = _currentLogic getVariable [QGVAR(troopsNeeded),0];
private _currentPos = getPos _currentLogic;

private _pos = [GVAR(centerpos),(GVAR(definitions) select 0)+800,1] call EFUNC(common,random_pos);
private _einheitArray = getArray(missionconfigfile >> "unitlists" >> str GVARMAIN(side) >> GVARMAIN(side_type)>> "callIn" >> "motorized" >> "units");
private _einheit = _einheitArray SELRND;

private _spawnpos = _pos findEmptyPosition [1,200,_einheit];
CHECKRET((_spawnpos isEqualTo []),0)
GVAR(callIn_motorized) = GVAR(callIn_motorized) - 1;

([_spawnpos,GVARMAIN(side),_einheit,(random 360),true,true] call EFUNC(spawn,vehicle)) params ["_transporterGroup","_transporter"];

private _jaeger_gruppe = createGroup GVARMAIN(side);
_jaeger_gruppe setCombatMode "RED";
private _platzanzahl = _transporter emptyPositions "cargo" min 6;
for "_i" from 0 to _platzanzahl do {
    private _einheit = GVAR(list_soldiers) SELRND;
    [_spawnpos,_jaeger_gruppe,_einheit] call EFUNC(spawn,unit);
};
uisleep 1;        
{
    _x assignAsCargo _transporter;
    _x moveInCargo _transporter;
}forEach units _jaeger_gruppe;

SETVAR(_jaeger_gruppe,GVAR(target),_currentPos);
SETVAR(_jaeger_gruppe,GVAR(state),'attack');
[_jaeger_gruppe] call FUNC(state_change);

_transporterGroup addWaypoint [_currentPos,100];
[_transporter,_spawnpos,_jaeger_gruppe,_spawnpos] spawn {
    params ["_transporter","_spawnpos","_jaeger_gruppe","_spawnpos"];
    while {((isNil "_transporter")&&{canMove _transporter})} do {
        _transporter doMove _currentPos;
        waitUntil {((_transporter distance _currentPos) < 400)};
        {
            unassignVehicle (_x);
            _x allowDamage false;
            moveOut _x;
            sleep 0.3;                            
            _x allowDamage true;        
        } forEach units _jaeger_gruppe;
        _transporter domove _spawnpos;
        waitUntil {((_transporter distance _spawnpos) < 150)};
        if (true) exitWith {};
    };
    {deletevehicle _x} foreach crew _transporter;
    deletevehicle _transporter;
};
([_jaeger_gruppe] call FUNC(strength)) params ["_type","_strength"];
_currentTroops - _strength;
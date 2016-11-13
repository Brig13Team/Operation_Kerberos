/*
 *  Author: Dorbedo
 *  OriginalAuthor: PabstMirror (ACE3)
 *
 *  Description:
 *      onkilled Event
 *
 *  Parameter(s):
 *      0 : OBJECT - Hitted Unit
 *      1 : OBJECT - Causing Unit
 *      2 : SCALAR - Damage
 *      3 : OBJECT - instigator
 *
 *  Returns:
 *      none
 *
 */
#include "script_component.hpp"

_this params ["_unit", ["_killer", objNull]];

CHECK(!(local _unit))

private _killInfo = [];
if ((isNull _killer) || {_killer == _unit}) then {
    private _aceSource = _unit getVariable ["ace_medical_lastDamageSource", objNull];
    if ((!isNull _aceSource) && {_aceSource != _unit}) then {
        _killer = _aceSource;
    };
};

// If killer is a vehicle get the commander (this is how vanilla does it?) and log the vehicle type
if ((!isNull _killer) && {!(_killer isKindof "CAManBase")}) then {
    _killer = effectiveCommander _killer;
};

private _unitIsPlayer = hasInterface && {_unit == ace_player}; // isPlayer check will fail at this point
private _killerIsPlayer = (!isNull _killer) && {_unit != _killer} && {[_killer] call ACEFUNC(common,isPlayer)};

// Don't do anything if neither are players
if (!(_unitIsPlayer || _killerIsPlayer)) exitWith {};

[
    QGVAR(teamkill),
    [_unit,_killer]
] call CBA_fnc_serverEvent;

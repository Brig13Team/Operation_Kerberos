/*
 *  Author: Dorbedo
 *  OriginalAuthor: PabstMirror (ACE3)
 *
 *  Description:
 *      onHit Event
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

_this params [["_unit",objNull],["_killer", objNull],["_damage",0],["_instigator", objNull]];

CHECK(!(isPlayer _unit))

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
private _killerIsPlayer = (!isNull _killer) && {_unit != _killer} && {[_killer,true] call ace_common_fnc_isPlayer};

// Don't do anything if neither are players
if (!(_unitIsPlayer || _killerIsPlayer)) exitWith {};

If ((_unit == _killer)||{side _unit != side _killer}) exitWith {};

[
    QGVAR(teamfire),
    [_unit,_killer,_damage]
] call CBA_fnc_serverEvent;

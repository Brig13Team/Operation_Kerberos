/**
 * Author: Dorbedo
 * TFAR onSpeak Event
 *
 * Arguments:
 * 0: <OBJECT> the unit
 * 1: <BOOL> is speaking
 *
 * Return Value:
 * Nothing
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params [["_unit", objNull, [objNull]], ["_isSpeaking", false, [true]]];

if ((!local _unit) || {!alive _unit} || {(vehicle _unit) call TFAR_fnc_isVehicleIsolated}) exitWith {};

private _nearHostiles = _unit nearEntities [["Car", "Motorcycle", "Tank", "CAManBase", "Man"], TF_speak_volume_meters - 2];

{
    if (!(isPlayer _x) && {!isNull _x} && {!((vehicle _x) call TFAR_fnc_isVehicleIsolated)} && {_x knowsAbout _unit <= 1.5}) then {
        [_x,[_unit,1.5]] remoteExec ["reveal", _x];
    };
    true
} count _nearHostiles;

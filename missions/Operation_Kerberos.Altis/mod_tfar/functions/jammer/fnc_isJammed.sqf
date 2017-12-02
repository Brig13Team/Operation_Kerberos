/**
 * Author: Dorbedo
 * returns if an unit is jammed
 *
 * Arguments:
 * 0: <OBJECT> the unit to be checked
 *
 * Return Value:
 * <BOOL> isJammed
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params [["_unit", objNull, [objNull]]];

If (isNull _unit) exitWith {};

private _isJammed = false;
{
    _x params ["_jammer","_range"];
    If (([_jammer] call FUNC(jammer_isActive)) && {(_unit distance _jammer)<= (_range * (_unit getVariable ["tf_receivingDistanceMultiplicator", 1.0]))}) exitWith {
        _isJammed = true;
    };
} count (missionNamespace getVariable [QGVAR(jammer), []]);

_isJammed

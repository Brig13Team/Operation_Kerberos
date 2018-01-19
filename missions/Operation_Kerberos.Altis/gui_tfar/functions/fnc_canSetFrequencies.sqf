/**
 * Author: Dorbedo
 * the unit can set the squad frequencies
 *
 * Arguments:
 * 0: <OBJECT> the unit
 *
 * Return Value:
 * <BOOL> the unit is allowd to set the frequencies
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params [["_unit", objNull, [objNull]]];

if !(alive _unit) exitWith {false};

(leader _unit) isEqualTo _unit

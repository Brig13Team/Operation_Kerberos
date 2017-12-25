/**
 * Author: Dorbedo
 * adds the night items for units
 *
 * Arguments:
 * 0: <OBJECT> the unit
 *
 * Return Value:
 * Nothing
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params [["_unit", objNull, [objNull]]];

if ((isNull _unit) || {isPlayer _unit}) exitWith {};

private _cache = GVAR(cache) getVariable ("soldier" + typeOf _unit);

If !(isNil "_cache") then {
    [_unit, _cache select 0, _cache select 1, _cache select 2] call FUNC(addNightItems);
} else {
    _cache = [_unit] call FUNC(addNightItems);
    GVAR(cache) setVariable [("soldier" + typeOf _unit), _cache];
};

if (_cache select 1) then {
    _unit enableGunLights "AUTO";
};
if (_cache select 2) then {
    _unit enableIRLasers true;
};

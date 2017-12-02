/**
 * Author: Dorbedo
 * disables TFAR for a Unit
 *
 * Arguments:
 * 0: <OBJECT> the unit
 * 1: <BOOL> disable Default:true
 *
 * Return Value:
 * <TYPENAME> return name
 *
 */

#include "script_component.hpp"

params [["_object", objNull, [objNull]], ["_disable", true, [true]]];

If ((isNull _object) || {(_object getVariable ["tf_unable_to_use_radio", false]) isEqualTo _disable}) exitWith {};

_object setVariable ["tf_unable_to_use_radio", _disable, true];

/**
 * Author: Dorbedo
 * returns the replacement for a unit, if another faction/side was chosen
 *
 * Arguments:
 * 0: <STRING> the unitclass
 *
 * Return Value:
 * <STRING> the replacement, empty string if there is no replacement possible
 *
 */

#include "script_component.hpp"

params [["_vehicleClass","",[""]]];

_vehicleClass

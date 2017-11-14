/**
 * Author: Dorbedo
 * returns if the object has an Inventory
 *
 * Arguments:
 * 0: <OBJECT> the object
 *
 * Return Value:
 * <BOOL> the object has an inventory
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params [["_object", objNull, [objNull]]];

if (isNull _object) exitWith {false};

([typeOf _object,"maximumLoad",0] call EFUNC(common,getCfgVehicles)) > 0

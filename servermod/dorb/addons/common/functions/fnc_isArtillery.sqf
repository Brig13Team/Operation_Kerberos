/**
 * Author: Dorbedo
 * checks if a class/object is an artillery
 *
 * Arguments:
 * 0: <STRING/OBJECT> the object/class
 *
 * Return Value:
 * <BOOL> is Artillery
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params [["_object", "", ["", objNull]]];

If (IS_OBJECT(_object)) then {
    _object = typeOf _object;
};

([_object, "artilleryScanner", 0] call FUNC(getCfgVehicles)) > 0

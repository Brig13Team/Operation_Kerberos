/**
 * Author: Dorbedo
 * returns if the unit has a NVG
 *
 * Arguments:
 * 0: <OBJECT> the unit
 *
 * Return Value:
 * <BOOL> the unit has a NVG
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params [["_unit", objNull, [objNull]]];

if (isNull _unit) exitWith {false};

(
    {
        If ([_x] call FUNC(isNVG)) exitWith {100};
        false
    } count ((assignedItems _unit)/* + (items _unit)*/)
)>0

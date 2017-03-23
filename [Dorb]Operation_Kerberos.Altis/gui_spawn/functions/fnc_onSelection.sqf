/*
 *  Author: Dorbedo
 *
 *  Description:
 *      [Description]
 *
 *  Parameter(s):
 *      0 : [TYPE] - [argument name]
 *
 *  Returns:
 *      [TYPE] - [return name]
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

disableSerialization;
_this params ["_vehicleList","_index"];

private _vehicleType = _vehicleList lnbData [_index, 0];
TRACEV_3(_vehicleList,_index,_vehicleType);

[_vehicleType] call FUNC(setObject);
[_vehicleType] call FUNC(showProperties);

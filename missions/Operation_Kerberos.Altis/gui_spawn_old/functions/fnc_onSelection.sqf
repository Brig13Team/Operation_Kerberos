/*
 *  Author: Dorbedo
 *
 *  Description:
 *      onSelection Event of the vehicleList
 *
 *  Parameter(s):
 *      0 : CONTROL - the vehiclelist
 *      1 : SCALAR - the index
 *
 *  Returns:
 *      none
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

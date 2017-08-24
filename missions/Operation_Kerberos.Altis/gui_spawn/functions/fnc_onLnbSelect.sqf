/**
 * Author: Dorbedo
 * display Event lnbSelect
 *
 * Arguments:
 * 0: <CONTROL> the List
 * 1: <SCALAR> the selected index
 *
 * Return Value:
 * Nothing
 *
 */

#include "script_component.hpp"

LOG_1("_this = %1",_this);

_this params ["_CtrlVehicleList","_index"];
GVAR(curVeh) = _CtrlVehicleList lnbData [_index,0];
GVAR(curModPic) = _CtrlVehicleList lnbData [_index,1];
[] call FUNC(displayProperties);

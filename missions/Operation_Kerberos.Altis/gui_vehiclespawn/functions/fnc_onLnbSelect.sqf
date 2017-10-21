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
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_CtrlVehicleList","_index"];
GVAR(curVeh) = _CtrlVehicleList lnbData [_index,0];
GVAR(curModPic) = _CtrlVehicleList lnbData [_index,1];
[] call FUNC(displayProperties);

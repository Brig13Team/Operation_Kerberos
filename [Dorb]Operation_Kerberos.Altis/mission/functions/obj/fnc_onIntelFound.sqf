/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Event when a Intel is found
 *
 *  Parameter(s):
 *      0 : OBJECT - the missiontarget
 *      1 : OBJECT - the caller
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"
TRACE("INTEL FOUND");
_this params ["_intel","_caller"];

If (isServer) then {
    GVAR(found_intel) = GVAR(found_intel) + 1;
    deleteVehicle _intel;
};
If (hasInterface) then {
    [LSTRING(INTEL_FOUND_MSG_TITLE),LSTRING(INTEL_FOUND_MSG)] call EFUNC(gui,globalMessage);
};

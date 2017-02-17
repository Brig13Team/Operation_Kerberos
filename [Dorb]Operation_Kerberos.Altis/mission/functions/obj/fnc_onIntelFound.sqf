/*
 *  Author: Dorbedo, iJesuz
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
_this params ["_intel","_caller"];

If (isServer) then {
    private _mission = _intel getVariable QGVAR(mission);
    HASH_SET(_mission, "obj_counter", HASH_GET(_mission, "obj_counter") + 1);

    deleteVehicle _intel;
};
If (hasInterface) then {
    [LSTRING(INTEL_FOUND_MSG_TITLE),LSTRING(INTEL_FOUND_MSG)] call EFUNC(gui,globalMessage);
};

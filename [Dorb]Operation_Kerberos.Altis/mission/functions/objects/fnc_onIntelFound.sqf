/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Event when a Intel is found
 *
 *  Parameter(s):
 *      0 : OBJECT - the missiontarget
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

If (isHeadless) exitWith {};
If (isServer) then {
    _this params ["_intel"];
    GVAR(found_intel) = GVAR(found_intel) + 1;
    deleteVehicle _intel;
}else{
    _this params ["_intel","_caller"];
    [
        localize LSTRING(NEW_INTEL_FOUND_MSG_TITLE),
        format [localize LSTRING(NEW_INTEL_FOUND_MSG),_caller],
    ] call EFUNC(interface,message);
};

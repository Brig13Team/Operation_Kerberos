/*
 *  Author: Dorbedo, iJesuz
 *
 *  Description:
 *      disable the device
 *
 *  Parameter(s):
 *      0 : OBJECT - interaction target
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_target",objNull,[objNull]]];
CHECK(isNull _target)

[
    5,
    [_target],
    LINKFUNC(obj_disableDevice),
    {},
    localize LSTRING(OBJ_DEVICE_DEACTIVATING)
] call ace_common_fnc_progressBar;

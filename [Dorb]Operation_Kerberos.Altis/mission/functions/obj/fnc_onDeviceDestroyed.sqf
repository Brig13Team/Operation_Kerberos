/*
 *  Author: iJesuz
 *
 *  Description:
 *      Destroyed Scarab event
 *
 *  Parameter(s):
 *      0 : OBJECT  - mission object
 *
 *  Returns:
 *      -
 */
#include "script_component.hpp"

if (isServer) then {
    _this params ["_device"];

    HASH_SET(_mission, "trigger_failed", true);
    _this call FUNC(obj_disableDevice);
}

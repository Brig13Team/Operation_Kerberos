/*
 *  Author: iJesuz
 *
 *  Description:
 *      Destroyed Scarab event
 *
 *  Parameter(s):
 *      0 : HASH    - mission
 *
 *  Returns:
 *      -
 */
#include "script_component.hpp"

if (isServer) then {
    _this params ["_device"];

    TRACEV_1(_device);

    private _mission = _device getVariable QGVAR(mission);
    HASH_SET(_mission, "trigger_failed", true);

    [getPos _device] call FUNC(obj_callEvent);
}

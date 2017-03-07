/*
 *  Author: Dorbedo, iJesuz
 *
 *  Description:
 *      Event when a hostage is rescued
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

If (isServer) then {
    _this params ["_commander"];

    private _mission = _commander getVariable QGVAR(mission);
    HASH_SET(_mission, "obj_counter_1", HASH_GET(_mission, "obj_counter_1") + 1);

    deleteVehicle _commander;
};

If (hasInterface) then {
    [
        QEGVAR(gui,message),
        [
            localize LSTRING(OBJ_COMMANDER_CAPTURED_MSG_TITLE),
            localize LSTRING(OBJ_COMMANDER_CAPTURED_MSG),
            "green"
        ]
    ] call CBA_fnc_localEvent;
};

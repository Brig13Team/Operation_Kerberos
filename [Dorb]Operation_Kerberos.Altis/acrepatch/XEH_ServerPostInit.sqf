/*
 *  Author: Dorbedo
 *
 *  Description:
 *      server postInit
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"
/*
If (isNil "ACRE_SERVER_GEAR_DESYNCED") then {
    ACRE_SERVER_GEAR_DESYNCED = false;
    ACRE_SERVER_DESYNCED_PLAYERS = [];
};

[
    {
        If (ACRE_SERVER_GEAR_DESYNCED) then {
            If (ACRE_SERVER_DESYNCED_PLAYERS isEqualTo []) then {
                ACRE_SERVER_GEAR_DESYNCED = false;
                publicVariable "ACRE_SERVER_GEAR_DESYNCED";
            }else{
                private _target = ACRE_SERVER_DESYNCED_PLAYERS deleteAt 0;
                If !(isNull _target) then {
                    [
                        QGVAR(syncGear),
                        [_target],
                        _target
                    ] call CBA_fnc_targetEvent;
                };
            };
        };
    },
    60
] call CBA_fnc_addPerFrameHandler;
*/

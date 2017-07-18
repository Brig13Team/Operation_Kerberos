/*
 *  Author: Dorbedo
 *
 *  Description:
 *      resets the jammer value after the talking has finished
 *
 *  Parameter(s):
 *      0 : STRING - the speaking id
 *      1 : STRING - the netID
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_speakingId","_netId"];
_speakingId = parseNumber _speakingId;
private _unit = objectFromNetId _netId;
if (!isNil "_unit") then {
    private _radioId = _unit getVariable ["acre_sys_core_currentSpeakingRadio", ""];
    if (_radioId != "") then {
        if (_unit in acre_sys_core_keyedMicRadios) then {
            missionNamespace setVariable [_radioId + "_jammer_signal", 0];
            missionNamespace setVariable [_radioId + "_jammer_px", 0];
        };
    };
};

/*
 *  Author: Dorbedo
 *
 *  Description:
 *      [Description]
 *
 *  Parameter(s):
 *      0 : [TYPE] - [argument name]
 *
 *  Returns:
 *      [TYPE] - [return name]
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params ["_id","_transmitterClass","_rxAntennas","_txAntennas","_f","_mw"];

private _lastCheck = HASH_GET_DEF(GVAR(jammer_lastCheck),_id,-999);
TRACEV_2(_id,_lastCheck);
If (_lastCheck + 2 < CBA_missiontime) then {
    HASH_SET(GVAR(jammer_lastCheck),_id,CBA_missiontime);

    missionNamespace setVariable [_transmitterClass + "_running_count_jammer", 0];


    missionNamespace setVariable [(_id + "_jammer"),(missionNamespace getVariable [(_id + "_jammer_next"),0])];
    missionNamespace setVariable [(_id + "_jammer_next"),0];
    _this spawn FUNC(setJammer);
};

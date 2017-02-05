/*
 *  Author: [Name of Author(s)]
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

params ["_args", "_result"];

if (count _result > 0) then {
    _result params ["_id", "_signal"];
    //missionNamespace setVariable [_id, -992 + (abs _signal)];
    private _jammerconst = missionNamespace getVariable ["JAMMERCONST",992];
    If ((missionNamespace getVariable ["JAMMERABS",-1])<0) then {
        missionNamespace setVariable [_id, abs(_jammerconst + _signal)];
    }else{
        missionNamespace setVariable [_id, JAMMERABS];
    };
};

private _count = missionNamespace getVariable [_transmitterClass + "_running_count_jammer", 0];
missionNamespace setVariable [_transmitterClass + "_running_count_jammer", _count - 1];

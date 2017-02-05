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
#define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_args", "_result"];
_args params ["_transmitterClass","_id"];
if (count _result > 0) then {
    _result params ["_jammerID", "_signal"];
    //missionNamespace setVariable [_id, -992 + (abs _signal)];
    private _value = 0;
    private _jammerconst = missionNamespace getVariable ["JAMMERCONST",992];
    If ((missionNamespace getVariable ["JAMMERABS",-1])<0) then {
        _value = abs(_jammerconst + _signal);
    }else{
        _value = JAMMERABS;
    };
    _value = _value max (missionNamespace getVariable [(_id + "_next"),0]);
    missionNamespace setVariable [(_id + "_next"), _value];
    TRACEV_5(_id,_signal,_value,JAMMERABS,_jammerconst);
};

private _count = missionNamespace getVariable [(_transmitterClass + "_running_count_jammer"), 0];
missionNamespace setVariable [(_transmitterClass + "_running_count_jammer"), _count - 1];

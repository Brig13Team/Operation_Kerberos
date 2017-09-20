/*
 *  Author: Dorbedo
 *
 *  Description:
 *      the countercheck
 *
 *  Parameter(s):
 *      0 : LOCATION - the missionhash
 *
 *  Returns:
 *      none
 *
 */
#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params ["_mission"];

private _objs = HASH_GET(_mission, "objects");

If (({(alive _x)&&{_x getVariable [QGVAR(isActive),true]}} count _objs) > 0) exitWith {
    /* the mission has not been finished */
};

// the mission has finished
private _amount = count _objs;
private _counter = HASH_GET(_mission, "obj_counter");

private _type = HASH_GET(_mission,"type");
TRACEV_5(_type,_amount,_counter,((_amount/3)*2),_objs);
If (_counter > ((_amount/3)*2)) exitWith {
    _mission setVariable ["progress","succeeded"];
};

If (_counter < 0) then {
    _mission setVariable ["progress","failed"];
}else{
    _mission setVariable ["progress","neutral"];
};

/*
 *  Author: iJesuz
 *
 *  Description:
 *      event called to increase mission's obj_counter
 *
 *  Parameter(s):
 *      0 : OBJECT / HASH  - mission target
 *
 *  Returns:
 *      -
 */
#define DEBUG_MODE_FULL
#include "script_component.hpp"

if !(isServer) exitWith {};

_this params ["_obj"];
private _mission = _obj;
TRACEV_1(_this);
if ((typeName _obj) isEqualTo "OBJECT") then {
    _mission = _obj getVariable QGVAR(mission);
    HASH_SET(_mission, "obj_counter", HASH_GET(_mission, "obj_counter") + 1);
    _obj setVariable [QGVAR(isActive), false, true];
}else{
    HASH_SET(_mission, "obj_counter", HASH_GET(_mission, "obj_counter") + 1);
};

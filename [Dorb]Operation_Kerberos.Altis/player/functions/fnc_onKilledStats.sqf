/*
 *  Author: Dorbedo
 *
 *  Description:
 *      registers player deaths and kills
 *
 *  Parameter(s):
 *      0 : OBEJCT - Unit who got killed
 *      1 : OBEJCT - Killer
 *      2 : OBEJCT - Unit who pulled the trigger
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params["_unit","_killer","_instigator"];

_killer = if ((_unit==_killer)||{isNull _killer}) then {
    _unit getVariable ["ace_medical_lastDamageSource", _killer];
} else { _killer };

If (isPlayer _unit) then {
    // player was killed
    private _id = getPlayerUID _unit;
    private _values = HASH_GET_DEF(GVAR(stats),_id,[ARR_3(0,0,0)]);
    _values set [1,(_values select 1)+1];
    HASH_SET(GVAR(stats),_id,_values);
    // was teamkilled
    If (isPlayer _killer) then {
        private _id = getPlayerUID _killer;
        private _values = HASH_GET_DEF(GVAR(stats),_id,[ARR_3(0,0,0)]);
        _values set [1,(_values select 2)+1];
        HASH_SET(GVAR(stats),_id,_values);
    };
}else{
    If (isPlayer _killer) then {
        private _id = getPlayerUID _killer;
        private _values = HASH_GET_DEF(GVAR(stats),_id,[ARR_3(0,0,0)]);
        _values set [1,(_values select 0)+1];
        HASH_SET(GVAR(stats),_id,_values);
    };
};

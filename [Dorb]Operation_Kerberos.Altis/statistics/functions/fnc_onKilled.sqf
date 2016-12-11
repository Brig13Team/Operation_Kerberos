/*
 *  Author: Dorbedo
 *
 *  Description:
 *      onKilled EH
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
#include "script_component.hpp"

_this spawn {
    SCRIPTIN(EH_killed,statistics);
    _this params["_unit","_killer","_instigator"];
    If (isPlayer _unit) exitWith {
        private _uid = getPlayerUID _unit;
        private _temp = HASH_GET_DEF(GVAR(players),_uid,[ARR_2(0,0)]);
        _temp set [1,(_temp select 1) + 1];
        HASH_SET(GVAR(player),_uid,_temp);
    };
    If ((isPlayer _instigator)&&(!isPlayer _unit)) exitWith {
        private _uid = getPlayerUID _instigator;
        private _temp = HASH_GET_DEF(GVAR(players),_uid,[ARR_2(0,0)]);
        _temp set [0,(_temp select 0) + 1];
        HASH_SET(GVAR(player),_uid,_temp);
    };

};

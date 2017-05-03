/**
 *  Author: Dorbedo
 *
 *  Description:
 *      registers a antiair-unit
 *
 *  Parameter(s):
 *      0 : OBJECT - The antiair to register
 *
 *  Returns:
 *      none
 *
 */
#include "script_component.hpp"

_this params [["_unit",objNull,[objNull]]];

CHECK(isNull _unit);

// check side - don't set playside units as radar
private _unitside = getNumber(configFile >> "CfgVehicles" >> (typeOf _unit) >> "side");
private _exit = switch _unitside do {
    case 0 : {GVARMAIN(playerside) == east};
    case 1 : {GVARMAIN(playerside) == west};
    default {false};
};
CHECK(_exit)

If (_unit isKindOf "StaticWeapon") then {
    HASH_GET(GVAR(antiair),"static") pushBack _unit;
}else{
    HASH_GET(GVAR(antiair),"mobile") pushBack _unit;
};

If (_unit isKindOf "rhs_zsutank_base") then {
    HASH_GET(GVAR(radars),"objects") pushBack _unit;
};

/*
    author: iJesuz, Dorbedo

    description:
        part of only pilots

    parameter:
        0: GROUP - group of player
        1: ARRAY - position of player
        2: UNIT - player
        3: ARRAY - turret
    returns:
        true
*/
#include "script_component.hpp"

params["_group","_position","_unit","_turret"];

CHECK(!isPlayer _unit)
CHECK((vehicle player) isKindOf "ParachuteBase")

if (!(((_turret isEqualTo [0]) || (_position == "driver")))) exitWith {};

#ifdef DORB_PILOT_WHITELIST_ENABLED
    private "_bool";
    _bool = true;

    if (!((typeOf _unit) in ["B_Pilot_F","B_Helipilot_F"])) then { _bool = false; };
    if ISCASVEHICLE_C(typeOf vehicle _unit) then {
        if ( !((getPlayerUID _unit in (["_SP_AI_","_SP_PLAYER_"])) || (!isNil QEGVAR(main,reserved_pilot_slot))) ) then { _bool = false; };
        if (!(_unit getVariable ["DORB_ISCASPILOT",false])) then { _bool = false };
    };

    if (!_bool) then {
        if ((_position == "driver") || {isNull driver (vehicle _unit)}) then { (vehicle _unit) engineOn false; };
        unassignVehicle (vehicle _unit);
        _unit action ["Eject", vehicle _unit];
        _unit action ["GetOut", vehicle _unit];
        if (isPlayer _unit) then { hint format[localize LSTRING(NURPILOTEN),name _unit]; };
    };
#else
    if (!((typeOf _unit) in ["B_Pilot_F","B_Helipilot_F"])) then {
        if ((_position == "driver") || {isNull driver (vehicle _unit)}) then { (vehicle _unit) engineOn false; };
        unassignVehicle (vehicle _unit);
        _unit action ["Eject", vehicle _unit];
        _unit action ["GetOut", vehicle _unit];
        if (isPlayer _unit) then { hint format[localize LSTRING(NURPILOTEN),name _unit]; };
    };
#endif
true

/*
 *  Author: Dorbedo
 *
 *  Description:
 *      ServerPostInit - used for the whitelist
 *
 */
#include "script_component.hpp"

EGVAR(player,whitelistenabled) = true;
EGVAR(player,reserved_pilot_slot) = true;

[QGVAR(pilot_whitelist), "onPlayerConnected", {
    If (([_uid, "HC"] call CBA_fnc_find)>-1) exitWith {}; /// Ignore Headless CLients
    ["insertOrUpdatePlayerInfo",_uid,_name] call DB_SEND;
    private _return = ["isPlayerWhitelisted",_uid] call DB_GETSINGLE;
    If (IS_ARRAY(_return) && {_return select 0}) then {
        _owner publicVariableClient QEGVAR(player,reserved_pilot_slot) ;
    };
}] call BIS_fnc_addStackedEventHandler;

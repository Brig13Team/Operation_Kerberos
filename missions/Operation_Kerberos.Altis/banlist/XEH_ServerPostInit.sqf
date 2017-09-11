/*
 *  Author: Dorbedo
 *
 *  Description:
 *      ServerPostInit - used for the whitelist
 *
 */
#include "script_component.hpp"

If (!((getMissionConfigValue ["isKerberos", 0]) > 0)) exitWith {};

If !(isServer) exitWith {};

GVAR(isBanned) = true;
GVAR(isAllowed) = true;

[QGVAR(banlist), "onPlayerConnected", {
    If (([_uid, "HC"] call CBA_fnc_find)>-1) exitWith {};

    private _return = ["isPlayerBanned",_uid] call DB_GETSINGLE;
    If (IS_ARRAY(_return)) then {
        If (_return select 0) then {
            _owner publicVariableClient QGVAR(isBanned);
        } else {
            _owner publicVariableClient QGVAR(isAllowed);
        };
    };
}] call BIS_fnc_addStackedEventHandler;

#include "script_component.hpp"

If !(hasInterface) exitWith {};

If (isNil "ace_common_fnc_errorMessage") then {
    // no ace, no playing on the server
    [{(alive player)},{findDisplay 46 closeDisplay 0}] call CBA_fnc_waitUntilAndExecute;
} else {
    [
        {
            (alive player)&&
            {
                (!isNil QGVAR(isBanned))||
                {!isNil QGVAR(isAllowed)}
            }
        },
        {
            If (!isNil QGVAR(isBanned)) then {
                [
                    "[Kerberos] Banned",
                    "You are not allowed on this sever. Please contact the Serveradministrator for further informations",
                    {findDisplay 46 closeDisplay 0}
                ] call ace_common_fnc_errorMessage;
            } else {
                // nothing
            };
        }
    ] call CBA_fnc_waitUntilAndExecute;
};

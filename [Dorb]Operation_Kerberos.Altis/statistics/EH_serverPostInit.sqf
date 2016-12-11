/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Server Post-Init
 *
 */
#include "script_component.hpp"

GVAR(currentPlayers) = HASH_CREATE;


[QGVAR(players), "onPlayerConnected", {
    If (([_uid, "HC"] call CBA_fnc_find)>-1) exitWith {}; /// Ignore Headless CLients
    If (_uid == "__SERVER__") exitWIth {};
    If !(HASH_HASKEY(GVAR(currentPlayers),_uid)) then {
        HASH_SET(GVAR(currentPlayers),_uid,[0,0]);
    };
}] call BIS_fnc_addStackedEventHandler;



[
    {
        {
            _this params ["_key"];
            private _temp = HASH_GET(GVAR(players),_key);
            HASH_SET(GVAR(players),_key,[ARR_2(0,0)]);
            private _curStats = ["getStatistics",_temp] call DB_GET;
            _temp = [
                (_temp select 0) + (_curStats select 0),
                (_temp select 1) + (_curStats select 1)
            ];
            ["setStatistics",_temp] call DB_SET;
        } forEach (HASH_KEYS(GVAR(players)));
    },
    900
] call CBA_fnc_addPerFrameHandler

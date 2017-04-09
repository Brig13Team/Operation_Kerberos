/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Event when a emp strike happens
 *
 *  Parameter(s):
 *      0 : ARRAY - the centerposition
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"
_this params ["_position"];
private _allVehicles = _position nearEntities [["LandVehicle","Air","Ship_F"],2000];
{
    private _curVehicle = _x;
    switch (true) do {
        case (_curVehicle isKindOf 'Air') : {
            private _damagecount = (floor(random 6)) max 1;
            private _hitpoints = ["HitEngine","HitEngine2","HitEngine3","HitBatteries","HitLight","HitHydraulics","HitHStabilizerL1",
                "HitHStabilizerR1","HitVStabilizer1","HitPitotTube","HitStaticPort","HitStarter1","HitStarter2","HitStarter3",
                "HitAvionics","HitMissiles"] call BIS_fnc_arrayShuffle;
            {
                If (_damagecount < 0) exitWith {};
                private _engine = (vehicle _curVehicle) getHitPointDamage _x;
                If !(isNil "_engine") then {
                    (vehicle _curVehicle) setHitPointDamage [_engine,1];
                    _damagecount = _damagecount - 1;
                };
            } forEach _hitpoints;
            If (_damagecount > 0) then {
                (vehicle _curVehicle) setFuel 0;
            };
        };
        default {
            private _engine = (vehicle _curVehicle) getHitPointDamage "HitEngine";
            If (isNil "_engine") then {
                (vehicle _curVehicle) setFuel 0;
            }else{
                (vehicle _curVehicle) setHitPointDamage ["HitEngine",1];
            };
        };
    };
} forEach _allVehicles;

[QEGVAR(mod_tfar,disableArea),[_position]] call CBA_fnc_globalEvent;
[QEGVAR(mod_acre,disableArea),[_position]] call CBA_fnc_globalEvent;

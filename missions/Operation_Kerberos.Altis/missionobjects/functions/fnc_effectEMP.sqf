#include "script_component.hpp"
/**
 * Author: Dorbedo
 * Dorbedo
 *
 * Arguments:
 * 0: the vehicle <OBJECT>
 *
 * Return Value:
 * Nothing
 *
 */

params [["_curVehicle",objNull,[objNull]]];

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
                (vehicle _curVehicle) setHitPointDamage [_x,1];
                _damagecount = _damagecount - 1;
            };
        } forEach _hitpoints;
        If (_damagecount > 0) then {
            (vehicle _curVehicle) setFuel 0;
        };
    };
    case (_curVehicle isKindOf 'Tank');
    case (_curVehicle isKindOf 'Ship_F');
    case (_curVehicle isKindOf 'Car') : {
        private _engine = (vehicle _curVehicle) getHitPointDamage "HitEngine";
        If (isNil "_engine") then {
            (vehicle _curVehicle) setFuel 0;
        }else{
            (vehicle _curVehicle) setHitPointDamage ["HitEngine",1];
        };
    };
    default {
        /* Autonoumius static weapons*/
    };
};

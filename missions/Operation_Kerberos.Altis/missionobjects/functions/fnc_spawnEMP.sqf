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
#define DEBUG_MODE_FULL
#include "script_component.hpp"
_this params [["_position",[],[[]],[2,3]]];
If (_position isEqualTo []) then {
    _position = HASH_GET_DEF(EGVAR(headquarter,dangerzones),"centerpos",[ARR_3(0,0,0)]);
};

TRACEV_2(_this,_position);
private _allVehicles = _position nearEntities [["LandVehicle","Air","Ship_F"],3000];
{
    private _curVehicle = _x;
    if !(local _curVehicle) then {
        [QGVAR(effectEMPLocal),[_curVehicle],_curVehicle] call CBA_fnc_localEvent;
    } else {
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
    };
} forEach _allVehicles;

[QEGVAR(mod_acre,disableArea),[_position]] call CBA_fnc_globalEvent;

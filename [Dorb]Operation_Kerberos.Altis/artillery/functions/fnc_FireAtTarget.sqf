/*
 *  Author: Dorbedo
 *
 *  Description:
 *      [Description]
 *
 *  Parameter(s):
 *      0 : [TYPE] - [argument name]
 *
 *  Returns:
 *      [TYPE] - [return name]
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [
    "_artillery",
    "_target",
    ["_shelltype","",[""]],
    ["_amount",1,[0]],
    ["_OnFinish",{true},[{}]]
];
TRACEV_2((typeOf _artillery),_this);
switch (typeOf _artillery) do {
    case "RHS_BM21_MSV_01" : {
        private _distance = _artillery distance _target;
        private _mode = switch (true) do {
            case (_distance < 1000) : {""}; // 1000-1400
            case (_distance < 1400) : {"Close"}; // 1000-1400
            case (_distance < 1800) : {"M1"}; // 1400-1800
            case (_distance < 2300) : {"M1a"}; // 1800-2300
            case (_distance < 3000) : {"M2"}; // 2300-3000
            case (_distance < 3800) : {"M3"}; // 2900-3800
            case (_distance < 4900) : {"M4"}; // 3800-4900
            case (_distance < 6200) : {"M5"}; // 4900-6200
            case (_distance < 7700) : {"M6"}; // 6000-7700
            case (_distance < 9200) : {"M7"}; // 7200-9300
            case (_distance < 11000) : {"M8"}; // 8900-11600
            case (_distance < 13000) : {"M9"}; // 10400-13600
            case (_distance < 16000) : {"M10"}; // 12900-16800
            case (_distance < 20500) : {"M11"}; // 15700-20500
            default {""}
        };
        TRACEV_2(_distance,_mode);
        CHECK(_mode isEqualTo "")
        private _initSpeed = getNumber (configFile >> "CfgMagazines" >> _shelltype >> "initspeed");
        private _weapon = _artillery currentWeaponTurret [0];
        private _charge = getNumber (configFile >> "CfgWeapons" >> _weapon >> _mode >> "artillerycharge");
        [gunner _artillery,_weapon,_mode] call CBA_fnc_selectWeapon;
        private _muzzlespeed = _initSpeed * _charge;
        private _shotVector = [_artillery,_target,_muzzlespeed,true] call FUNC(getShotVector);
        private _reloadSpeed = getNumber(configfile >> "CfgWeapons" >> _weapon >> _mode >> "reloadtime");
        TRACEV_6(_artillery,_shotVector,_amount,_weapon,_mode,_reloadSpeed);
        [_artillery,_shotVector,_amount,_weapon,_mode,_reloadSpeed,_OnFinish] call FUNC(AIFire);
    };
    default {
        _artillery commandArtilleryFire [_position,_shelltype,_amount];
    };
};
//[_artillery] call FUNC(_OnFinish);


//

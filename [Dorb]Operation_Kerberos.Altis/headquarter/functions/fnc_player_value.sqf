/*
    Author: Dorbedo
    
    Description:
        gets the value of a player
    
    Parameter(s):
        0: OBJECT - player

    Returns:
        SCALAR
*/
#include "script_component.hpp"

_this params ["_player"];

If (vehicle _player == _player) then {
    _value = switch (true) do {
        case ((vehicle _player)isKindOf "Armored") : {30};
        case ((vehicle _player)isKindOf "Car") : {20};
        case ((vehicle _player)isKindOf "Ship_F") : {20};
        case ((vehicle _player)isKindOf "Air") : {35};
        case ((vehicle _player)isKindOf "Support") : {15};
        default {10};
    };
}else{
    private _weapon = currentWeapon (vehicle _player);
    ([_weapon] call BIS_fnc_itemType) params ["_weaponcategory","_weapontype"];
    switch (true) do {
        case (_weapontype in ["SniperRifle","Rifle"]) : {25};
        case (_weapontype in ["BombLauncher","Cannon","Mortar"]) : {30};
        case (_weapontype in ["AssaultRifle","GrenadeLauncher","Handgun","SubmachineGun"]) : {10};
        case (_weapontype in ["MachineGun"]) : {20};
        case (_weapontype in ["Launcher","MissileLauncher","RocketLauncher"]) : {20};
        default {10};
    };
};
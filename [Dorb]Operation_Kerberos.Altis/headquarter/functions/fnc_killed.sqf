/*
    Author: Dorbedo
    
    Description:
        ads a vakue to the Dangeraray when a unit git killed
    
    Parameter(s):
        none

    Returns:
        none
*/
#include "script_component.hpp"
private ["_killerpos","_x_pos","_y_pos","_value"];

_this params ["_killer","_caller"];
TRACEV_2(_killer,_caller);

_killerpos = _caller gethidefrom _killer;

CHECK((_killerpos distance [0,0,0])<10);

([_killerpos] call FUNC(dangerzone_convert)) params ["_x_coordinate","_y_coordinate"];

CHECK(_x<0)

private _weapon = currentWeapon (vehicle _killer);
([_weapon] call BIS_fnc_itemType) params ["_weaponcategory","_weapontype"];

_value = switch (true) do {
    case (_weapontype in ["SniperRifle","Rifle"]) : {25};
    case (_weapontype in ["BombLauncher","Cannon","Mortar"]) : {30};
    case (_weapontype in ["AssaultRifle","GrenadeLauncher","Handgun","SubmachineGun"]) : {10};
    case (_weapontype in ["MachineGun"]) : {20};
    case (_weapontype in ["Launcher","MissileLauncher","RocketLauncher"]) : {20};
    case ((vehicle _killer)isKindOf "Armored") : {30};
    case ((vehicle _killer)isKindOf "Car") : {20};
    case ((vehicle _killer)isKindOf "Ship_F") : {20};
    case ((vehicle _killer)isKindOf "Air") : {35};
    default {10};
};

GVAR(buffer) pushBack [_x_coordinate,_y_coordinate,_value];

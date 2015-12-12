/*
    Author: iJesuz
    
    Description:
        backpack detonates if a unit carrying explosives gets shoot in the back
    
    Parameter(s):
    
*/
#include "script_component.hpp"
SCRIPT(XEH_hitPart);

if (difficulty < 3) exitWith {};

private ["_target","_hit_parts"];

_target = _this select 0 select 0;
_hit_parts = _this select 0 select 5;

{
    (_x) call BIS_fnc_log;
} forEach _hit_parts;

if ((("spine1" in _hit_parts) || ("spine3" in _hit_parts)) && {backpack _target != ""}) then {
    private ["_mags","_ammo","_exp"];
    _mags = backpackItems _target;
    {
        _ammo = getText (configFile >> "CfgMagazines" >> _x >> "ammo");
        if (_ammo != "") then {
            _exp = getText (configFile >> "CfgAmmo" >> _ammo >> "ACE_Explosive");
            if (_exp == "") then {
                _exp = createVehicle[_ammo,[0,0,0],[],0,"NONE"];
            } else {
                _exp = createVehicle[_exp,[0,0,0],[],0,"NONE"];
            };
            _exp setPos (getPos _target);
            _exp setDir (getDir _target);
            _exp setDammage 1;
            _target removeItemFromBackpack _x;
        };
    } forEach _mags;
};

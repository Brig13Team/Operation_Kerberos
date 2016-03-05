/*
    Author: Dorbedo
    
    Description:
        updates_strength
        do not call directly
    
    Parameter(s):
        none

    Returns:
        none
*/
#include "script_component.hpp"
_this params[["_group",grpNull,[grpNull]]];
if (isNull _group) exitWith {["",0]};

private _value = 0;
private _all_Vehicles = [];
{
    _all_Vehicles pushBackUnique _x;
    _all_Vehicles pushBackUnique (vehicle _x);
}forEach (units _group);
private _type = "Infanterie";
{
    _value = _value + (switch (true) do {
        case (_x isKindOf "Air") : {
            If ((toLower(getText(configFile >> "CfgVehicles" >> (typeOf _x) >> "simulation")))in ["helicopterrtd","helicopterx"]) then {
                _type = "Helicopter";20
            }else{
                _type = "Plane";30
            };
        };
        case (_x isKindOf "Armored") : {_type = "Armored";15};
        case (_x isKindOf "Autonomous") : {_type = "Autonomous";9};
        case (_x isKindOf "Car") : {_type = "Car";5};
        case (_x isKindOf "Ship") : {_type = "Ship";8};
        default {1};
    });
} forEach _all_Vehicles;

[_type,_value]
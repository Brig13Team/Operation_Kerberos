/*
    Author: Dorbedo

    Description:
        adds Medical Supplys to a unit
*/
#include "script_component.hpp"
params[["_vehicle", objNull, [objNull]]];

If (isNull _vehicle) exitWith {};

If ((missionNamespace getVariable ["ace_medical_level", 0])<2) then {
    [_vehicle,"Medikit",9999,false] call CBA_fnc_removeItemCargo;
    [_vehicle,"FirstAidKit",9999,false] call CBA_fnc_removeItemCargo;
    {
        _x params ["_classname","_count"];
        [_vehicle,_classname,9999,false] call CBA_fnc_removeItemCargo;
        [_vehicle,_classname,_count,false] call CBA_fnc_addItemCargo;
        nil
    } count [
        ["ACE_fieldDressing", 150],
        ["ACE_bloodIV", 30],
        ["ACE_epinephrine", 80],
        ["ACE_morphine", 100]
    ];
} else {
    [_vehicle,"Medikit",9999,false] call CBA_fnc_removeItemCargo;
    [_vehicle,"FirstAidKit",9999,false] call CBA_fnc_removeItemCargo;
    {
        _x params ["_classname","_count"];
        [_vehicle,_classname,9999,false] call CBA_fnc_removeItemCargo;
        [_vehicle,_classname,_count,false] call CBA_fnc_addItemCargo;
        nil
    } count [
        ["ACE_atropine", 40],
        ["ACE_fieldDressing", 120],
        ["ACE_elasticBandage", 120],
        ["ACE_quikclot", 150],
        ["ACE_bloodIV", 20],
        ["ACE_bloodIV_500", 30],
        ["ACE_bloodIV_250", 30],
        ["ACE_bodyBag", 15],
        ["ACE_epinephrine", 40],
        ["ACE_morphine", 40],
        ["ACE_packingBandage", 60],
        ["ACE_personalAidKit", 30],
        ["ACE_plasmaIV", 20],
        ["ACE_plasmaIV_500", 30],
        ["ACE_plasmaIV_250", 30],
        ["ACE_salineIV", 40],
        ["ACE_salineIV_500", 50],
        ["ACE_salineIV_250", 50],
        ["ACE_surgicalKit", 30],
        ["ACE_tourniquet", 40]
    ];
};

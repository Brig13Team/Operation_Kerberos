/*
    Author: Dorbedo
    
    Description:
        returns strenght
    
    Parameter(s):
        none

    Returns:
        none
*/
#include "script_component.hpp"
_this params[["_group",grpNull,[grpNull,[],objNull]]];
if (isNull _group) exitWith {[0,0,[0,0,0]]};
private _soldiers = [];
If (IS_GROUP(_group)) then {
    _soldiers = (units _group) select {alive _x};
}else{
    If (IS_OBJECT(_group)) then {
        _soldiers = [_group];
    }else{
        _soldiers = _group;
    };
};

private _vehicles = [];

private _thread = [0,0,0];
private _value = 0;
private _type = 0;
{
    If ((vehicle _x != _x)&&{(toLower(_x call CBA_fnc_vehicleRole)) in ["driver","gunner","commander","Turret"]}) then {
        _vehicles pushBackUnique (vehicle _x);
    };
    private _primaryweapon = (primaryWeapon _x) call BIS_fnc_itemType;
    private _secondaryWeapon = (secondaryWeapon _x) call BIS_fnc_itemType;
    private _special = "";
    private _similiSoldier = "";
    switch (true) do {
        case (leader _x == _x) : {_similiSoldier = "B_Soldier_TL_F";}; // 450000 
        case (_primaryweapon = "SniperRifle") : {_similiSoldier = "B_sniper_F";}; //350000 
        case ((_x getVariable ["ace_medical_medicClass",0])>0) : {_similiSoldier = "B_Medic_F";}; //300000 
        case (_secondaryWeapon = "Launcher") : {
                private _mag = (getArray(configFile >> "CfgVehicles" >> (secondaryWeapon _x))select 0);
                private _ammo = getText(configFile >> "CfgVehicles" >> _mag >> "ammo");
                If (getNumber(configFile >> "CfgVehicles" >> _ammo >> "airlock")>1) then {
                    _similiSoldier = "B_soldier_AA_F"; //200000
                }else{
                    _similiSoldier = "B_soldier_AT_F"; //190000
                };
            };
        default {_similiSoldier = (typeOf _x);}; // rifleman : 100000
    };
    
    private _temp = getArray(configFile >> "CfgVehicles" >> _similiSoldier >> "thread");
    If !(_temp isEqualTo []) then {
        _thread = [
            (_thread select 0) max (_temp select 0),
            (_thread select 1) max (_temp select 1),
            (_thread select 2) max (_temp select 2),
        ];
    };
    private _coef = (getNumber(configFile >> "CfgVehicles" >> _similiSoldier >> "costTurnCoef"))max 0.025;
    _value = _value + (getNumber(configFile >> "CfgVehicles" >> _similiSoldier >> "cost") * _coef);
}forEach _soldiers;


{
    _type = _type max (getNumber(configFile >> "CfgVehicles" >> (typeOf _x) >> "type"));
    private _temp = getArray(configFile >> "CfgVehicles" >> (typeOf _x) >> "thread")
    If !(_temp isEqualTo []) then {
        _thread = [
            (_thread select 0) max (_temp select 0),
            (_thread select 1) max (_temp select 1),
            (_thread select 2) max (_temp select 2),
        ];
    };
    _value = _value + getNumber(configFile >> "CfgVehicles" >> (typeOf _x) >> "cost");
} forEach _vehicles

[_type,_value,_thread];
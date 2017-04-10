/*
 *  Author: Dorbedo
 *
 *  Description:
 *      gets the cost of a unit
 *
 *  Parameter(s):
 *      0 : STRING/OBJECT - Unitclass
 *
 *  Returns:
 *      SCLALAR - costa of a Unit
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"
_this params [["_type","",["",objNull]]];
If (_type isEqualTo "") exitWith {0};
private "_object";
If (IS_OBJECT(_type)) then {
    _object = _Type;
    _type = typeOf _type;
}else{
    _object = objNull;
};


#define SOLDIER 100

#define V_NO_ARMOR
#define V_LIGHT_ARMOR
#define V_HEAVY_ARMOR

#define A_HELICOPTER
#define A_HELICOPTER_CAS
#define A_PLANE
#define A_PLANE_CAS

#define D_PLANE
#define D_HELICOPTER
#define D_GROUND

#define S_SHIP

private _value = HASH_GET_DEF(GVAR(Cost),_type,-1);
If (_value > 0) exitWith {_value};


If (_type isKindOf "Autonomous") exitWith {
    If !(_type isKindOf "Air") exitWith {
        HASH_SET(GVAR(Cost),_type,D_GROUND);
        D_GROUND
    };
    If (_type isKindOf "Plane") then {
        HASH_SET(GVAR(Cost),_type,D_PLANE);
        D_PLANE
    }else{
        HASH_SET(GVAR(Cost),_type,D_HELICOPTER);
        D_HELICOPTER
    };
};

If (_type isKindOf "Man") exitWith {
    If (getNumber (configFile >> "CfgVehicles" >> typeOf _vehicle >> "attendant") > 0) then {
            _value = _value + M_MEDIC;
        };
};

If (_type isKindOf "Ship") exitWIth {
    HASH_SET(GVAR(Cost),_type,S_SHIP);
    S_SHIP
};

If (_type isKindOf "Car_F") exitWith {
    private _value = 150;
    // Cargo > 6
    If () then {_value = _value + V_U_TRANSPORT;};
    // Weapon
    If () then {
        If () then {_value = _value + V_U_HMG;};
        If () then {_value = _value + V_U_GMG;};
    };
    // Armor
    If () then {_value = _value + V_U_ARMOR;};
    // Special
    If () then {_value = _value + V_U_SPECIAL;};
    HASH_SET(GVAR(Cost),_type,_value);
    _value;
};

private _value = 0;

// Armor
If () then {_value = _value + V_A_ARMOR;};

// Tracks
If (isClass(configFile >> "CfgVehicles" >> _type >> "HitPoints" >> "HitTrack")) then {_value = _value + V_A_TRACKS;};

// Weapons
If () then {
    // ARtillery
    If () then {_value = _value + V_A_ARTILLERY;};

};
// SPecial
If (((!isNull _object)&&{[_object] call ace_medical_fnc_isMedic})||
    ((isNull _object)&&{getNumber (configFile >> "CfgVehicles" >> _type >> "attendant") > 0})) then {
        _value = _value + V_SPECIAL;
    };
If (getNumber (configFile >> "CfgVehicles" >> _type >> "ace_refuel_fuelCargo")) > 0) then {
        _value = _value + V_SPECIAL;
    };
If (
    (isClass(configFile >> "CfgVehicles" >> _type >> "ACE_Actions" >> "ACE_MainActions" >> "ACE_Rearm_TakeAmmo"))||
    {[_object] call ACE_rearm_fnc_canTakeAmmo}
    ) then {
        _value = _value + V_SPECIAL;
    };


HASH_SET(GVAR(Cost),_type,_value);
_value;

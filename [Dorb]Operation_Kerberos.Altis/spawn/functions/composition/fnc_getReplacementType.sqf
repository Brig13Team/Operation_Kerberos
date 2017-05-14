/*
 *  Author: Dorbedo
 *
 *  Description:
 *      returns the replacementgroup of a vehicle
 *
 *  Parameter(s):
 *      0 : STRING - the vehicleclass
 *
 *  Returns:
 *      STRING - the replacementgroup
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_unittype","",[""]]];
private _return = "";

If (_unittype isEqualTo "") exitWith {_return};

private _fnc_getWeapons = {
    _this params ["_unittype"];
    private _turrets = "true" configClasses (configfile >> "CfgVehicles" >> _unittype >> "turrets");
    private _weapons = [];
    {
        _weapons append getArray(_x>>"weapons");
        nil;
    } count _turrets;
    _weapons;
};

If ((_unittype isKindOf "Autonomous")||(_unittype in ["B_SAM_System_01_F","B_SAM_System_02_F","B_AAA_System_01_F"])) exitWith {
    // Autonomous units can switch sides easyly
    ""
};

If (_unittype isKindOf "Air") exitWith {
    private _weapons = [_unittype] call _fnc_getWeapons;
    _weapons = _weapons select {!((toUpper _x) in ["CMFLARELAUNCHER","ACE_AIR_SAFETY","RHS_WEAP_MASTERSAFE","RHS_LWIRCM_MELB"])};
    If (_unittype isKindOf "Plane") then {
        private _isCAS = ["cas_bombing"] in ((getArray(configfile >> "CfgVehicles" >> _unittype >> "availableForSupportTypes")) apply {tolower _x});
        If (((count _weapons) >0)||_isCAS) then {
            private _isAI = 0;
            {
                private _curWeapon = _x;
                private _mag = ((getArray(configFile >> "CfgWeapons" >> _curWeapon >> "magazines")) select 0);
                If !(isNil "_mag") then {
                    _isAI = _isAI max (getNumber(configFile >> "CfgAmmo" >> getText(configFile >> "CfgMagazines" >> _mag >> "ammo") >> "airLock"));
                };
            } forEach _weapons;
            If (_isAI > 0) then {
                _return = "plane_ai";
            } else {
                _return = "plane_cas";
            };
        } else {
            _return = "plane_transport";
        };
    }else{
        private _isCAS = ["cas_heli"] in ((getArray(configfile >> "CfgVehicles" >> _unittype >> "availableForSupportTypes")) apply {tolower _x});
        If (((count _weapons) >0)||_isCAS) then {
            _return = "helicopter_cas";
        } else {
            _return = "helicopter";
        };
    };
    _return
};

If (_unittype isKindOf "CAManBase") exitWith {
    _return = "soldier";
    switch (true) do {
        case ((getNumber (configFile >> "CfgVehicles" >> _unittype >> "attendant")>0)) : {
            _return = "soldier_medic";
        };
        case (getNumber (configFile >> "CfgVehicles" >> _unittype >> "engineer") == 1) : {
            _return = "soldier_engineer";
        };
        default {
            private _weapons = getArray(configfile >> "CfgVehicles" >> _unittype >> "weapons");
            {
                private _curWeapon = _x;
                ([_curWeapon] call BIS_fnc_itemType)params ["_itemclass","_itemtype"];
                If (_itemtype in ["Launcher","RocketLauncher","MissileLauncher"]) then {
                    private _mag = ((getArray(configFile >> "CfgWeapons" >> _curWeapon >> "magazines")) select 0);
                    If ((isNil "_mag")||{(getNumber(configFile >> "CfgAmmo" >> getText(configFile >> "CfgMagazines" >> _mag >> "ammo") >> "airLock")) > 0}) then {
                        _return = "soldier_aa";
                    } else {
                        _return = "soldier_at";
                    };
                };
                If (_itemtype in ["MachineGun"]) then {
                    _return = "soldier_mg";
                };
                If ((_itemtype in ["SniperRifle"])||(isClass(configFile >> "CfgWeapons" >> _curWeapon >> "far_optic1"))) then {
                    _return = "soldier_sniper";
                };
            } forEach _weapons;
        };
    };
    _return
};

If (_unittype isKindOf "Ship_F") exitWith {
    _return = "ship";
    _return
};

If (_unittype isKindOf "StaticWeapon") exitWith {
    _return = "staticweapon";
    _return
};



If (_unittype isKindOf "LandVehicle") exitWith {
    _return = "car";

    If (getNumber (configFile >> "CfgVehicles" >> _unittype >> "attendant") > 0) exitWith {
        _return = "truck_medic";
        _return
    };
    If (getNumber (configFile >> "CfgVehicles" >> _unittype >> "ace_refuel_fuelCargo") > 0) exitWith {
        _return = "truck_fuel";
        _return
    };
    If (isClass(configFile >> "CfgVehicles" >> _unittype >> "ACE_Actions" >> "ACE_MainActions" >> "ACE_Rearm_TakeAmmo")) exitWith {
        _return = "truck_ammo";
        _return
    };


    // Armor
    private _armor = getNumber(configfile >> "CfgVehicles" >> _unittype >> "armor");
    If (_armor > 500) then {
        _return = "tank";
    };
    If ((_armor <= 500)&&(_armor > 200)) then {
        _return = "ifv";
    };
    If ((_armor <= 200)&&(_armor > 50)) then {
        _return = "truck_ammo";
    };
    If (isClass(configfile >> "CfgVehicles" >> _unittype >> "HitPoints" >> "HitRTrack")) then {
        _return = "ifv";
    };


    // weapons
    private _weapons = [_unittype] call _fnc_getWeapons;
    {
        private _curWeapon = _x;
        ([_curWeapon] call BIS_fnc_itemType)params ["_itemclass","_itemtype"];
        If (_itemtype in ["Launcher","MissileLauncher","RocketLauncher"]) then {
            private _mag = ((getArray(configFile >> "CfgWeapons" >> _curWeapon >> "magazines")) select 0);
            If ((isNil "_mag")||{(getNumber(configFile >> "CfgAmmo" >> getText(configFile >> "CfgMagazines" >> _mag >> "ammo") >> "airLock")) > 0}) then {
                /*nothing*/
            } else {
                _return = "antiair";
            };
        };
        If (_itemtype in ["Mortar"]) then {
            _return = "artillery";
        };
        If (_itemtype in ["RocketLauncher"]) then {
            _return = "artillery_rocket";
        };
    } forEach _weapons;
    _return;
};

_return

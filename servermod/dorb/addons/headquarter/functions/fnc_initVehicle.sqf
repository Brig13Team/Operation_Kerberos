/**
 *  Author: Dorbedo
 *
 *  Description:
 *      initializes the vehicleValues
 *
 *  Parameter(s):
 *      0 : STRING/OBJECT - Unitclass
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"
_this params [["_unittype","",[""]],["_object",objNull,[objNull]]];
CHECK(_unittype isEqualTo "")
If (isCLass(ConfigFile >> "CfgKerberos" >> "headquarter">>"costs">>_unittype)) exitWith {
    HASH_SET(GVAR(costs),_unittype,getNumber(ConfigFile >> "CfgKerberos" >> "headquarter">>"costs">>_unittype>>"value"));
    HASH_SET(GVAR(strength),_unittype,getNumber(ConfigFile >> "CfgKerberos" >> "headquarter">>"costs">>_unittype>>"strength"));
    HASH_SET(GVAR(defence),_unittype,getNumber(ConfigFile >> "CfgKerberos" >> "headquarter">>"costs">>_unittype>>"defence"));
};

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

private "_value";
If (getText(configFile >> "CfgVehicles" >> _unittype >> "vehicleClass") == "Autonomous") exitWith {
    If !(_unittype isKindOf "Air") exitWith {
        _value = getArray(ConfigFile >> "CfgKerberos" >> "headquarter">>"costs">>"drone_ground");
        HASH_SET(GVAR(costs),_unittype,_value select 0);
        HASH_SET(GVAR(strength),_unittype,_value select 1);
        HASH_SET(GVAR(defence),_unittype,_value select 2);
    };
    If (_unittype isKindOf "Plane") then {
        _value = getArray(ConfigFile >> "CfgKerberos" >> "headquarter">>"costs">>"drone_plane");
        HASH_SET(GVAR(costs),_unittype,_value select 0);
        HASH_SET(GVAR(strength),_unittype,_value select 1);
        HASH_SET(GVAR(defence),_unittype,_value select 2);
    }else{
        _value = getArray(ConfigFile >> "CfgKerberos" >> "headquarter">>"costs">>"drone_helicopter");
        HASH_SET(GVAR(costs),_unittype,_value select 0);
        HASH_SET(GVAR(strength),_unittype,_value select 1);
        HASH_SET(GVAR(defence),_unittype,_value select 2);
    };
};

If (_unittype isKindOf "Air") exitWith {
    private _weapons = If !(isNull _object) then {
        weapons _object
    } else {
        [_unittype] call _fnc_getWeapons;
    };
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
                _value = getArray(ConfigFile >> "CfgKerberos" >> "headquarter">>"costs">>"plane_ai");
            } else {
                _value = getArray(ConfigFile >> "CfgKerberos" >> "headquarter">>"costs">>"plane_cas");
            };
            HASH_SET(GVAR(costs),_unittype,_value select 0);
            HASH_SET(GVAR(strength),_unittype,_value select 1);
            HASH_SET(GVAR(defence),_unittype,_value select 2);
        } else {
            _value = getArray(ConfigFile >> "CfgKerberos" >> "headquarter">>"costs">>"plane");
            HASH_SET(GVAR(costs),_unittype,_value select 0);
            HASH_SET(GVAR(strength),_unittype,_value select 1);
            HASH_SET(GVAR(defence),_unittype,_value select 2);
        };
    }else{
        private _isCAS = ["cas_heli"] in ((getArray(configfile >> "CfgVehicles" >> _unittype >> "availableForSupportTypes")) apply {tolower _x});
        If (((count _weapons) >0)||_isCAS) then {
            _value = getArray(ConfigFile >> "CfgKerberos" >> "headquarter">>"costs">>"helicopter_cas");
            HASH_SET(GVAR(costs),_unittype,_value select 0);
            HASH_SET(GVAR(strength),_unittype,_value select 1);
            HASH_SET(GVAR(defence),_unittype,_value select 2);
        } else {
            _value = getArray(ConfigFile >> "CfgKerberos" >> "headquarter">>"costs">>"helicopter");
            HASH_SET(GVAR(costs),_unittype,_value select 0);
            HASH_SET(GVAR(strength),_unittype,_value select 1);
            HASH_SET(GVAR(defence),_unittype,_value select 2);
        };
    };
};


private _fnc_valueAdd = {
    _this params ["_cost","_strength","_defence"];
    _value set[0,(_value select 0)+_cost];
    (_value select 1) set[0,((_value select 1) select 0)max(_strength select 0)];
    (_value select 1) set[1,((_value select 1) select 1)max(_strength select 1)];
    (_value select 1) set[2,((_value select 1) select 2)max(_strength select 2)];

    (_value select 2) set[0,((_value select 2) select 0)max(_defence select 0)];
    (_value select 2) set[1,((_value select 2) select 1)max(_defence select 1)];
    (_value select 2) set[2,((_value select 2) select 2)max(_defence select 2)];
};

If (_unittype isKindOf "CAManBase") exitWith {
    _value = getArray(ConfigFile >> "CfgKerberos" >> "headquarter">>"costs">>"soldier");
    If (
            ((getNumber (configFile >> "CfgVehicles" >> _unittype >> "attendant")>0)||
            {(_object getVariable ["ace_medical_medicClass",0]) > 1})||
            {_object getVariable ["ACE_isEOD", getNumber (configFile >> "CfgVehicles" >> _unittype >> "canDeactivateMines") == 1]}||
            {_object getVariable ["ACE_isEngineer", getNumber (configFile >> "CfgVehicles" >> _unittype >> "engineer") == 1]}||
            {(!(isNull _object))&&{({(toLower _x) in ["item_b_uavterminal","item_o_uavterminal","item_i_uavterminal"]} count (items _object))>0}}
        ) then {
            (getArray(ConfigFile >> "CfgKerberos" >> "headquarter">>"costs">>"soldier_special")) call _fnc_valueAdd;
        };
    private _weapons = If !(isNull _object) then {
        weapons _object
    } else {
        getArray(configfile >> "CfgVehicles" >> _unittype >> "weapons")
    };
    {
        private _curWeapon = _x;
        ([_curWeapon] call BIS_fnc_itemType)params ["_itemclass","_itemtype"];
        If (_itemtype in ["Launcher","RocketLauncher","MissileLauncher"]) then {
            private _mag = ((getArray(configFile >> "CfgWeapons" >> _curWeapon >> "magazines")) select 0);

            If ((isNil "_mag")||{(getNumber(configFile >> "CfgAmmo" >> getText(configFile >> "CfgMagazines" >> _mag >> "ammo") >> "airLock")) > 0}) then {
                (getArray(ConfigFile >> "CfgKerberos" >> "headquarter">>"costs">>"soldier_aa")) call _fnc_valueAdd;
            } else {
                (getArray(ConfigFile >> "CfgKerberos" >> "headquarter">>"costs">>"soldier_at")) call _fnc_valueAdd;
            };
        };
        If (_itemtype in ["MachineGun"]) then {
            (getArray(ConfigFile >> "CfgKerberos" >> "headquarter">>"costs">>"soldier_mg")) call _fnc_valueAdd;
        };
        If ((_itemtype in ["SniperRifle"])||(isClass(configFile >> "CfgWeapons" >> _curWeapon >> "far_optic1"))) then {
            (getArray(ConfigFile >> "CfgKerberos" >> "headquarter">>"costs">>"soldier_sniper")) call _fnc_valueAdd;
        };
    } forEach _weapons;

    HASH_SET(GVAR(costs),_unittype,_value select 0);
    HASH_SET(GVAR(strength),_unittype,_value select 1);
    HASH_SET(GVAR(defence),_unittype,_value select 2);
};

If ((_unittype isKindOf "LandVehicle")||{_unittype isKindOf "Ship_F"}) exitWith {
    _value = getArray(ConfigFile >> "CfgKerberos" >> "headquarter">>"costs">>"vehicle");

    // SPecial
    If (
            (
                (getNumber (configFile >> "CfgVehicles" >> _unittype >> "attendant") > 0)||
                {getNumber (configFile >> "CfgVehicles" >> _unittype >> "ace_refuel_fuelCargo") > 0}||
                {isClass(configFile >> "CfgVehicles" >> _unittype >> "ACE_Actions" >> "ACE_MainActions" >> "ACE_Rearm_TakeAmmo")}
            )||
            {
                (!isNil {_object getUnitTrait "Medic"})&&{
                    ([_object] call ace_medical_fnc_isMedic)||
                    {[_object] call ACE_rearm_fnc_canTakeAmmo}
                }
            }
        ) then {
            (getArray(ConfigFile >> "CfgKerberos" >> "headquarter">>"costs">>"vehicle_special")) call _fnc_valueAdd;
        };

    If (isClass(configfile >> "CfgVehicles" >> _unittype >> "HitPoints" >> "HitRTrack")) then {
        (getArray(ConfigFile >> "CfgKerberos" >> "headquarter">>"costs">>"vehicle_tracks")) call _fnc_valueAdd;
    };

    // Armor
    private _armor = getNumber(configfile >> "CfgVehicles" >> _unittype >> "armor");
    If (_armor > 500) then {
        (getArray(ConfigFile >> "CfgKerberos" >> "headquarter">>"costs">>"vehicle_heavy")) call _fnc_valueAdd;
    };
    If ((_armor <= 500)&&(_armor > 200)) then {
        (getArray(ConfigFile >> "CfgKerberos" >> "headquarter">>"costs">>"vehicle_medium")) call _fnc_valueAdd;
    };
    If ((_armor <= 200)&&(_armor > 50)) then {
        (getArray(ConfigFile >> "CfgKerberos" >> "headquarter">>"costs">>"vehicle_light")) call _fnc_valueAdd;
    };

    // weapons
    private _weapons = If !(isNull _object) then {
        weapons _object
    } else {
        [_unittype] call _fnc_getWeapons;
    };
    {
        private _curWeapon = _x;
        ([_curWeapon] call BIS_fnc_itemType)params ["_itemclass","_itemtype"];
        If (_itemtype in ["MachineGun"]) then {
            (getArray(ConfigFile >> "CfgKerberos" >> "headquarter">>"costs">>"vehicle_hmg")) call _fnc_valueAdd;
        };
        If (_itemtype in ["GrenadeLauncher"]) then {
            (getArray(ConfigFile >> "CfgKerberos" >> "headquarter">>"costs">>"vehicle_gmg")) call _fnc_valueAdd;
        };
        If (_itemtype in ["Launcher","MissileLauncher","RocketLauncher"]) then {
            private _mag = ((getArray(configFile >> "CfgWeapons" >> _curWeapon >> "magazines")) select 0);
            If ((isNil "_mag")||{(getNumber(configFile >> "CfgAmmo" >> getText(configFile >> "CfgMagazines" >> _mag >> "ammo") >> "airLock")) > 0}) then {
                (getArray(ConfigFile >> "CfgKerberos" >> "headquarter">>"costs">>"vehicle_aarocket")) call _fnc_valueAdd;
            } else {
                (getArray(ConfigFile >> "CfgKerberos" >> "headquarter">>"costs">>"vehicle_atrocket")) call _fnc_valueAdd;
            };
        };
        If (_itemtype in ["Mortar"]) then {
            (getArray(ConfigFile >> "CfgKerberos" >> "headquarter">>"costs">>"vehicle_artillery")) call _fnc_valueAdd;
        };
        If (_itemtype in ["RocketLauncher"]) then {
            (getArray(ConfigFile >> "CfgKerberos" >> "headquarter">>"costs">>"vehicle_rocketart")) call _fnc_valueAdd;
        };
        If (_itemtype in ["Cannon"]) then {
            private _mag = ((getArray(configFile >> "CfgWeapons" >> _curWeapon >> "magazines")) select 0);
            private _cal = If (isNil "_mag") then {
                0
            }else{
                getNumber(configFile >> "CfgMagazines" >> getText(configFile >> "CfgMagazines" >> _mag >> "ammo") >> "ace_rearm_caliber");
            };
            If (_cal > 80) then {
                (getArray(ConfigFile >> "CfgKerberos" >> "headquarter">>"costs">>"vehicle_gun")) call _fnc_valueAdd;
            } else {
                (getArray(ConfigFile >> "CfgKerberos" >> "headquarter">>"costs">>"vehicle_20mm")) call _fnc_valueAdd;
            };
        };
    } forEach _weapons;

    HASH_SET(GVAR(costs),_unittype,_value select 0);
    HASH_SET(GVAR(strength),_unittype,_value select 1);
    HASH_SET(GVAR(defence),_unittype,_value select 2);
};

LOG(FORMAT_1("Vehicle not found: %1",_unittype));
_value = [0,[0,0,0],[0,0,0]];
HASH_SET(GVAR(costs),_unittype,_value select 0);
HASH_SET(GVAR(strength),_unittype,_value select 1);
HASH_SET(GVAR(defence),_unittype,_value select 2);

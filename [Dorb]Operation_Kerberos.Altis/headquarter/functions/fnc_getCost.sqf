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

private _value = HASH_GET(GVAR(costs),_type);
If !(isNil "_value") exitWith {
    (_value select 0);
};

If (isCLass(missionConfigFile>>"costs">>_type)) exitWith {
    private _value = [
        getNumber(missionConfigFile>>"costs">>_type>>"value"),
        getNumber(missionConfigFile>>"costs">>_type>>"strenght"),
        getNumber(missionConfigFile>>"costs">>_type>>"defence")
    ];
    HASH_SET(GVAR(costs),_Type,_value);
    (_value select 0);
};

If (_type isKindOf "Autonomous") exitWith {
    If !(_type isKindOf "Air") exitWith {
        _value = getArray(missionConfigFile>>"costs">>"drone_ground");
        HASH_SET(GVAR(costs),_Type,_value);
        (_value select 0);
    };
    If (_type isKindOf "Plane") then {
        _value = getArray(missionConfigFile>>"costs">>"drone_plane");
        HASH_SET(GVAR(costs),_Type,_value);
        (_value select 0);
    }else{
        _value = getArray(missionConfigFile>>"costs">>"drone_helicopter");
        HASH_SET(GVAR(costs),_Type,_value);
        (_value select 0);
    };
};

If (_type isKindOf "Air") exitWith {
    private _weapons = If !(isNull _object) then {
        weapons _object
    } else {
        getArray(configfile >> "CfgVehicles" >> _type >> "weapons")
    };
    _weapons = _weapons select {!((toUpper _x) in ["CMFLARELAUNCHER","ACE_AIR_SAFETY","RHS_WEAP_MASTERSAFE","RHS_LWIRCM_MELB"])};

    If (_type isKindOf "Plane") then {
        If ((count _weapons) >0) then {
            private _isAI = 0;
            {
                private _curWeapon = _x;
                private _mag = ((getArray(configFile >> "CfgWeapons" >> _curWeapon >> "magazines")) select 0);
                _isAI = _isAI max (getNumber(configFile >> "CfgAmmo" >> getText(configFile >> "CfgMagazines" >> _mag >> "ammo") >> "airLock"));
            } forEach _weapons;
            If (_isAI > 0) then {
                _value = getArray(missionConfigFile>>"costs">>"plane_ai");
            } else {
                _value = getArray(missionConfigFile>>"costs">>"plane_cas");
            };
            HASH_SET(GVAR(costs),_Type,_value);
            (_value select 0);
        } else {
            _value = getArray(missionConfigFile>>"costs">>"plane");
            HASH_SET(GVAR(costs),_Type,_value);
            (_value select 0);
        };
    }else{
        If ((count _weapons) >0) then {
            _value = getArray(missionConfigFile>>"costs">>"helicopter_cas");
            HASH_SET(GVAR(costs),_Type,_value);
            (_value select 0);
        } else {
            _value = getArray(missionConfigFile>>"costs">>"helicopter");
            HASH_SET(GVAR(costs),_Type,_value);
            (_value select 0);
        };
    };
};


_fnc_valueAdd = {
    _this params ["_cost","_strenght","_defence"];
    _value set[0,(_value select 0)+_cost];
    (_value select 1) set[0,((_value select 1) select 0)max(_strenght select 0)];
    (_value select 1) set[1,((_value select 1) select 1)max(_strenght select 1)];
    (_value select 1) set[2,((_value select 1) select 2)max(_strenght select 2)];

    (_value select 2) set[0,((_value select 1) select 0)max(_defence select 0)];
    (_value select 2) set[1,((_value select 1) select 1)max(_defence select 1)];
    (_value select 2) set[2,((_value select 1) select 2)max(_defence select 2)];
};

If (_type isKindOf "CAManBase") exitWith {
    _value = getArray(missionConfigFile>>"costs">>"soldier");
    If (
            ((getNumber (configFile >> "CfgVehicles" >> _type >> "attendant")>0)||
            {(_object getVariable [QGVAR(medicClass),0]) > 1})||
            {_object getVariable ["ACE_isEOD", getNumber (configFile >> "CfgVehicles" >> _type >> "canDeactivateMines") == 1]}||
            {_object getVariable ["ACE_isEngineer", getNumber (configFile >> "CfgVehicles" >> _type >> "engineer") == 1]}
            {(!(isNull _object))&&{({(toLower _x) in ["item_b_uavterminal","item_o_uavterminal","item_i_uavterminal"]} count (items _object))>0}}
        ) then {
            (getArray(missionConfigFile>>"costs">>"soldier_special")) call _fnc_valueAdd;
        };
    private _weapons = If !(isNull _object) then {
        weapons _object
    } else {
        getArray(configfile >> "CfgVehicles" >> _type >> "weapons")
    };
    {
        private _curWeapon = _x;
        ([_curWeapon] call BIS_fnc_itemType)params ["_itemclass","_itemtype"];
        If (_itemtype in ["Launcher"]) then {
            private _mag = ((getArray(configFile >> "CfgWeapons" >> _curWeapon >> "magazines")) select 0);
            private _airlock = getNumber(configFile >> "CfgAmmo" >> getText(configFile >> "CfgMagazines" >> _mag >> "ammo") >> "airLock");
            If (_airlock > 0) then {
                (getArray(missionConfigFile>>"costs">>"soldier_at")) call _fnc_valueAdd;
            } else {
                (getArray(missionConfigFile>>"costs">>"soldier_aa")) call _fnc_valueAdd;
            };
        };
        If (_itemtype in ["MG"]) then {
            (getArray(missionConfigFile>>"costs">>"soldier_mg")) call _fnc_valueAdd;
        };
        If (_itemtype in ["Sniper"]) then {
            (getArray(missionConfigFile>>"costs">>"soldier_sniper")) call _fnc_valueAdd;
        };
    } forEach _weapons;

    HASH_SET(GVAR(costs),_Type,_value);
    (_value select 0);
};

If ((_type isKindOf "LandVehicle")||{_type isKindOf "Ship_F"}) exitWith {
    _value = getArray(missionConfigFile>>"costs">>"vehicle");

    // SPecial
    If (
            (
                (getNumber (configFile >> "CfgVehicles" >> _type >> "attendant") > 0)||
                {getNumber (configFile >> "CfgVehicles" >> _type >> "ace_refuel_fuelCargo")) > 0}||
                {isClass(configFile >> "CfgVehicles" >> _type >> "ACE_Actions" >> "ACE_MainActions" >> "ACE_Rearm_TakeAmmo")}
            )||
            {
                (!isNull _object)&&(
                    ([_object] call ace_medical_fnc_isMedic)||
                    {[_object] call ACE_rearm_fnc_canTakeAmmo}
                )
            }
        ) then {
            (getArray(missionConfigFile>>"costs">>"vehicle_special")) call _fnc_valueAdd;
        };

    If (isClass(configfile >> "CfgVehicles" >> _type >> "HitPoints" >> "HitRTrack")) then {
        (getArray(missionConfigFile>>"costs">>"vehicle_tracks")) call _fnc_valueAdd;
    };

    // Armor
    private _armor = getNumber(configfile >> "CfgVehicles" >> _type >> "armor");
    If (_armor > 500) then {
        (getArray(missionConfigFile>>"costs">>"vehicle_heavy")) call _fnc_valueAdd;
    };
    If ((_armor <= 500)&&(_armor > 200)) then {
        (getArray(missionConfigFile>>"costs">>"vehicle_medium")) call _fnc_valueAdd;
    };
    If ((_armor <= 200)&&(_armor > 20)) then {
        (getArray(missionConfigFile>>"costs">>"vehicle_light")) call _fnc_valueAdd;
    };

    // weapons
    private _weapons = If !(isNull _object) then {
        weapons _object
    } else {
        getArray(configfile >> "CfgVehicles" >> _type >> "weapons")
    };

    {
        private _curWeapon = _x;
        ([_curWeapon] call BIS_fnc_itemType)params ["_itemclass","_itemtype"];
        If (_itemtype in ["MachineGun"]) then {
            (getArray(missionConfigFile>>"costs">>"vehicle_hmg")) call _fnc_valueAdd;
        };
        If (_itemtype in ["GrenadeLauncher"]) then {
            (getArray(missionConfigFile>>"costs">>"vehicle_gmg")) call _fnc_valueAdd;
        };
        If (_itemtype in ["Launcher","MissileLauncher","RocketLauncher"]) then {
            private _mag = ((getArray(configFile >> "CfgWeapons" >> _type >> "magazines")) select 0);
            private _airlock = getNumber(configFile >> "CfgAmmo" >> getText(configFile >> "CfgMagazines" >> _mag >> "ammo") >> "airLock");
            If (_airlock > 0) then {
                (getArray(missionConfigFile>>"costs">>"vehicle_atrocket")) call _fnc_valueAdd;
            } else {
                (getArray(missionConfigFile>>"costs">>"vehicle_aarocket")) call _fnc_valueAdd;
            };
        };
        If (_itemtype in ["Mortar"]) then {
            (getArray(missionConfigFile>>"costs">>"vehicle_artillery")) call _fnc_valueAdd;
        };
        If (_itemtype in ["RocketLauncher"]) then {
            (getArray(missionConfigFile>>"costs">>"vehicle_rocketart")) call _fnc_valueAdd;
        };
        If (_itemtype in ["Cannon"]) then {
            private _mag = ((getArray(configFile >> "CfgWeapons" >> _curWeapon >> "magazines")) select 0);
            private _cal = getNumber(configFile >> "CfgMagazines" >> getText(configFile >> "CfgMagazines" >> _mag >> "ammo") >> "ace_rearm_caliber");
            If (_cal > 80) then {
                (getArray(missionConfigFile>>"costs">>"vehicle_gun")) call _fnc_valueAdd;
            } else {
                (getArray(missionConfigFile>>"costs">>"vehicle_20mm")) call _fnc_valueAdd;
            };
        };
    } forEach _weapons;
    
    HASH_SET(GVAR(costs),_Type,_value);
    (_value select 0);
};

LOG(FORMAT_1("Vehicle not found: %1",_type))
HASH_SET(GVAR(costs),_Type,[0,[0,0,0],[0,0,0]]);
0;

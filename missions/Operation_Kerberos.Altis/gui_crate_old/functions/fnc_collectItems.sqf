/*
 *  Author: Dorbedo
 *
 *  Description:
 *      collects the items for the crate-spawner
 *
 *  Parameter(s):
 *      name
 *
 *  Returns:
 *      none
 *
 */
#include "script_component.hpp"

If ((!isNil QGVAR(hashlist))&&{IS_HASH(GVAR(hashlist))}) exitWith {};

[QGVAR(loadingscreen)] call bis_fnc_startloadingscreen;

private _hash = HASH_CREATE;
GVAR(hashlist) = _hash;

HASH_SET(GVAR(hashlist),"rifles",HASH_CREATE);
HASH_SET(GVAR(hashlist),"machinegun",HASH_CREATE);
HASH_SET(GVAR(hashlist),"sniper",HASH_CREATE);
HASH_SET(GVAR(hashlist),"shotgun",HASH_CREATE);

HASH_SET(GVAR(hashlist),"launcher",HASH_CREATE);
HASH_SET(GVAR(hashlist),"pistol",HASH_CREATE);

HASH_SET(GVAR(hashlist),"accessory",HASH_CREATE);

HASH_SET(GVAR(hashlist),"granades",HASH_CREATE);
HASH_SET(GVAR(hashlist),"explosives",HASH_CREATE);

HASH_SET(GVAR(hashlist),"backpack",HASH_CREATE);
HASH_SET(GVAR(hashlist),"vest",HASH_CREATE);
HASH_SET(GVAR(hashlist),"uniform",HASH_CREATE);
HASH_SET(GVAR(hashlist),"head",HASH_CREATE);

HASH_SET(GVAR(hashlist),"radios",HASH_CREATE);
HASH_SET(GVAR(hashlist),"navigation",HASH_CREATE);

HASH_SET(GVAR(hashlist),"medical",HASH_CREATE);
HASH_SET(GVAR(hashlist),"items",HASH_CREATE);
HASH_SET(GVAR(hashlist),"other",HASH_CREATE);

private _fnc_getKey = {
    _this params [["_bisType","",[""]]];
    _bisType = toLower _bisType;
    switch (_bisType) do {
        case "assaultrifle";
        case "rifle";
        case "submachinegun" : {"rifles"};

        case "machinegun" : {"machinegun"};

        case "sniperrifle" : {"sniper"};

        case "shotgun" : {"shotgun"};

        case "launcher";
        case "missilelauncher";
        case "submachinegun" : {"launcher"};

        case "handgun" : {"pistol"};

        case "AccessoryMuzzle";
        case "AccessoryPointer";
        case "AccessorySights" : {"accessory"};

        case "throw" : {"granades"};

        case "put" : {"explosives"};

        case "backpack" : {"backpack"};

        case "vest" : {"vest"};

        case "uniform" : {"uniform"};

        case "headgear";
        case "glasses";
        case "nvgoggles" : {"head"};

        case "radio" : {"radios"};

        case "watch";
        case "Binocular";
        case "Compass";
        case "GPS";
        case "UAVTerminal";
        case "Map";
        case "Binocular";
        case "LaserDesignator" : {"navigation"};

        case "medikit";
        case "firstaidkit" : {"medical"};

        case "minedetector";
        case "toolkit" : {"items"};

        default {"other"};
    };
};


private _fnc_isAceMedical = {
    _this params ["_class"];
    Private _namearr = (gettext(_class >> "picture")) splitString "\";
    If ("medical" in _namearr) then {true} else {false};
};

private _fnc_getMod = {
    _this params ["_classname"];
    private _return = "";
    private _modhash = HASH_GET(GVAR(hashlist),"mods");
    {
        private _curHash = HASH_GET(_modhash,_x);
        If (_className in HASH_GET(_modhash,"units")) exitWith {
            _return = _x;
        };
        If (_className in HASH_GET(_modhash,"weapons")) exitWith {
            _return = _x;
        };
        If (_className in HASH_GET(_modhash,"magazines")) exitWith {
            _return = _x;
        };
    } forEach (HASH_KEYS(_modhash));
};





private _configArray = (
        ("isclass _x" configclasses (configfile >> "cfgweapons")) +
        ("isclass _x && (getText(_x >> 'vehicleClass')=='Backpacks')" configclasses (configfile >> "cfgvehicles")) +
        ("isclass _x" configclasses (configfile >> "cfgglasses"))
    );
private _CfgPatches = "(
        (!((getArray (_x >> 'magazines'))isEqualTo [])) ||
        (!((getArray (_x >> 'units'))isEqualTo [])) ||
        (!((getArray (_x >> 'weapons'))isEqualTo []))
    )" configClasses (configFile >> "CfgPatches");

private _progressStep = 1 / (count _configArray + count _cfgPatches);
private _step1 = (count _cfgPatches);



HASH_SET(GVAR(hashlist),"mods",HASH_CREATE);
private _modshash = HASH_GET(GVAR(hashlist),"mods");

{
    private _configname = configname _x;
    private _namearr = _configname splitString "_";
    If (!((_namearr select 0) in ["A3","A3Data","a3"])) then {
        If (HASH_HASKEY(_modshash,_configname)) then {
            HASH_GET(_modshash,"units") append (getArray(_x >> "units"));
            HASH_GET(_modshash,"weapons") append (getArray(_x >> "weapons"));
            HASH_GET(_modshash,"magazines") append (getArray(_x >> "magazines"));
        }else{
            HASH_SET(_modshash,"units",(getArray(_x >> "units")));
            HASH_SET(_modshash,"weapons",(getArray(_x >> "weapons")));
            HASH_SET(_modshash,"magazines",(getArray(_x >> "magazines")));
        };
    };
    progressloadingscreen (_foreachindex * _progressStep);
}foreach _cfgPatches;


{
    private _class = _x;
    private _className = configname _x;
    private _scope = if (isnumber (_class >> "scopeArsenal")) then {getnumber (_class >> "scopeArsenal")} else {getnumber (_class >> "scope")};
    private _isBase = if (isarray (_x >> "muzzles")) then {(_className call bis_fnc_baseWeapon == _className)} else {true};
    if (_scope == 2 && {gettext (_class >> "model") != ""} && _isBase && {gettext (_class >> "displayName") != ""}) then {
        (_className call bis_fnc_itemType) params ["_weaponTypeCategory","_weaponTypeSpecific"];
        if (_weaponTypeCategory != "VehicleWeapon") then {
            private _weaponKey = [_weaponTypeSpecific] call _fnc_getKey;
            private _weaponHash = HASH_GET(GVAR(hashlist),_weaponKey);
            private _itemHash = HASH_CREATE;
            HASH_SET(_weaponHash,_className,_itemHash);

            private _cfgAsArray = [_class,[]] call BIS_fnc_configPath;
            HASH_SET(_itemHash,"configpath",_cfgAsArray);
            private _value = [_class] call FUNC(getValue);
            HASH_SET(_itemHash,"cost",_value);
            HASH_SET(_itemHash,"name",getText(_class >> "displayName"));

            If ((_cfgAsArray select 1) in ["CfgVehicles","CfgMagazines"]) then {
                HASH_SET(_itemHash,"backpackcargo",1);
            }else{
                If (!((getArray(_x>>"Magazines"))isEqualTo[])) then {
                    HASH_SET(_itemHash,"weaponcargo",1);
                };
            };

            private _curMod = [_className] call _fnc_getMod;
            HASH_SET(_itemHash,"mod",_curMod);

            private _magazines = getarray(_class >> "magazines");
            {
                If (HASH_HASKEY(_weaponHash,_className)) then {
                    HASH_SET(_itemHash,"configpath",_cfgAsArray);
                    private _value = [_class] call FUNC(getValue);
                    HASH_SET(_itemHash,"cost",_value);
                    HASH_SET(_itemHash,"name",getText(_class >> "displayName"));
                    HASH_SET(_itemHash,"magazinecargo",1);
                    private _curMod = [_className] call _fnc_getMod;
                    HASH_SET(_itemHash,"mod",_curMod);
                };
            }foreach _magazines;
        };
    };
    progressloadingscreen ((_foreachindex + _step1) * _progressStep);
} foreach _configArray;

{
    private _curType = _x;
    private _weaponHash = HASH_GET(GVAR(hashlist),_curType);
    {
        private _magazineName = _x;
        If !(HASH_HASKEY(_weaponHash,"_magazineName")) then {
            private _magazineCfg = (configfile >> "cfgmagazines" >> _magazineName);
            If ((isClass(_magazineCfg))&&{(getnumber (_magazineCfg >> "scope") == 2 || getnumber (_magazineCfg >> "scopeArsenal") == 2)}) then {
                private _itemHash = HASH_CREATE;
                HASH_SET(_weaponHash,_className,_itemHash);
                private _cfgAsArray = [_class,[]] call BIS_fnc_configPath;
                HASH_SET(_itemHash,"configpath",_cfgAsArray);
                private _value = [_class] call FUNC(getValue);
                HASH_SET(_itemHash,"cost",_value);
                HASH_SET(_itemHash,"name",getText(_class >> "displayName"));
                HASH_SET(_itemHash,"magazinecargo",1);
            };
        };
    } foreach (getArray(configfile >> "cfgweapons" >> _curType >> "magazines"));
} forEach ["throw","put"];





[QGVAR(loadingscreen)] call bis_fnc_endLoadingScreen;

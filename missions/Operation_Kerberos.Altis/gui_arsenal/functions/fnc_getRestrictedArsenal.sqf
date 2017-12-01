/*
    Author: Dorbedo

    Description:
        adds a restriced arsenal to object

    Parameter(s):
        0: Object <OBJECT>
        1: restricedSide <SIDE>

    Return
        none
*/
#include "script_component.hpp"

If !(isClass(missionConfigFile>>QGVARMAIN(arsenal))) then {
    ERROR("No Arsenal config found")
};

If ((canSuspend)&&{GVAR(fastArsenalLoading)}) exitWith {
    [FUNC(getRestrictedArsenal),_this] call CBA_fnc_directCall;
};

private _loadingScreenActivated = ! GVAR(fastArsenalLoading);

private _neededVersion = format["%1_%2", getText(missionConfigFile >> QUOTE(DOUBLES(CfgComponent,ADDON)) >> "version"), productVersion select 2];
(profileNamespace getVariable [QGVAR(arsenalList_Full),["NotFound",[]]]) params [["_currentVersion","NotFound",[]],["_list",[],[[]]]];
TRACEV_2(_currentVersion,_neededVersion);
If (((!(_list isEqualTo []))&&{_currentVersion isEqualTo _neededVersion})&&{!GVAR(forceReload)}) exitWith {
    missionNamespace setVariable [QGVAR(arsenalList_Full),_list];
};


private _itemBlacklist = (getArray(missionConfigFile>>QGVARMAIN(arsenal)>> "ItemsBlacklist"));
private _weaponBlacklist = (getArray(missionConfigFile>>QGVARMAIN(arsenal)>> "WeaponsBlacklist"));
private _backpackBlacklist = getArray(missionConfigFile>>QGVARMAIN(arsenal)>> "BackpackBlacklist");
private _magazineBlacklist = getArray(missionConfigFile>>QGVARMAIN(arsenal)>> "MagazineBlackList");

private _blackList = _itemBlacklist + _weaponBlacklist + _backpackBlacklist;

private _addItems = [];
private _addWeapons = [];
private _addBackpacks = [];
private _addMagazines = [];

private _fixItems = [];
private _fixWeapons = [];
private _fixBackpacks = [];
private _fixMagazines = [];

private _configArray = (
    ("isclass _x" configclasses (configfile >> "cfgweapons")) +
    ("isclass _x && (getText(_x >> 'vehicleClass')=='Backpacks')" configclasses (configfile >> "cfgvehicles")) +
    ("isclass _x" configclasses (configfile >> "cfgglasses"))
);

private _loadingScreenStep = 1/(count _configArray);


private _loadingScreenID = 0;
If (_loadingScreenActivated) then {
    _loadingScreenID = [localize LSTRING(CREATE_LIST)] call EFUNC(gui,startLoadingScreen)
} else {
    [QEGVAR(gui,message),[LSTRING(CATEGORY), LSTRING(CREATE_LIST), "green"]] call CBA_fnc_localEvent;
};

{
    private _class = _x;
    private _className = configname _x;
    private _isBase = if (isarray (_x >> "muzzles")) then {(_className call bis_fnc_baseWeapon == _className)} else {true};
    private _scope = if (isnumber (_class >> "scopeArsenal")) then {getnumber (_class >> "scopeArsenal")} else {getnumber (_class >> "scope")};
    if ((_scope > 1) && {(gettext (_class >> "model") != "")} && _isBase && {gettext (_class >> "displayName") != ""}&&{!(_className in _blacklist)}) then {
        (_className call bis_fnc_itemType) params ["_weaponTypeCategory","_weaponTypeSpecific"];
        if (!(_weaponTypeCategory in ["VehicleWeapon","Magazine"])) then {
            private _hinzufuegen = true;
            If (_className in _blacklist) then {_hinzufuegen = false;};
            If (_hinzufuegen) then {
                switch (true) do {
                    case (_weaponTypeCategory in ["Weapon"]) : {
                        _addWeapons pushBackUnique _className;
                        private _magazines = getarray(_class >> "magazines");
                        {
                            private _scopeMag = if (isnumber (configFile >> "CfgMagazines" >> _x >> "scopeArsenal")) then {getnumber (configFile >> "CfgMagazines" >> _x >> "scopeArsenal")} else {getnumber (configFile >> "CfgMagazines" >> _x >> "scope")};
                            If ((!(_x in _magazineBlacklist))&& (_scope > 1)) then {
                                _addMagazines pushBackUnique _x;
                            };
                        }foreach _magazines;
                    };
                    case (_weaponTypeCategory in ["Mine"]) : {
                        _addMagazines pushBackUnique _className;
                    };
                    case (_weaponTypeSpecific in ["Backpack"]) : {
                        _addBackpacks pushBackUnique _className;
                    };
                    default {
                        _addItems pushBackUnique _className;
                        If (_weaponTypeSpecific in ["Binocular"]) then {
                            _fixWeapons pushBackUnique _className;
                        };
                    };
                };
            };
        };
    };
    If (_loadingScreenActivated) then {
        [_loadingScreenID,(_forEachIndex * _loadingScreenStep)] call EFUNC(gui,progressLoadingScreen);
    };
} foreach _configArray;
{
    private _weapon = _x;
    {
        {
            private _mag = _x;
            if ((!(_mag in _magazineBlacklist))&&{!(_mag in _addMagazines)}) then {
                private _scopeMag = if (isnumber (configfile >> "cfgmagazines" >> _mag >> "scopeArsenal")) then {getnumber (configfile >> "cfgmagazines" >> _mag >> "scopeArsenal")} else {getnumber (configfile >> "cfgmagazines" >> _mag >> "scope")};
                if (_scopeMag > 1) then {
                    _addMagazines pushBack _x;
                };
            };
        } foreach getarray (_x >> "magazines");
    } foreach ("isclass _x" configclasses (configfile >> "cfgweapons" >> _weapon));
} foreach ["Put","Throw"];

{
    If (isClass(configFile>>"CfgWeapons">>_x)) then {
        _addItems pushBackUnique _x;
    };
} foreach (getArray(missionConfigFile>>QGVARMAIN(arsenal)>> "ItemsWhitelist"));
{
    If (isClass(configFile>>"CfgWeapons">>_x)) then {
        _addWeapons pushBackUnique _x;
    };
} foreach (getArray(missionConfigFile>>QGVARMAIN(arsenal)>> "WeaponsWhitelist"));
{
    If (isClass(configFile>>"CfgMagazines">>_x)) then {
        _addMagazines pushBackUnique _x;
    };
} foreach (getArray(missionConfigFile>>QGVARMAIN(arsenal)>> "MagazineWhiteList"));
{
    If (isClass(configFile>>"CfgVehicles">>_x)) then {
        _addBackpacks pushBackUnique _x;
    };
} foreach (getArray(missionConfigFile>>QGVARMAIN(arsenal)>> "BackpackWhitelist"));

If (_loadingScreenActivated) then {
    [_loadingScreenID] call EFUNC(gui,endLoadingScreen);
};

_list = [_addWeapons,_addMagazines,_addItems,_addBackpacks,_fixWeapons,_fixMagazines,_fixItems,_fixBackpacks];

profileNamespace setVariable [QGVAR(arsenalList_Full),[_neededVersion,_list]];
saveProfileNamespace;

GVAR(arsenalList_Full) = _list;

If (GVAR(forceReload)) then {
    [
        QGVAR(forceReload),
        false,
        0,
        "client",
        false
    ] call CBA_settings_fnc_set;
};

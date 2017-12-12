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
//#define DEBUG_MODE_FULL
#include "script_component.hpp"
params [["_side", side ace_player, [west]], ["_onlyGear", false, [true]]];

If ((canSuspend)&&{GVAR(fastArsenalLoading)}) exitWith {
    [FUNC(getSideRestrictedArsenal),_this] call CBA_fnc_directCall;
};

private _return = [];
private _loadingScreenActivated = ! GVAR(fastArsenalLoading);

private _blackList = getArray(missionConfigFile>>QGVARMAIN(arsenal)>> "blackList");

private _configArray = (
    ("isclass _x" configclasses (configfile >> "cfgweapons")) +
    ("isclass _x && (getText(_x >> 'vehicleClass')=='Backpacks')" configclasses (configfile >> "cfgvehicles")) +
    ("isclass _x" configclasses (configfile >> "cfgglasses"))
);


private _sideNumber = _side call BIS_fnc_sideID;

private _loadingScreenStep = 1/(count _configArray);
private _loadingScreenID = 0;
If (_loadingScreenActivated) then {
    _loadingScreenID = [localize LSTRING(CREATE_LIST)] call EFUNC(gui,startLoadingScreen);
} else {
    [QEGVAR(gui,message),[LSTRING(CATEGORY), LSTRING(CREATE_LIST), "green"]] call CBA_fnc_localEvent;
};
{
    private _class = _x;
    private _className = configname _x;
    private _scope = if (isnumber (_class >> "scopeArsenal")) then {getnumber (_class >> "scopeArsenal")} else {getnumber (_class >> "scope")};
    if (((_scope > 1) && {(gettext (_class >> "model") != "")} && {gettext (_class >> "displayName") != ""}&&{!(_className in _blacklist)})||{_className in _whitelist}) then {
        (_className call bis_fnc_itemType) params ["_weaponTypeCategory","_weaponTypeSpecific"];
        if (!(_weaponTypeCategory in ["VehicleWeapon","Magazine"])) then {
            private _addThisItem = true;
            If (_className in _blacklist) then {_addThisItem = false;};

            If (_addThisItem && {(_onlyGear && {(_weaponTypeCategory == "Equipment") || {_weaponTypeSpecific in ["Binocular","UAVTerminal","Radio","LaserDesignator"]}}) || {!_onlyGear}}) then {
                _addThisItem = _sideNumber in ([_className] call EFUNC(common,getItemside));
            };
            If (_className in _whitelist) then {_addThisItem = true;};

            If (_addThisItem) then {
                switch (true) do {
                    case (_weaponTypeCategory in ["Weapon"]) : {
                        _return pushBackUnique _className;
                        private _magazines = getarray(_class >> "magazines");
                        /// GrenadeLauncher
                        {
                            If (isClass (_class >> _x)) then {
                                _magazines = _magazines + getarray(_class >> _x >> "magazines");
                            };
                        } foreach getarray(_class >> "muzzles");
                        {
                            private _scopeMag = if (isnumber (configFile >> "CfgMagazines" >> _x >> "scopeArsenal")) then {getnumber (configFile >> "CfgMagazines" >> _x >> "scopeArsenal")} else {getnumber (configFile >> "CfgMagazines" >> _x >> "scope")};
                            If ((!(_x in _magazineBlacklist))&& (_scope > 1)) then {
                                _return pushBackUnique _x;
                            };
                        }foreach _magazines;
                        {
                            _return pushBackUnique _x;
                            _return pushBackUnique _x;
                            nil;
                        } count (_className call bis_fnc_compatibleItems);
                    };
                    case (_weaponTypeCategory in ["Mine"]) : {
                        _return pushBackUnique _className;
                    };
                    case (_weaponTypeSpecific in ["Backpack"]) : {
                        _return pushBackUnique _className;
                    };
                    default {
                        If (_weaponTypeSpecific in ["Binocular"]) then {
                            _return pushBackUnique _className;
                        };
                        _return pushBackUnique _className;
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
            if ((!(_mag in _magazineBlacklist))&&{!(_mag in _return)}) then {
                private _scopeMag = if (isnumber (configfile >> "cfgmagazines" >> _mag >> "scopeArsenal")) then {getnumber (configfile >> "cfgmagazines" >> _mag >> "scopeArsenal")} else {getnumber (configfile >> "cfgmagazines" >> _mag >> "scope")};
                if (_scopeMag > 1) then {
                    _return pushBack _x;
                };
            };
        } foreach getarray (_x >> "magazines");
    } foreach ("isclass _x" configclasses (configfile >> "cfgweapons" >> _weapon));
} foreach ["Put","Throw"];

{
    If ((isClass(configFile >> "CfgWeapons" >> _x)) || {isClass(configFile >> "CfgMagazines" >> _x)} || {isClass(configFile >> "CfgMagazines" >> _x)}) then {
        _return pushBackUnique _x;
    };
} foreach (getArray(missionConfigFile >> QGVARMAIN(arsenal) >> "whitelist"));

If (_loadingScreenActivated) then {
    [_loadingScreenID] call EFUNC(gui,endLoadingScreen);
};

If (GVAR(forceReload)) then {
    [
        QGVAR(forceReload),
        false,
        0,
        "client",
        false
    ] call CBA_settings_fnc_set;
};

_return

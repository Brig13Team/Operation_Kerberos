/*
    Author: Dorbedo

    Description:
        adds a restriced arsenal to object

    Parameter(s):
        0: Object <OBJECT>
        1: restrictEverything <SIDE>

    Return
        none
*/
//#define DEBUG_MODE_FULL
#include "script_component.hpp"
params [["_side", side ace_player, [west]], ["_restrictAll", false, [true]]];

If ((canSuspend)&&{GVAR(fastArsenalLoading)}) exitWith {
    [FUNC(getSideRestrictedArsenal), _this] call CBA_fnc_directCall;
};

private _return = [];
private _loadingScreenActivated = ! GVAR(fastArsenalLoading);

private _configArray = (configProperties [configfile >> "cfgweapons", "((isClass _x) && {getNumber (_x >> 'ace_arsenal_hide') < 1} && {1 < (if (isnumber (_x >> 'scopeArsenal')) then {getnumber (_x >> 'scopeArsenal')} else {getnumber (_x >> 'scope')})})", true]) +
    (configProperties [configfile >> "cfgvehicles", "((isClass _x) && {getText(_x >> 'vehicleClass')=='Backpacks'} && {getNumber (_x >> 'ace_arsenal_hide') < 1} && {1 < (if (isnumber (_x >> 'scopeArsenal')) then {getnumber (_x >> 'scopeArsenal')} else {getnumber (_x >> 'scope')})})", true]) +
    (configProperties [configfile >> "cfgglasses", "((isClass _x) && {getNumber (_x >> 'ace_arsenal_hide') < 1} && {1 < (if (isnumber (_x >> 'scopeArsenal')) then {getnumber (_x >> 'scopeArsenal')} else {getnumber (_x >> 'scope')})})", true]);


private _sideNumber = _side call BIS_fnc_sideID;
//TRACEV_1(_sideNumber);

private _loadingScreenStep = 1/(count _configArray);
private _loadingScreenID = 0;
If (_loadingScreenActivated) then {
    _loadingScreenID = [localize LSTRING(CREATE_LIST)] call EFUNC(gui,startLoadingScreen);
} else {
    [QEGVAR(gui,message),[LSTRING(CATEGORY), LSTRING(CREATE_LIST), "green"]] call CBA_fnc_localEvent;
};

{
    private _curCfg = _x;
    private _curClass = configname _x;
    if !((getText(_curCfg >> "model") isEqualTo "") || {getText(_curCfg >> "displayName") isEqualTo ""}) then {
        (_curClass call bis_fnc_itemType) params ["_weaponTypeCategory", "_weaponTypeSpecific"];
        if (!(_weaponTypeCategory in ["VehicleWeapon", "Magazine"])) then {
            //TRACEV_3(_sideNumber in ([_curClass] call EFUNC(common,getItemSide)),_sideNumber,_curClass);
            If (
                ((!_restrictAll) && {!(_weaponTypeCategory == "Equipment")} && {!(_weaponTypeSpecific in ["Radio", "UAVTerminal"])}) ||
                {(!_restrictAll) && {_weaponTypeCategory == "Equipment"} && {_sideNumber in ([_curClass] call EFUNC(common,getItemSide))}} ||
                {(!_restrictAll) && {(_weaponTypeSpecific == "Radio") || (_weaponTypeSpecific == "UAVTerminal")} && {_sideNumber in ([_curClass] call EFUNC(common,getItemSide))}} ||
                {(_restrictAll && {_sideNumber in ([_curClass] call EFUNC(common,getItemSide))})}
                ) then {
                If (_weaponTypeCategory in ["Weapon"]) then {
                    _curClass = [_curClass] call BIS_fnc_baseWeapon;
                    _return pushBackUnique _curClass;
                    private _magazines = [_curClass, "magazines", []] call EFUNC(common,getCfgWeapons);
                    //TRACEV_1(_magazines);
                    {
                        If (isClass (_curCfg >> _x)) then {
                            _magazines = _magazines + getarray(_curCfg >> _x >> "magazines");
                        };
                        nil
                    } count ([_curClass, "muzzles", []] call EFUNC(common,getCfgWeapons));
                    {
                        private _scopeMag = if (isnumber (configFile >> "CfgMagazines" >> _x >> "scopeArsenal")) then {[_x, "scopeArsenal", 0] call EFUNC(common,getCfgMagazines)} else {[_x, "scope", 0] call EFUNC(common,getCfgMagazines)};
                        If (_scopeMag > 1) then {
                            _return pushBackUnique _x;
                        };
                        nil
                    } count _magazines;
                    {
                        private _scopeAcc = if (isnumber (configFile >> "CfgWeapons" >> _x >> "scopeArsenal")) then {[_x, "scopeArsenal", 0] call EFUNC(common,getCfgWeapons)} else {[_x, "scope", 0] call EFUNC(common,getCfgWeapons)};
                        If ((_scopeAcc > 1) && {([_x, "ace_arsenal_hide", 0] call EFUNC(common,getCfgWeapons)) < 1}) then {
                            _return pushBackUnique _x;
                        };
                        nil
                    } count (_curClass call bis_fnc_compatibleItems);
                } else {
                    _return pushBackUnique _curClass;
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
            private _scopeMag = if (isnumber (configFile >> "CfgMagazines" >> _x >> "scopeArsenal")) then {[_x, "scopeArsenal", 0] call EFUNC(common,getCfgMagazines)} else {[_x, "scope", 0] call EFUNC(common,getCfgMagazines)};
            if (_scopeMag > 1) then {
                _return pushBackUnique _x;
            };
            nil
        } count getarray (_x >> "magazines");
        nil
    } count ("isclass _x" configclasses (configfile >> "cfgweapons" >> _weapon));
    nil
} count ["Put","Throw"];

private _blackList = getArray(missionConfigFile>>QGVARMAIN(arsenal)>> "blackList");
_return = _return select {!(_x in _blackList)};

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
        true
    ] call CBA_settings_fnc_set;
};

_return

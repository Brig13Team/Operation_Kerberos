/*
 *  Author: Dorbedo
 *
 *  Description:
 *      gets a random group
 *
 *  Parameter(s):
 *      0 : STRING - Grouptype
 *
 *  Returns:
 *      CONFIG/ARRAY - Groupconfig or array for fnc_groupfromarray
 *
 */
#include "script_component.hpp"

_this params [["_grouptype","",[""]]];
CHECK(_grouptype isEqualTo "")

private _cfg = (missionConfigFile >> QGVAR(unitlists) >> str GVARMAIN(side) >> GVARMAIN(side_type) >> "groups");

switch _grouptype do {
    case "defence" : {
        private _allConfigs = configProperties [(_cfg >> "defence"), "true", true];
        private _addition = (getArray(_cfg >> "groups_defence")) apply {[_x,configfile] call BIS_fnc_configPath};
        _allConfigs append _addition;
        selectRandom _allConfigs;
    };
    case "attack" : {
        private _allConfigs = configProperties [(_cfg >> "strikeforce"), "true", true];
        private _addition = (getArray(_cfg >> "groups_attack")) apply {[_x,configfile] call BIS_fnc_configPath};
        _allConfigs append _addition;
        selectRandom _allConfigs;
    };
    case "patrol" : {
        private _allConfigs = configProperties [(_cfg >> "patrol"), "true", true];
        private _addition = (getArray(_cfg >> "groups_patrol")) apply {[_x,configfile] call BIS_fnc_configPath};
        _allConfigs append _addition;
        selectRandom _allConfigs;
    };
    case "mechanized" : {
        private _allConfigs = configProperties [(_cfg >> "mechanized"), "true", true];
        private _addition = (getArray(_cfg >> "groups_mechanized")) apply {[_x,configfile] call BIS_fnc_configPath};
        _allConfigs append _addition;
        selectRandom _allConfigs;
    };
    case "sniper" : {
        private _allConfigs = configProperties [(_cfg >> "sniper"), "true", true];
        private _addition = (getArray(_cfg >> "groups_sniper")) apply {[_x,configfile] call BIS_fnc_configPath};
        _allConfigs append _addition;
        selectRandom _allConfigs;
    };
    default {configNull};
};

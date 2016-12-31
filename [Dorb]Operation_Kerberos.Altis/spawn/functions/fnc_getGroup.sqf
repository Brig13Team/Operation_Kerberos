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

private _cfg = (missionConfigFile >> "unitlists" >> str GVARMAIN(side) >> GVARMAIN(side_type) >> "groups");

switch _grouptype do {
    case "defence" : {
        private _allConfigs = "true" configClasses (_cfg >> "defence");
        private _addition = [(getArray(_cfg >> "groups_defence")),configNull] call BIS_fnc_configPath;
        _allConfigs append _addition;
        selectRandom _allConfigs;
    };
    case "attack" : {
        private _allConfigs = "true" configClasses (_cfg >> "strikeforce");
        private _addition = [(getArray(_cfg >> "groups_attack")),configNull] call BIS_fnc_configPath;
        _allConfigs append _addition;
        selectRandom _allConfigs;
    };
    case "patrol" : {
        private _allConfigs = "true" configClasses (_cfg >> "patrol");
        private _addition = [(getArray(_cfg >> "groups_patrol")),configNull] call BIS_fnc_configPath;
        _allConfigs append _addition;
        selectRandom _allConfigs;
    };
    default {configNull};
};

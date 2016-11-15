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

switch _grouptype do {
    case "defence" : {
        private _allConfigs = "true" configClasses (missionConfigFile >> "unitlists" >> str GVARMAIN(side) >> GVARMAIN(side_type) >> "groups" >> "defence");
        selectRandom _allConfigs;
    };
    case "attack" : {
        private _allConfigs = "true" configClasses (missionConfigFile >> "unitlists" >> str GVARMAIN(side) >> GVARMAIN(side_type) >> "groups" >> "strikeforce");
        selectRandom _allConfigs;
    };
    case "patrol" : {
        private _allConfigs = "true" configClasses (missionConfigFile >> "unitlists" >> str GVARMAIN(side) >> GVARMAIN(side_type) >> "groups" >> "patrol");
        selectRandom _allConfigs;
    };
};

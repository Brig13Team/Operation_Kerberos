/*
 *  Author: Dorbedo
 *
 *  Description:
 *      gets a random unit
 *
 *  Parameter(s):
 *      0 : STRING - Unittype
 *
 *  Returns:
 *      STRING - classname of a unit
 *
 */
#include "script_component.hpp"

_this params [["_grouptype","",[""]]];
CHECK(_grouptype isEqualTo "")

switch _grouptype do {
    case "intel" : {
        private _allObjects = getArray(missionConfigFile >> "unitlists" >> str GVARMAIN(side) >> GVARMAIN(side_type) >> "mission" >> "intel");
        selectRandom _allObjects;
    };
};

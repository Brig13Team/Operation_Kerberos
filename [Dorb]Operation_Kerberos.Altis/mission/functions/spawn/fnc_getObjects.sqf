/*
 *  Author: Dorbedo, iJesuz
 *
 *  Description:
 *      get object classes
 *
 *  Parameter(s):
 *      0 : STRING - Unittype
 *
 *  Returns:
 *      -
 */
#include "script_component.hpp"

_this params ["_type"];

private "_class";
switch _type do {
    case "hostage" : {
        _config = missionConfigFile >> QGVAR(unitlists) >> str GVARMAIN(side) >> GVARMAIN(side_type) >> "mission" >> "pow";
    };
    case "capture" : {
        _config = missionConfigFile >> QGVAR(unitlists) >> str GVARMAIN(side) >> GVARMAIN(side_type) >> "mission" >> "commander";
    };
    case "radiotower" : {
        _config = missionConfigFile >> QGVAR(unitlists) >> str GVARMAIN(side) >> GVARMAIN(side_type) >> "mission" >> "tower";
    };
    case "dronecommando" : {
        _config = missionConfigFile >> QGVAR(unitlists) >> str GVARMAIN(side) >> GVARMAIN(side_type) >> "mission" >> "hq_mobile";
    };
    default {
        _config = missionConfigFile >> QGVAR(unitlists) >> str GVARMAIN(side) >> GVARMAIN(side_type) >> "mission" >> "intel";
    };
};

getArray(_class)

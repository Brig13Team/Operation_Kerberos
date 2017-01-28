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

_this params [["_type","",[""]]];
CHECK(_type isEqualTo "")

switch _type do {
    case "intel" : {
        private _allObjects = getArray(missionConfigFile >> QGVAR(unitlists) >> str GVARMAIN(side) >> GVARMAIN(side_type) >> "mission" >> "intel");
        selectRandom _allObjects;
    };
    case "weaponcache" : {
        private _allObjects = getArray(missionConfigFile >> QGVAR(unitlists) >> str GVARMAIN(side) >> GVARMAIN(side_type) >> "mission" >> "weaponcache");
        selectRandom _allObjects;
    };
    case "hostage" : {
        private _allObjects = getArray(missionConfigFile >> QGVAR(unitlists) >> str GVARMAIN(side) >> GVARMAIN(side_type) >> "mission" >> "pow");
        selectRandom _allObjects;
    };
    case "capture" : {
        private _allObjects = getArray(missionConfigFile >> QGVAR(unitlists) >> str GVARMAIN(side) >> GVARMAIN(side_type) >> "mission" >> "commander");
        selectRandom _allObjects;
    };
    case "device" : {
        private _allObjects = getArray(missionConfigFile >> QGVAR(unitlists) >> str GVARMAIN(side) >> GVARMAIN(side_type) >> "mission" >> "device");
        selectRandom _allObjects;
    };
    case "prototype" : {
        private _allObjects = getArray(missionConfigFile >> QGVAR(unitlists) >> str GVARMAIN(side) >> GVARMAIN(side_type) >> "mission" >> "prototype");
        selectRandom _allObjects;
    };
    case "emp" : {
        private _allObjects = getArray(missionConfigFile >> QGVAR(unitlists) >> str GVARMAIN(side) >> GVARMAIN(side_type) >> "mission" >> "emp");
        selectRandom _allObjects;
    };
    case "radiotower" : {
        private _allObjects = getArray(missionConfigFile >> QGVAR(unitlists) >> str GVARMAIN(side) >> GVARMAIN(side_type) >> "mission" >> "tower");
        selectRandom _allObjects;
    };
    case "dronecommando" : {
        private _allObjects = getArray(missionConfigFile >> QGVAR(unitlists) >> str GVARMAIN(side) >> GVARMAIN(side_type) >> "mission" >> "hq_mobile");
        selectRandom _allObjects;
    };
    case "scarab" : {
        private _allObjects = getArray(missionConfigFile >> QGVAR(unitlists) >> str GVARMAIN(side) >> GVARMAIN(side_type) >> "mission" >> "scarab");
        selectRandom _allObjects;
    };
    case "radar" : {
        private _allObjects = getArray(missionConfigFile >> QGVAR(unitlists) >> str GVARMAIN(side) >> GVARMAIN(side_type) >> "mission" >> "radar");
        selectRandom _allObjects;
    };
    case "artillery" : {
        private _allObjects = getArray(missionConfigFile >> QGVAR(unitlists) >> str GVARMAIN(side) >> GVARMAIN(side_type) >> "art_shells");
        selectRandom _allObjects;
    };
    case "rockets" : {
        private _allObjects = getArray(missionConfigFile >> QGVAR(unitlists) >> str GVARMAIN(side) >> GVARMAIN(side_type) >> "art_rocket");
        selectRandom _allObjects;
    };

    default {ERROR(FORMAT_1("Missing entrie: %1",_this))};
};

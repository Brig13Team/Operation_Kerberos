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
 *      ARRAY/STRING - array with classnames/classname
 *
 */
#include "script_component.hpp"

_this params [["_grouptype","",[""]]];
CHECK(_grouptype isEqualTo "")

private _cfg = (missionConfigFile >> QGVAR(unitlists) >> str GVARMAIN(side) >> GVARMAIN(side_type));

private _return = switch _grouptype do {
    // air
    case "helicopter" : {
        private _allUnits = getArray(_cfg >> "callIn" >> "helicopter_cas");
        selectRandom _allUnits;
    };
    case "transporter_airdrop" : {
        private _allUnits = getArray(_cfg >> "callIn" >> "helicopter_transport");
        selectRandom _allUnits;
    };
    case "plane_ai" : {
        private _allUnits = getArray(_cfg >> "callIn" >> "planeAI");
        selectRandom _allUnits;
    };
    case "plane_cas" : {
        private _allUnits = getArray(_cfg >> "callIn" >> "planeCAS");
        selectRandom _allUnits;
    };

    // CAS
    case "transporter_lorry" : {
        private _allUnits = getArray(_cfg >> "trucks");
        selectRandom _allUnits;
    };
    case "transporter_sniper" : {
        private _allUnits = getArray(_cfg >> "cars");
        selectRandom _allUnits;
    };
    case "tanks" : {
        private _allUnits = getArray(_cfg >> "tanks");
        selectRandom _allUnits;
    };
    case "ifv" : {
        private _allUnits = getArray(_cfg >> "ifv");
        selectRandom _allUnits;
    };
    case "group_infantry" : {
        private _allUnits = getArray(_cfg >> "callIn" >> "group_infantry");
        selectRandom _allUnits;
    };

    // drones
    case "adrones" : {
        getArray(_cfg >> "attack_uavs");
    };
    case "rdrones" : {
        getArray(_cfg >> "recon_uavs");
    };


    case "crewmen" : {
        getArray(_cfg >> "crewmen");
    };
    case "soldiers" : {
        getArray(_cfg >> "soldiers");
    };

    case "boat" : {
        private _allUnits = getArray(_cfg >> "boats");
        selectRandom _allUnits;
    };
    case "diver" : {
        private _allUnits = getArray(_cfg >> "divers");
        selectRandom _allUnits;
    };
    case "divers" : {
        getArray(_cfg >> "divers");
    };
    case "civvehicle" : {
        private _allUnits = getArray(_cfg >> "civ_cars");
        selectRandom _allUnits;
    };
    case "civcar" : {
        private _allUnits = getArray(_cfg >> "civ_smallcars");
        selectRandom _allUnits;
    };

    default {ERROR(FORMAT_1("Missing entrie: %1",_this));nil};
};

[_return] param [0,[],[[],""]];

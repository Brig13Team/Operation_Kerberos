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
    // air
    case "helicopter" : {
        private _allUnits = getArray(missionConfigFile >> "unitlists" >> str GVARMAIN(side) >> GVARMAIN(side_type) >> "callIn" >> "helicopter_cas");
        selectRandom _allUnits;
    };
    case "transporter_airdrop" : {
        private _allUnits = getArray(missionConfigFile >> "unitlists" >> str GVARMAIN(side) >> GVARMAIN(side_type) >> "callIn" >> "helicopter_transport");
        selectRandom _allUnits;
    };
    case "plane_ai" : {
        private _allUnits = getArray(missionConfigFile >> "unitlists" >> str GVARMAIN(side) >> GVARMAIN(side_type) >> "callIn" >> "planeAI");
        selectRandom _allUnits;
    };
    case "plane_cas" : {
        private _allUnits = getArray(missionConfigFile >> "unitlists" >> str GVARMAIN(side) >> GVARMAIN(side_type) >> "callIn" >> "planeCAS");
        selectRandom _allUnits;
    };

    // CAS
    case "transporter_lorry" : {
        private _allUnits = getArray(missionConfigFile >> "unitlists" >> str GVARMAIN(side) >> GVARMAIN(side_type) >> "trucks");
        selectRandom _allUnits;
    };
    case "transporter_sniper" : {
        private _allUnits = getArray(missionConfigFile >> "unitlists" >> str GVARMAIN(side) >> GVARMAIN(side_type) >> "cars");
        selectRandom _allUnits;
    };
    case "tanks" : {
        private _allUnits = getArray(missionConfigFile >> "unitlists" >> str GVARMAIN(side) >> GVARMAIN(side_type) >> "tanks");
        selectRandom _allUnits;
    };
    case "group_infantry" : {
        private _allUnits = getArray(missionConfigFile >> "unitlists" >> str GVARMAIN(side) >> GVARMAIN(side_type) >> "callIn" >> "group_infantry");
        selectRandom _allUnits;
    };

};

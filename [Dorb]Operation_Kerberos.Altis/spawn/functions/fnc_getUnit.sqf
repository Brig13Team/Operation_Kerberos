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
    case "helicopter" : {
        private _allUnits = getArray(missionConfigFile >> "unitlists" >> str GVARMAIN(side) >> GVARMAIN(side_type) >> "callIn" >> "helicopter_cas");
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
    case "plane_cas" : {
        private _allUnits = getArray(missionConfigFile >> "unitlists" >> str GVARMAIN(side) >> GVARMAIN(side_type) >> "callIn" >> "planeCAS");
        selectRandom _allUnits;
    };
    group_infantry
    transporter_lorry
    transporter_airdrop
    transporter_sniper
    tanks
};

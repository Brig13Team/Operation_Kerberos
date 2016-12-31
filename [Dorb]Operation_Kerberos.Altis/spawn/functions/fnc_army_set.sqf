/*
    Author: Dorbedo

    Description:
        creates the unitslists

    Parameter(s):
        0 : SCALAR (opt)    - Number

*/

#include "script_component.hpp"

if (isNil QGVARMAIN(side)) then {
    GVARMAIN(side) = switch (GVARMAIN(playerside)) do {
        case "east" : {"west"};
        default {"east"};
    };
};

_this params [["_army","",[""]]];
If ((_army isEqualTo "")||{!isClass(missionConfigFile >> "unitlists" >> str GVARMAIN(side) >> _army)}) then {
    private _allArmys = "true" configClasses (missionConfigFile >> "unitlists" >> str GVARMAIN(side));
    _army = configName (selectRandom(_allArmys));
    GVARMAIN(side_type) = _army;
}else{
    GVARMAIN(side_type) = _army;
};

TRACEV_3(GVARMAIN(side),GVARMAIN(playerside),GVARMAIN(side_type));

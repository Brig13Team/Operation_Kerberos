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

private _config = missionConfigFile >> QEGVAR(spawn,unitlists);
if (isNil QGVARMAIN(side_type)) then {
    _config = _config >> format["base_%1", GVARMAIN(side)] >> "mission";
} else {
    _config = _config >> str GVARMAIN(side) >> GVARMAIN(side_type) >> "mission";
};

TRACEV_1(_type);

switch _type do {
    case "hostage" : {
        _config = _config >> "pow";
    };
    case "capture" : {
        _config = _config >> "commander";
    };
    case "radiotower" : {
        _config = _config >> "tower";
    };
    case "dronecommando" : {
        _config = _config >> "hq_mobile";
    };
    default {
        _config = _config >> _type;
    };
};

TRACEV_1(_config);

getArray(_config)

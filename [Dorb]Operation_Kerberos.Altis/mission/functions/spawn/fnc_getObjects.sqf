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
    case "upload" : {
         _config = _config >> "laptop_open";
    };
    case "wreck" : {
         _config = _config >> "wreck_air";
    };
    case "jammer" : {
        _config = _config >> "hq_mobile";
    };
    case "supplys" : {
        _config = _config >> "supplys";
    };
    default {
        _config = _config >> _type;
    };
};

TRACEV_1(_config);

if (isArray _config) exitWith {
   getArray(_config)
};

[]

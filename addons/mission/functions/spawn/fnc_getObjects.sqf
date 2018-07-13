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

private _config = ConfigFile >> "CfgKerberos" >> QEGVAR(spawn,unitlists);
if (isNil QGVARMAIN(side_type)) then {
    _config = _config >> format["base_%1", GVARMAIN(side)];
} else {
    _config = _config >> str GVARMAIN(side) >> GVARMAIN(side_type);
};

//TRACEV_1(_type);

private _return = [];

switch _type do {
    case "hostage" : {
        _return = getArray(_config >> "mission" >> "pow");
    };
    case "capture" : {
        _return = getArray(_config >> "mission" >> "commander");
    };
    case "radiotower" : {
        _return = getArray(_config >> "mission" >> "tower");
    };
    case "dronecommando" : {
        _return = getArray(_config >> "mission" >> "hq_mobile");
    };
    case "upload" : {
         _return = getArray(_config >> "mission" >> "laptop_open");
    };
    case "wreck" : {
         _return = getArray(_config >> "mission" >> "wreck_air");
    };
    case "jammer" : {
        _return = getArray(_config >> "mission" >> "hq_mobile");
    };
    case "supplys" : {
        _return = getArray(_config >> "mission" >> "supplys");
    };
    case "konvoi" : {
        _return = getArray(_config >> "mission" >> "konvoi");
    };
    case "chopper" : {
        _return = getArray(_config >> "mission" >> "chopper");
    };
    case "artillery" : {
        _return = getArray(_config >> "art_rocket") + getArray(_config >> "art_shells");
    };

    case "replacement" : {
        _return = ["capture"] call FUNC(spawn_getObjects);
        _retun append (["hostage"] call FUNC(spawn_getObjects));
    };

    default {
        _return = getArray(_config >> "mission" >> _type);
    };
};

//TRACEV_2(_config,_return);

_return

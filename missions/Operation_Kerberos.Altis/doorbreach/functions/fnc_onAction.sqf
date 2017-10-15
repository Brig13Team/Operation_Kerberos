/*
 *  Author: Dorbedo
 *
 *  Description:
 *      onActionCalled
 *
 *  Parameter(s):
 *      0 : OBJECT - house
 *      1 : OBJECT - caller
 *      2 : STRING - Animation
 *
 *  Returns:
 *     none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"
params ["_house","_caller","_door"];

_door = _door select 0;
_house setVariable [format[QGVAR(%1),_door],true,true];

GVAR(removedMagazine) = switch (true) do {
    case ("DemoCharge_Remote_Mag" in (magazines _caller)) : {
        _caller removeMagazineGlobal "DemoCharge_Remote_Mag";
        "DemoCharge_Remote_Mag"
    };
    case ("rhsusf_m112_mag" in (magazines _caller)) : {
        _caller removeMagazineGlobal "rhsusf_m112_mag";
        "rhsusf_m112_mag"
    };
    default {""};
};
CHECK(GVAR(removedMagazine) isEqualTo "")

[
    5,
    _this,
    {_args call FUNC(onActionSuccess);},
    {_args call FUNC(onActionFailure);},
    localize LSTRING(PLACING_CHARGE)
] call ACE_common_fnc_progressBar;

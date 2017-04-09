/*
 *  Author: iJesuz
 *
 *  Description:
 *      init mission "jammer"
 *
 *  Parameter(s):
 *      0 : HASH        - mission hash
 *      1 : [OBJECT]    - mission target
 *
 *  Returns:
 *      -
 */
#include "script_component.hpp"

_this params ["_mission", "_targets"];

{
    [_x] call EFUNC(mod_acre,jammer_add);
    If (_x isKindOf "rhs_gaz66_r142_base") then {
        [_x,1,true] call RHS_fnc_gaz66_radioDeploy;
    };
    If (_x isKindOf "rhsusf_fmtv_base") then {
        [_x,1,true] call RHS_fnc_fmtv_Deploy;
    };
    _x setVariable [QGVAR(isActive), true, true];
    _x addEventHandler ["Killed", LINKFUNC(obj__increaseCounter)];
} forEach _targets;

[_mission, _targets] call FUNC(mainmission__oneCounter);

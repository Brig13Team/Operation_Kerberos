/*
 *  Author: Dorbedo
 *
 *  Description:
 *      [Description]
 *
 *  Parameter(s):
 *      0 : [TYPE] - [argument name]
 *
 *  Returns:
 *      [TYPE] - [return name]
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

[
    QGVAR(addJammer),
    LINKFUNC(addJammer)
] call CBA_fnc_addEventHandler;

GVAR(lastRemove) = -1;

[
    QGVAR(removeJammer),
    {
        if (GVAR(lastRemove) < (CBA_missiontime + 20)) then {
            GVAR(lastRemove) = CBA_missiontime;
            _this call FUNC(removeJammer);
        };
    }
] call CBA_fnc_addEventHandler;

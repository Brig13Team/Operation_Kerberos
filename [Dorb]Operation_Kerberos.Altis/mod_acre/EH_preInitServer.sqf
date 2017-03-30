/*
 *  Author: Dorbedo
 *
 *  Description:
 *     preInit Server
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

[
    QGVAR(addJammer),
    LINKFUNC(jammer_add)
] call CBA_fnc_addEventHandler;

GVAR(lastRemove) = -1;

[
    QGVAR(removeJammer),
    {
        if (GVAR(lastRemove) < (CBA_missiontime + 20)) then {
            GVAR(lastRemove) = CBA_missiontime;
            _this call FUNC(jammer_remove);
        };
    }
] call CBA_fnc_addEventHandler;

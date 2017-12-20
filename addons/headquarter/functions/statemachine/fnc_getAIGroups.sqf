/*
 *  Author: Dorbedo
 *
 *  Description:
 *      returns the AIGroups for the statemachine
 *
 *  Parameter(s):
 *      0 : STRING - type of groups, by default, every registered group is returned
 *
 *  Returns:
 *      ARRAY - Array of groups
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_type","",[""]]];

If !(GVAR(active)) exitWith {[]};

GVAR(AIGroups) = allGroups select {(side (leader _x)) isEqualTo GVARMAIN(side)};

private _return = switch (_type) do {
    case "combat" : {
        GVAR(AIGroups) select {
            (_x getVariable [QGVAR(state),"none"]) == "combat"
        };
    };
    case "combat_ready" : {
        GVAR(AIGroups) select {
            ((_x getVariable [QGVAR(state),"none"]) == "combat")&&
            {isNull (_x getVariable [QGVAR(target),locationNull])}
        };
    };
    case "all" : {
        GVAR(AIGroups)
    };
    default {
        If (CBA_missiontime < (missionNamespace getVariable [QGVAR(statemachineIntervall),CBA_missiontime])) then {
            []
        } else {
            GVAR(statemachineIntervall) = CBA_missiontime + STATEMACHINEINTERVALL;
            GVAR(AIGroups)
        };
    };
};
//TRACEV_2(_this,_return);
_return

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

GVAR(AIGroups) = allGroups select {(side (leader _x)) isEqualTo GVARMAIN(side)};

switch (_type) do {
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

    default { GVAR(AIGroups) };
};

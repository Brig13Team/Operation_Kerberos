/**
 * Author: Dorbedo
 * returns all Missions
 *
 * Arguments:
 * 0: <BOOL> return all missions
 *
 * Return Value:
 * <ARRAY> an array with all missions
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params [["_returnAll", true, [true]]];

If (_returnAll isEqualTo true) then {
    missionNamespace getVariable [QGVAR(missions), []];
} else {
    If (CBA_missiontime <= (missionNamespace getVariable [QGVAR(statemachineIntervall),CBA_missiontime])) then {
        []
    } else {
        GVAR(statemachineIntervall) = CBA_missiontime + STATEMACHINEINTERVALL;
        missionNameSpace getVariable [QGVAR(missions),[]];
    };
};

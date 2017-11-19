#include "script_component.hpp"
/**
 * Name: dorb_mission_fnc_getAllMissions
 *
 * Author: Dorbedo
 * returns a list with all missions
 *
 * Arguments:
 * 0: <BOOL> return all missions
 *
 * Return Value:
 * <ARRAY> an array with all missions
 *
 */

params ["_returnAll"];

If (_returnAll isEqualTo true) then {
    missionNameSpace getVariable [QGVAR(missions), []];
} else {
    If (CBA_missiontime <= (missionNamespace getVariable [QGVAR(statemachineIntervall),CBA_missiontime])) then {
        []
    } else {
        GVAR(statemachineIntervall) = CBA_missiontime + STATEMACHINEINTERVALL;
        missionNameSpace getVariable [QGVAR(missions),[]];
    };
};

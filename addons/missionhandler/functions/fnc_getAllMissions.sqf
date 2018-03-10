#include "script_component.hpp"

/*
  Name: dorb_missionhandler_fnc_getAllMissions
  Author: Dorbedo
  returns all missions

  Arguments:
    0: return the missions <BOOL> (Default: true)

  Return Value:
    missions <ARRAY>

  Public: Yes
*/

params [["_returnAll", true [true]]];

If (_returnAll) exitWith {
    missionNameSpace getVariable [QGVARMAIN(allMissions), []];
};

If (CBA_missiontime < (missionNamespace getVariable [QGVAR(returnIntervall), CBA_missiontime])) then {
    [];
} else {
    GVAR(returnIntervall) = CBA_missiontime + STATEMACHINEINTERVALL;
    missionNameSpace getVariable [QGVAR(allMissions), []];
};

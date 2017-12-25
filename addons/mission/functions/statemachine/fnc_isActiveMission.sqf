#include "script_component.hpp"
/**
 * Name: dorb_mission_fnc_statemachine_isActiveMission
 *
 * Author: Dorbedo
 * returns if a mission is active
 *
 * Arguments:
 * 0: <LOCATION> the mission
 *
 * Return Value:
 * <BOOL> the mission is still active
 *
 */

params [["_mission", locationNull, [locationNull]]];

private _progress = _mission getVariable ["progress", "none"];
!((isNull _mission) || {_progress in ["cancel", "succeeded", "neutral", "failed"]})

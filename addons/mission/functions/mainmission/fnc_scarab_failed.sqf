/**
 * Author: Dorbedo
 * the scarab mission has failed
 *
 * Arguments:
 * 0: <LOCATION> the mission
 *
 * Return Value:
 * Nothing
 *
 */

#include "script_component.hpp"

params ["_mission"];

[] call EFUNC(gui,stopTimerGlobal);

private _targets = HASH_GET_DEF(_mission,"objects",[]);

{
    _x params [["_curScarab",objNull]];
    If !(isNull _curScarab) then {
        [_x] call EFUNC(missionobjects,launchScarab);
    };
} forEach _targets;

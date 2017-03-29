/*
 *  Author: iJesuz
 *
 *  Description:
 *      init sidemission "wreck"
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
    private _smoke = "test_EmptyObjectForSmoke" createVehicle (getPos _x);
    _smoke setPos (getPos _x);
    EGVAR(spawn,cleanUpDump) pushBack _smoke;
    EGVAR(spawn,cleanUpDump) pushBack _x;

    _x setVariable [QGVAR(isMissionTarget), true, true];
    _x setVariable [QGVAR(isActive), true, true];
    _x setVariable ["ace_cookOff_enable", false, true];
    _x setDammage 0.8;

    _x addEventHandler ["Killed", LINKFUNC(obj__increaseCounterTwo)];
} forEach _targets;

[_mission, _targets] call FUNC(mainmission__twoCounters);

/*
 *  Author: Dorbedo
 *
 *  Description:
 *      test for mission
 *
 *  Parameter(s):
 *      0 : [TYPE] - [argument name]
 *
 *  Returns:
 *      [TYPE] - [return name]
 *
 */

#include "script_component.hpp"

_this params [["_centerpos",[]]];

If (_centerpos isEqualTo []) then {
    private _centerpos = getMarkerPos "testmarker";
};

private _return = [_centerpos,"intel"] call EFUNC(spawn,missionTarget);
TRACEV_1(_return);


[QGVAR(start),[_centerpos]] call CBA_fnc_localEvent;

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
#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_centerpos",[]]];

If (_centerpos isEqualTo []) then {
    _centerpos = getMarkerPos "testmarker";
};

private _return = [_centerpos,"intel"] call EFUNC(spawn,missionTarget);
TRACEV_1(_return);

[_centerpos,"CENTERPOSITION","ColorBlue","mil_flag"] call EFUNC(common,debug_marker_create);

[QGVAR(start),[_centerpos]] call CBA_fnc_localEvent;

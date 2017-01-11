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
[] call EFUNC(spawn,army_set);
If (_centerpos isEqualTo []) then {
    _centerpos = getMarkerPos "testmarker";
};

private _return = [_centerpos,"intel"] call EFUNC(spawn,missionTarget);
TRACEV_1(_return);

[_centerpos,"CENTERPOSITION","ColorBlue","mil_flag"] call EFUNC(common,debug_marker_create);

[QGVAR(prepare),[_centerpos]] call CBA_fnc_localEvent;

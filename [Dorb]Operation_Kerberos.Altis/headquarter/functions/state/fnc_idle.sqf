/*
    Author: Dorbedo

    Description:
        idles at current position

    Parameter(s):
        0 : GROUP - Group

    Returns:
        none
*/
#include "script_component.hpp"
_this params[["_group",grpNull,[grpNull,objNull]]];

_group = _group call CBA_fnc_getGroup;

((group this) getVariable QGVAR(grouphash)) setvariable ["target",objNull];

while {(count (waypoints _group)) > 0} do {
    deleteWaypoint ((waypoints _group) select 0);
};

[_group,(getPos (leader _group)),20,"HOLD","SAFE","YELLOW","NORMAL","NO CHANGE","",[1,3,5],30] call FUNC(waypoints_add);

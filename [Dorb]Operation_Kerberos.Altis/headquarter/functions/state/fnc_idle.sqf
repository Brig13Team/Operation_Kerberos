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
private["_statement","_target","_waypoints","_lastWaypoint"];
_group = _group call CBA_fnc_getGroup;

SETVAR(_group,GVAR(target),objNull);

while {(count (waypoints _group)) > 0} do {
    deleteWaypoint ((waypoints _group) select 0);
};

[_group,(getPos (leader _group)),20,"HOLD","SAFE","YELLOW","NORMAL","NO CHANGE",_statement,[1,3,5],30] call FUNC(waypoints_add);
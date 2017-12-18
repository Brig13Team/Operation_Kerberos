/*
 *  Author: Dorbedo
 *
 *  Description:
 *      the group idles at current position
 *
 *  Parameter(s):
 *      0 : GROUP/OBJECT - The group/the group of a unit
 *      1 : STRING - The statement wich is called on finishing the state
 *
 *  Returns:
 *      none
 *
 */
#include "script_component.hpp"
CHECK(!isServer)
_this params[["_group",grpNull,[grpNull,objNull]]];

_group = _group call CBA_fnc_getGroup;

(_group getVariable QGVAR(grouphash)) setVariable ["target",objNull];

while {(count (waypoints _group)) > 0} do {
    deleteWaypoint ((waypoints _group) select 0);
};

[_group,(getPos (leader _group)),20,"HOLD","SAFE","YELLOW","NORMAL","NO CHANGE","",[1,3,5],30] call FUNC(waypoints_add);

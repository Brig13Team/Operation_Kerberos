/*
    Author: Dorbedo
    
    Description:
        attacks Position
    
    Parameter(s):
        0 : GROUP -Group

    Returns:
        none
*/
#include "script_component.hpp"
SCRIPT(state_attack);
_this params[["_group",grpNull,[grpNull,objNull]],["_statementFinish","",[""]]];

_group = _group call CBA_fnc_getGroup;

private _target = GETVAR(_group,GVAR(target),objNull);

If ((IS_OBJECT(_target))&&{!(Alive _target)}) exitWith {
    SETVAR(_group,GVAR(state),'idle');
    [_group] call FUNC(state_change);
};
If ((IS_ARRAY(_target))&&{_target isEqualTo []}) exitWith {
    SETVAR(_group,GVAR(state),'idle');
    [_group] call FUNC(state_change);
};
private ["_statement","_waypoints"];
if (IS_OBJECT(_target)) then {
    _waypoints = [getPos (leader _group),getPos _target] call FUNC(waypoints_generate);
    _statement = QUOTE(If !(alive ((group this) getVariable [ARR_2('GVAR(target)',objNull)])) then {_group setVariable [ARR_2('GVAR(state)','idle')];[this] call FUNC(state_change);};);

}else{
    _waypoints = [getPos (leader _group),_target] call FUNC(waypoints_generate);
    _statement = "";
};
TRACEV_1(_waypoints);
private _lastWaypoint = _waypoints deleteAt ((count _waypoints)-1);

while {(count (waypoints _group)) > 0} do {
    deleteWaypoint ((waypoints _group) select 0);
};

[_group,_waypoints,0,"MOVE","COMBAT","YELLOW","FULL","NO CHANGE",_statement,[1,3,5],150] call FUNC(waypoints_add);


_statement = QUOTE((group this) setVariable [ARR_2('GVAR(state)','idle')];[this] call FUNC(state_change);) + _statementFinish;

[_group, _lastWaypoint, 0, "SAD", "COMBAT", "RED", "FULL", "NO CHANGE", _statement, [3,6,9], 30] call FUNC(waypoints_add);


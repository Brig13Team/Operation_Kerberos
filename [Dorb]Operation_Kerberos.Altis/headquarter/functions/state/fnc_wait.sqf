/*
 *  Author: Dorbedo
 *
 *  Description:
 *      the group wait at a position
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

_this params[["_group",grpNull,[grpNull,objNull]],["_statementFinish","",[""]]];
private["_statement","_waypoints"];
_group = _group call CBA_fnc_getGroup;

private _grouphash = _group getVariable QGVAR(grouphash);
private _target = HASH_GET(_grouphash,"target");
If (IS_LOCATION(_target)) then {_target = locationPosition _target;};

private["_statement","_waypoints"];
if (IS_OBJECT(_target)) then {
    _waypoints = [getPos (leader _group),getPos _target] call FUNC(waypoints_generate);
    _statement = QUOTE(If !(alive (((group this) getVariable 'GVAR(grouphash)') getvariable [ARR_2('target',objNull)])) exitWith {[ARR_3(this,'idle',objNull)] call FUNC(state_set);};);
}else{
    If (IS_LOCATION(_target)) then {
        _waypoints = [getPos (leader _group),locationPosition _target] call FUNC(waypoints_generate);
        _statement = QUOTE(If (isNull ([(group this) getVariable 'GVAR(grouphash)'] param [ARR_2(0,locationNull)])) exitWith {[ARR_3(this,'idle',objNull)] call FUNC(state_set);};);
        //_statement = QUOTE(If (isNull (((group this) getVariable 'GVAR(grouphash)') getvariable [ARR_2('target',locationNull)])) exitWith {[ARR_3(this,'idle',objNull)] call FUNC(state_set);};);
    }else{
        _waypoints = [getPos (leader _group),_target] call FUNC(waypoints_generate);
        _statement = "";
    };
};

private _lastWaypoint = _waypoints deleteAt ((count _waypoints)-1);

while {(count (waypoints _group)) > 0} do {
    deleteWaypoint ((waypoints _group) select 0);
};

[_group,_waypoints,0,"MOVE","AWARE","YELLOW","NORMAL","NO CHANGE",_statement,[1,3,5],30] call FUNC(waypoints_add);

//_statement = QUOTE([ARR_2(this,'idle')] call FUNC(state_set);) + _statementFinish; /// the waypoint should never end

_statement = QUOTE([ARR_2(this,'idle')] call FUNC(state_set););

[_group, _lastWaypoint, 0, "DISMISS", "SAFE", "GREEN", "LIMITED", "NO CHANGE", _statement, [3,6,9], 30] call FUNC(waypoints_add);

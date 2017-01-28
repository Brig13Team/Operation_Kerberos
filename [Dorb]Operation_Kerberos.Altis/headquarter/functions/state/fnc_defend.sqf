/*
 *  Author: Dorbedo
 *
 *  Description:
 *      execution of the defend state
 *
 *  Parameter(s):
 *      0 : GROUP/OBJECT - The group/the group of a unit defends a location
 *
 *  Returns:
 *      none
 *
 */
#include "script_component.hpp"

_this params[["_group",grpNull,[grpNull,objNull]]];

_group = _group call CBA_fnc_getGroup;

private _grouphash = _group getVariable QGVAR(grouphash);
private _target = HASH_GET(_grouphash,"target");

If ((IS_OBJECT(_target))&&{!(Alive _target)}) exitWith {[_group,"idle",objNull] call FUNC(state_set);};

If ((IS_ARRAY(_target))&&{_target isEqualTo []}) exitWith {[_group,"idle",objNull] call FUNC(state_set);};



private["_statement","_waypoints"];
if (IS_OBJECT(_target)) then {
    _waypoints = [getPos (leader _group),getPos _target] call FUNC(waypoints_generate);
    _statement = QUOTE(If !(alive (((group this) getVariable 'GVAR(grouphash)') getvariable 'target')) exitWith {[ARR_3(this,'idle',objNull)] call FUNC(state_set);};);
}else{
    If (IS_LOCATION(_target)) then {
        _waypoints = [getPos (leader _group),locationPosition _target] call FUNC(waypoints_generate);
        //_statement = QUOTE(If (isNull (((group this) getVariable 'GVAR(grouphash)') getvariable 'target')) exitWith {[ARR_3(this,'idle',objNull)] call FUNC(state_set);};);
        _statement = QUOTE(If (isNull ([(group this) getVariable 'GVAR(grouphash)'] param [ARR_2(0,locationNull)])) exitWith {[ARR_3(this,'idle',objNull)] call FUNC(state_set);};);
    }else{
        _waypoints = [getPos (leader _group),_target] call FUNC(waypoints_generate);
        _statement = "";
    };
};

private _lastWaypoint = _waypoints deleteAt ((count _waypoints)-1);

while {(count (waypoints _group)) > 0} do {
    deleteWaypoint ((waypoints _group) select 0);
};

[_group,_waypoints,0,"MOVE","COMBAT","YELLOW","FULL","NO CHANGE",_statement,[1,3,5],30] call FUNC(waypoints_add);

_statement = QUOTE([ARR_2(this,'defend')] call FUNC(state_set););

[_group, _lastWaypoint, 0, "SENTRY", "COMBAT", "RED", "FULL", "NO CHANGE", _statement, [3,6,9], 30] call FUNC(waypoints_add);

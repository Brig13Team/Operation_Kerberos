/*
    Derivate of CBA_fnc_taskSearchArea
    Original Author: SilentSpike 2015-08-17

    Author: Dorbedo

    Description:
    Spawns Air Patrols

    Parameter(s):
        0 : GROUP/OBJECT - groupleader or group
        1 : ARRAY - centerposition
        2 : STRING - behavior
        3 : STRING - combatmode
        4 : STRING - speed
        5 : STRING - formation
        6 : STRING - code on completion
        7 : ARRAY - timeout

    Returns:
        None

*/
#include "script_component.hpp"
SCRIPT(patrol_task);

params [
    ["_group",grpNull,[grpNull,objNull]],
    ["_centerpos",[],[[]],[2,3]],
    ["_behavior","UNCHANGED",[""]],
    ["_combatmode","NO CHANGE",[""]],
    ["_speed","UNCHANGED",[""]],
    ["_formation","NO CHANGE",[""]],
    ["_onComplete","",[""]],
    ["_timeout",[0,0,0],[[]],[3]]
];

_group = _group call CBA_fnc_getGroup;
if !(local _group) exitWith {};
CHECK((isNull _group))

private["_args","_pos","_statement","_onComplete"];
_args = [_centerpos,_behavior,_combatmode,_speed,_formation,_onComplete,_timeout];

if (_centerpos isEqualTo []) then {
    _args = GETVAR(_group,GVAR(patrol_task),_args);
    _args params [_centerpos,_behavior,_combatmode,_speed,_formation,_onComplete,_timeout];
}else{
    SETPVAR(_group,GVAR(patrol_task),_args);
};
private "_temp";
_pos = switch (true) do {
	case ((typeOf (leader _group))isKindOf "Plane"): {_temp = [_centerpos,1000,4] call EFUNC(common,pos_random);_temp set [2,800];_temp};
	case ((typeOf (leader _group))isKindOf "Air"): {_temp = [_centerpos,1000,4] call EFUNC(common,pos_random);_temp set [2,500];_temp};
	case ((typeOf (leader _group))isKindOf "Ship"): {_temp = [_centerpos,1000,3] call EFUNC(common,pos_random);_temp};
	case ((typeOf (leader _group))in GVAR(list_divers)): {_temp = [_centerpos,1000,3] call EFUNC(common,pos_random);{_x swimInDepth -10;} forEach (units _group);_temp set [2,-10];_temp};
	default {_temp = [_centerpos,1000,0] call EFUNC(common,pos_random);_temp};
};

CHECK((_pos isEqualTo []))

_statement = QUOTE([this] call FUNC(patrol_task););

_onComplete = _onComplete + _statement;

[
    _group,
    _pos,
    0,
    "MOVE",
    _behavior,
    _combatmode,
    _speed,
    _formation,
    _onComplete,
    _timeout,
    5
] call CBA_fnc_addWaypoint;

If (count(waypoints _group)>1) then {
    deleteWaypoint [_group,0];
};
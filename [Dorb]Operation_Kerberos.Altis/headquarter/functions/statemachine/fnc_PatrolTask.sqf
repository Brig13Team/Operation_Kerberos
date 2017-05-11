/*
    Derivate of CBA_fnc_taskSearchArea
    Original Author: SilentSpike 2015-08-17

    Author: Dorbedo

    Description:
        Patrols

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
#define DEBUG_MODE_OFF
#include "script_component.hpp"

_this params [
    ["_group",grpNull,[grpNull,objNull]],
    ["_centerpos",[],[[]],[2,3]],
    ["_distance",1000,[0]],
    ["_type","MOVE",[""]],
    ["_behavior","UNCHANGED",[""]],
    ["_combatmode","NO CHANGE",[""]],
    ["_speed","UNCHANGED",[""]],
    ["_formation","NO CHANGE",[""]],
    ["_onComplete","",[""]],
    ["_timeout",[0,0,0],[[]],[3]],
    ["_compRadius", 15, [0]]
];

CHECK(isNull _group)

_group = _group call CBA_fnc_getGroup;
CHECK(!local _group)

private _args = [_centerpos,_distance,_type,_behavior,_combatmode,_speed,_formation,_onComplete,_timeout];

if !(_centerpos isEqualTo []) then {
    _group setVariable [QGVAR(PatrolTask),_args,true];
}else{
    _args = _group getVariable [QGVAR(PatrolTask),_args];
    _args params ["_centerpos","_distance","_type","_behavior","_combatmode","_speed","_formation","_onComplete","_timeout","_compRadius"];
};

private "_temp";
private _pos = switch (true) do {
    case ((typeOf (leader _group))isKindOf "Plane"): {
        _temp = [_centerpos,_distance,4] call EFUNC(common,pos_random);
        _temp set [2,800];
        _temp
    };
    case ((typeOf (leader _group))isKindOf "Air"): {
        _temp = [_centerpos,_distance,4] call EFUNC(common,pos_random);
        _temp set [2,500];
        _temp
    };
    case ((typeOf (leader _group))isKindOf "Ship"): {
        _temp = [_centerpos,_distance,3] call EFUNC(common,pos_random);
        _temp
    };
    case ((typeOf (leader _group))in (["divers"] call EFUNC(spawn,getUnit))) : {
        _temp = [_centerpos,_distance,3] call EFUNC(common,pos_random);
        {_x swimInDepth -10;} forEach (units _group);
        _temp set [2,-10];
        _temp
    };
    case ((vehicle (leader _group))isKindOf "LandVehicle"): {
        _temp = [_centerpos,_distance,0] call EFUNC(common,pos_random);
        _temp
    };
    default {
        _temp = [_centerpos,_distance,0] call EFUNC(common,pos_random);
        _temp
    };
};

CHECK(_pos isEqualTo [])

private _statement = QUOTE([this] call FUNC(statemachine_PatrolTask));

_onComplete = _onComplete + _statement;

[
    _group,
    _pos,
    0,
    _type,
    _behavior,
    _combatmode,
    _speed,
    _formation,
    _statement,
    _timeout,
    _compRadius
] call CBA_fnc_addWaypoint;


If (count(waypoints _group)>1) then {
    deleteWaypoint [_group,0];
};

#ifdef DEBUG_MODE_FULL
    [_pos] call EFUNC(common,debug_marker_create);
#endif

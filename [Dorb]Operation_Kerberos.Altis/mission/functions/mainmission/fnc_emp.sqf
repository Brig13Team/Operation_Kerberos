    /*
    Author: Dorbedo

    Description:
        Creates Mission "EMP".

    Parameter(s):
        0 :    ARRAY - Position

    Returns:
    BOOL
*/
#include "script_component.hpp"
SCRIPT(emp);
_this params [["_position",[],[[]],[2,3]]];
TRACEV_1(_position);
CHECK(_position isEqualTo [])
/********************
    create Target
********************/
private ["_targets","_spawnposition","_rand","_einheit","_unit"];
_targets=[];
_spawnposition=[];
_rand = 1;
for "_i" from 1 to _rand do{
    _einheit = selectRandom EGVAR(spawn,list_device);
    _spawnposition = [_position,25,200,15,0.15] call EFUNC(common,pos_flatempty);
    If (_spawnposition isEqualTo []) then {
        _spawnposition = [_position,25,200,15,0.22] call EFUNC(common,pos_flatempty);
    };
    If (_spawnposition isEqualTo []) then {
        _spawnposition = [_position,200,0] call EFUNC(common,pos_random);
        _spawnposition = _spawnposition findEmptyPosition [1,100,_einheit];
        if !(_spawnposition isEqualTo []) then {
            _unit = createVehicle [_einheit,_spawnposition, [], 0, "NONE"];
            _unit lock 3;
            SETPVAR(_unit,ACE_vehicleLock_lockpickStrength,-1);
            _targets pushBack _unit;
        };
    }else{
        _unit = createVehicle [_einheit,_spawnposition, [], 0, "NONE"];
        _unit lock 3;
        SETPVAR(_unit,ACE_vehicleLock_lockpickStrength,-1);
        _targets pushBack _unit;
    };    
};
/********************
    godmode
********************/
{
    [_x] call FUNC(objects_device_init);
    #ifdef DEBUG_MODE_FULL
        [getPos _x,"EMP"] call EFUNC(common,debug_marker_create);
    #endif
} forEach _targets;

/********************
    taskhandler
********************/
GVAR(emp_nextIntervall)= CBA_missionTime + 8*60;
[
    QUOTE(_this params['_targets'];private '_a';_a = {_x getVariable [ARR_2('GVAR(target_dead)',false)];}count _targets;If (_a == (count _targets)) then {true}else{false};),
    [_targets],
    "true",
    {},
    {},
    [],
    QUOTE(If (GVAR(emp_nextIntervall)<CBA_missionTime) then {{[QGVAR(emp),getPos _x] call EFUNC(events,serverEvent)} forEach (_this select 0);GVAR(emp_nextIntervall) = CBA_missionTime + 10*60 + 60*(floor(random 10));};),
    [_targets]
]
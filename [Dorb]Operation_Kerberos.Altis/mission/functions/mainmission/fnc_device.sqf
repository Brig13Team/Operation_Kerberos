    /*
    Author: Dorbedo

    Description:
        Creates Mission "DEVICE".

    Parameter(s):
        0 :    ARRAY - Position

    Returns:
    BOOL
*/
#include "script_component.hpp"
SCRIPT(device);
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
            _targets pushBack _unit;
        };
    }else{
        _unit = createVehicle [_einheit,_spawnposition, [], 0, "NONE"];
        _targets pushBack _unit;
    };    
};
/********************
    godmode
********************/
{
    [_x] call FUNC(objects_device_init);
    #ifdef DEBUG_MODE_FULL
        [getPos _x,"DEVICE","ColorBlack","hd_destroy"] call EFUNC(common,debug_marker_create);
    #endif
} forEach _targets;

/********************
    taskhandler
********************/

[
    QUOTE(_this params['_targets'];private '_a';_a = {_x getVariable [ARR_2('GVAR(target_dead)',false)];}count _targets;If (_a == (count _targets)) then {true}else{false};),
    [_targets],
    "true",
    {},
    {},
    [],
    QUOTE(If (isnil 'GVAR(earthquake_nextIntervall)') then {GVAR(earthquake_nextIntervall)=diag_ticktime + 8*60;};If (GVAR(earthquake_nextIntervall)<diag_ticktime) then {[ARR_2({if (!(vehicle player isKindof 'Air')) then {_rand=(floor(random 4)+1);[_rand]spawn BIS_fnc_earthquake;};},-1)] call EFUNC(events,globalExec);GVAR(earthquake_nextIntervall)=7*60+(floor(random 3))*60;};),
    []
]
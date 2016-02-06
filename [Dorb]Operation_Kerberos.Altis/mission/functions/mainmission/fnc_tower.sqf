    /*
    Author: Dorbedo

    Description:
        Creates Mission "TOWER".

    Parameter(s):
        0 :    ARRAY - Position

    Returns:
    BOOL
*/
#include "script_component.hpp"
_this params [["_position",[],[[]],[2,3]]];
TRACEV_1(_position);
CHECK(_position isEqualTo [])
/********************
    create Target
********************/
private ["_targets","_spawnposition","_rand","_einheit","_unit"];
_targets=[];
_spawnposition=[];
_rand = ((floor(random 2)) + 1);
for "_i" from 1 to _rand do{
    _einheit = EGVAR(spawn,list_tower) SELRND;
    _spawnposition = [_position,25,200,15,0.15] call EFUNC(common,pos_flatempty);
    If (_spawnposition isEqualTo []) then {
        _spawnposition = [_position,25,200,15,0.22] call EFUNC(common,pos_flatempty);
    };
    If (_spawnposition isEqualTo []) then {
        _spawnposition = [_position,200,0] call EFUNC(common,pos_random);
        _spawnposition = _spawnposition findEmptyPosition [1,100,_einheit];
        if !(_spawnposition isEqualTo []) then {
            _unit = createVehicle [_einheit,_spawnposition, [], 0, "NONE"];
            _unit setVectorUp [0,0,1];
            _targets pushBack _unit;
        };
    }else{
        _unit = createVehicle [_einheit,_spawnposition, [], 0, "NONE"];
        _unit setVectorUp [0,0,1];
        _targets pushBack _unit;
    };    
};
/********************
    godmode
********************/
{
    _x setdamage 0;
    SETVAR(_x,GVAR(target_dead),false);
    _x addEventHandler ["HandleDamage", {_this call EFUNC(common,handledamage_C4);}];
    #ifdef DEBUG_MODE_FULL
        [getPos _x,"TOWER","ColorBlack","hd_destroy"] call EFUNC(common,debug_marker_create);
    #endif
} forEach _targets;

/********************
    taskhandler
********************/

[
    QUOTE(_this params['_targets'];private '_a';_a = {_x getVariable [ARR_2('GVAR(target_dead)',false)];}count _targets;If (_a == (count _targets)) then {true}else{false};),
    [_targets],
    "true"
]
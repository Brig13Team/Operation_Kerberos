    /*
    Author: Dorbedo

    Description:
        Creates Mission "PROTOTYPE".

    Parameter(s):
        0 :    ARRAY - Position

    Returns:
    BOOL
*/
#include "script_component.hpp"
SCRIPT(prototype);
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
    _einheit = EGVAR(spawn,list_prototype) SELRND;
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
    add scriped EH
********************/
GVAR(rescue_counter) = 0;
{
    #ifdef DEBUG_MODE_FULL
        [getPos _x,"PROTOTYPE","ColorBlack","hd_destroy"] call EFUNC(common,debug_marker_create);
    #endif
    [QGVAR(rescuepoint),QUOTE(INC(GVAR(rescue_counter)); {moveout _x}forEach (crew (_this select 0)); uisleep 0.3; deleteVehicle (_this select 0);),_x] call EFUNC(events,addEventHandler);
}forEach _targets;

/********************
    taskhandler
********************/

[
    QUOTE(params['_targets'];private '_a';_a={alive _x}count _targets;If((GVAR(rescue_counter)==count _targets)||(_a==0)) then {true}else{false};),
    [_targets],
    QUOTE(If (GVAR(rescue_counter)>0) then {true}else{false};)
]
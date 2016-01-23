    /*
    Author: Dorbedo

    Description:
        Creates Mission "INTEL".

    Parameter(s):
        0 :    ARRAY - Position

    Returns:
    BOOL
*/
#include "script_component.hpp"
SCRIPT(intel);
_this params [["_position",[],[[]],[2,3]]];
TRACEV_1(_position);
CHECK(_position isEqualTo [])
/********************
    create Target
********************/
private ["_rad","_gebaeudepos_arr","_rand","_targets"];
_targets = [];
_rad = 260;
_gebaeudepos_arr = [];
_gebaeudepos_arr = [_position,_rad] call EFUNC(common,get_buildings);

_rand = 1;

for "_i" from 1 to _rand do{
    private["_einheit","_spawngebaeude","_spawnposition","_unit","_gruppe"];
    _gruppe = createGroup civilian;
    _einheit = EGVAR(spawn,list_intel) SELRND;
    _spawngebaeude = _gebaeudepos_arr SELRND;
    _spawnposition = _spawngebaeude SELRND;
    _unit = [_spawnposition,_gruppe,_einheit] call EFUNC(spawn,unit);
    SETPVAR(_unit,GVAR(istarget),true);
    _targets pushBack _unit;
};
/********************
    manipulate pows
********************/
GVAR(rescue_counter) = 0;
{
    #ifdef DEBUG_MODE_FULL
        [getPos _x,"INTEL","ColorBlack","hd_destroy"] call EFUNC(common,debug_marker_create);
    #endif
    [QGVAR(rescuepoint),QUOTE(INC(GVAR(rescue_counter));),_x] call EFUNC(events,addEventHandler);
}forEach _targets;

/********************
    taskhandler
********************/

[
    QUOTE(params['_targets'];private '_a';_a={alive _x}count _targets;If((GVAR(rescue_counter)==count _targets)||(_a==0)) then {true}else{false};),
    [_targets],
    QUOTE(If (GVAR(rescue_counter)>0) then {true}else{false};)
]
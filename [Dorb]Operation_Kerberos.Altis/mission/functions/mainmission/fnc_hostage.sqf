    /*
    Author: Dorbedo

    Description:
        Creates Mission "POW".

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
private ["_rad","_gebaeudepos_arr","_rand","_targets"];
_targets = [];
_rad = 800;
_gebaeudepos_arr = [];
_gebaeudepos_arr = [_position,_rad] call EFUNC(common,get_buildings);

_rand = ((floor(random 2)) + 2);

for "_i" from 1 to _rand do{
    private["_einheit","_spawngebaeude","_spawnposition","_unit","_gruppe"];
    _gruppe = createGroup civilian;
    _einheit = EGVAR(spawn,list_pow) SELRND;
    _spawngebaeude = _gebaeudepos_arr SELRND;
    _spawnposition = _spawngebaeude SELRND;
    If !(_spawnposition isEqualTo []) then {
        _unit = [_spawnposition,_gruppe,_einheit] call EFUNC(spawn,unit);
        SETPVAR(_unit,GVAR(istarget),true);
        _targets pushBack _unit;
    };
};
/********************
    manipulate pows
********************/
GVAR(rescue_counter) = 0;
{
    _x setCaptive true;
    removeAllAssignedItems _x;
    removeallweapons _x;
    removeHeadgear _x;
    removeBackpack _x;
    _x setunitpos "UP";
    _x setBehaviour "Careless";
    dostop _x;
    _x playmove "amovpercmstpsnonwnondnon_amovpercmstpssurwnondnon";
    _x disableAI "MOVE";
    #ifdef DEBUG_MODE_FULL
        [getPos _x,format["RESCUE %1",(name _x)]] call EFUNC(common,debug_marker_create);
    #endif
    [QGVAR(rescuepoint),QUOTE(INC(GVAR(rescue_counter)); moveOut (_this select 0); uisleep 0.3; deleteVehicle (_this select 0);),_x] call EFUNC(events,addEventHandler);
}forEach _targets;

/********************
    taskhandler
********************/

[
    QUOTE(params['_targets'];private '_a';_a={alive _x}count _targets;If((GVAR(rescue_counter)==count _targets)||(_a==0)) then {true}else{false};),
    [_targets],
    QUOTE(If (GVAR(rescue_counter)>0) then {true}else{false};)
]
    /*
    Author: Dorbedo

    Description:
        Creates Mission "KILL".

    Parameter(s):
        0 :    ARRAY - Position

    Returns:
    BOOL
*/
#include "script_component.hpp"
SCRIPT(kill);
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
    _gruppe = createGroup GVARMAIN(side);
    _einheit = EGVAR(spawn,list_commander) SELRND;
    _spawngebaeude = _gebaeudepos_arr SELRND;
    _spawnposition = _spawngebaeude SELRND;
    _unit = [_spawnposition,_gruppe,_einheit] call EFUNC(spawn,unit);
    SETPVAR(_unit,GVAR(istarget),true);
    SETVAR(_gruppe,GVAR(istarget),true);
    _targets pushBack _unit;
};
/********************
    manipulate pows
********************/
GVAR(rescue_counter) = 0;
{
    _x allowFleeing 0;
    if (isnil (primaryWeapon _x)) then {
        _x addMagazine ["150Rnd_762x51_Box_Tracer",4];
        _x addWeapon "LMG_Zafir_F";
        _x selectWeapon "LMG_Zafir_F";
    };
    #ifdef DEBUG_MODE_FULL
        [getPos _x,format["KILL %1",(name _x)]] call EFUNC(common,debug_marker_create);
    #endif
    _x addEventHandler     ["Killed", 
                            {
                                [{[_this select 0,[format [localize (_this select 1),_this select 2]],_this select 3,_this select 4] spawn EFUNC(interface,disp_info);},[LSTRING(KILL),LSTRING(KILL_KILLED),(name(_this select 0)),"data\icon\icon_target.paa",true],-1] call EFUNC(common,NetEvent);
                            }
                        ];    
}forEach _targets;


/********************
    taskhandler
********************/

[
    QUOTE(params['_targets'];If(({alive _x} count _targets) == 0 ) then {true}else{false};),
    [_targets]
]
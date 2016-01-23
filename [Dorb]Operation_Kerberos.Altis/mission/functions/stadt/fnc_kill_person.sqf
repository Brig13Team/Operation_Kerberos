/*
    Author: Dorbedo

    Description:
    Creates Mission "Kill".
    


    Parameter(s):
        0 :    ARRAY - Position
        1 :    ARRAY - Ziele
        2 : STRING - Aufgabenname für Taskmaster
        
    Returns:
    BOOL
*/
#include "script_component.hpp"
SCRIPT(kill_person);
_this params ["_ort","_position","_task"];
TRACEV_3(_ort,_position,_task);

private["_position_rescue","_target","_gruppe"];

_target=[];

LOG("Kill Commander");

//////////////////////////////////////////////////
////// Gebäudearray erstellen                 /////
//////////////////////////////////////////////////

_rad = 260;
_gebaeudepos_arr = [];
_gebaeudepos_arr = [_position,_rad] call EFUNC(common,get_buildings);

//////////////////////////////////////////////////
////// Ziel erstellen                         /////
//////////////////////////////////////////////////

_rand = ((floor(random 2)) + 2);

for "_i" from 1 to _rand do{
    _gruppe = createGroup dorb_side;
    _einheit = dorb_commanderlist SELRND;
    _spawngebaeude = _gebaeudepos_arr SELRND;
    _spawnposition = _spawngebaeude SELRND;
    _unit = [_spawnposition,_gruppe,_einheit] call EFUNC(spawn,unit);
    SETVAR(_unit,GVAR(istarget),true);
    SETVAR(_gruppe,GVAR(istarget),true);
    _target pushBack _unit;
};

//////////////////////////////////////////////////
////// Ziel bearbeiten                         /////
//////////////////////////////////////////////////

{
    _x allowFleeing 0;
    if (isnil (primaryWeapon _x)) then {
        _x addMagazine ["150Rnd_762x51_Box_Tracer",4];
        _x addWeapon "LMG_Zafir_F";
        _x selectWeapon "LMG_Zafir_F";
    };
    _x addEventHandler     ["Killed", 
                            {
                                [{[_this select 0,[format [localize (_this select 1),_this select 2]],_this select 3,_this select 4] spawn EFUNC(interface,disp_info);},[LSTRING(KILL),LSTRING(KILL_KILLED),(name(_this select 0)),"data\icon\icon_target.paa",true],-1] call EFUNC(common,globalExec);
                            }
                        ];    
}forEach _target;

_name = name(_target select 0);
for "_i" from 1 to ((count _target) - 2) do {
    _name = FORMAT_2("%1, %2",_name,name (_target select _i));
};
_name = FORMAT_2("%1 and %2",_name,name(_target select ((count _target)-1)));

if (dorb_debug) then {
    {
        _mrkr = createMarker [name _x,getPos _x];
        _mrkr setMarkerShape "ICON";
        _mrkr setMarkerColor "ColorBlack";
        _mrkr setMarkerType "hd_destroy";
        
    }forEach _target;
};

//////////////////////////////////////////////////
////// Gegner erstellen                      /////
//////////////////////////////////////////////////

[_position,_gebaeudepos_arr] call EFUNC(spawn,obj_stadt);

//////////////////////////////////////////////////
////// Aufgabe erstellen                      /////
//////////////////////////////////////////////////

[_task,true,[[LSTRING(KILL_TASK_DESC),_name,_ort],LSTRING(KILL_TASK),LSTRING(KILL)],_position,"AUTOASSIGNED",0,false,true,"",true] spawn BIS_fnc_setTask;
[LSTRING(KILL),[LSTRING(KILL_TASK)],"data\icon\icon_target.paa",true] spawn EFUNC(interface,disp_info_global);

//////////////////////////////////////////////////
////// Überprüfung + Ende                      /////
//////////////////////////////////////////////////

["init",_target] spawn FUNC(examine);

#define INTERVALL 10
#define TASK _task
#define CONDITION {_a ={!(alive _x)}count (_this select 0);If (_a == (count _target)) then {true}else{false};}
#define CONDITIONARGS [_target]
#define SUCESSCONDITION {true}
#define ONSUCESS {[LSTRING(KILL),[LSTRING(FINISHED)],"data\icon\icon_target.paa",true]spawn EFUNC(interface,disp_info_global);['destroy'] spawn FUNC(examine);{deleteVehicle _x}forEach (_this select 0);}
#define ONFAILURE {}
#define SUCESSARG [_target]
#define ONLOOP {['check'] spawn FUNC(examine);}
#define ONLOOPARGS [_target]
[INTERVALL,TASK,CONDITION,CONDITIONARGS,SUCESSCONDITION,ONSUCESS,ONFAILURE,SUCESSARG,ONLOOP,ONLOOPARGS] call FUNC(taskhandler);

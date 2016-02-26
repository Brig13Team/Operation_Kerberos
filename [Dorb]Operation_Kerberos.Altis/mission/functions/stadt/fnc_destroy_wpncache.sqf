/*
    Author: Dorbedo

    Description:
    Creates Mission "Destroy Weaponcache".
    


    Parameter(s):
        0 :    ARRAY - Position
        1 :    ARRAY - Ziele
        2 : STRING - Aufgabenname für Taskmaster
        
    Returns:
    BOOL
*/
#include "script_component.hpp"
SCRIPT(destoy_wpncache);
_this params ["_ort","_position","_task"];
TRACEV_3(_ort,_position,_task);

private["_position","_task","_ort","_position_rescue","_a"];

_target=[];

//////////////////////////////////////////////////
////// Gebäudearray erstellen                 /////
//////////////////////////////////////////////////

_rad = 260;
_gebaeudepos_arr = [];
_gebaeudepos_arr = [_position,_rad] call EFUNC(common,get_buildings);

//////////////////////////////////////////////////
////// Ziel erstellen                         /////
//////////////////////////////////////////////////

_rand = ((floor(random 5)) + 8);

for "_i" from 1 to _rand do{
    _einheit = selectRandom dorb_wpncache_list;
    _spawngebaeude = selectRandom _gebaeudepos_arr;
    _spawnposition = selectRandom _spawngebaeude;
    _unit = createVehicle [_einheit,_spawnposition, [], 0, "NONE"];
    _target pushBack _unit;
};
LOG(FORMAT_2("Anzahl Waffenkisten=%1 \n Waffenkisten=%2",_rand,_target));

//////////////////////////////////////////////////
////// Ziel bearbeiten                         /////
//////////////////////////////////////////////////

if (dorb_debug) then {
    _a=1;
    {
        INC(_a);
        _mrkr = createMarker [format ["Box %2-%1",_a,_task],getPos _x];
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

[_task,true,[[LSTRING(DEST_WPN_TASK_DESC),_ort],LSTRING(DEST_WPN_TASK),LSTRING(DESTROY)],_position,"AUTOASSIGNED",0,false,true,"",true] spawn BIS_fnc_setTask;
[LSTRING(DESTROY),[LSTRING(DEST_WPN_TASK)],"data\icon\icon_destroy.paa",true] spawn EFUNC(interface,disp_info_global);

sleep 10;
{
    _x addEventHandler ["killed",{"Bo_Mk82" createVehicle (getpos (_this select 0));}];
}forEach _target;



//////////////////////////////////////////////////
////// Überprüfung + Ende                      /////
//////////////////////////////////////////////////
["init",_target] spawn FUNC(examine);
#define INTERVALL 10
#define TASK _task
#define CONDITION {_a=0;_a = {(!(alive _x))}count (_this select 0);If (_a > ((count _target)-4)) then {true}else{false};}
#define CONDITIONARGS [_target]
#define SUCESSCONDITION {true}
#define ONSUCESS {[LSTRING(DESTROY),[LSTRING(FINISHED)],"data\icon\icon_destroy.paa",true] spawn EFUNC(interface,disp_info_global);['destroy'] spawn FUNC(examine);{deleteVehicle _x}forEach (_this select 0);}
#define ONFAILURE {}
#define SUCESSARG [_target]
#define ONLOOP {['check'] spawn FUNC(examine);}
[INTERVALL,TASK,CONDITION,CONDITIONARGS,SUCESSCONDITION,ONSUCESS,ONFAILURE,SUCESSARG,ONLOOP] call FUNC(taskhandler);

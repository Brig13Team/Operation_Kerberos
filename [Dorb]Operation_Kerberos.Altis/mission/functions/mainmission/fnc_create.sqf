/*
    Author: Dorbedo

    Description:
        creates mainmission

*/
#include "script_component.hpp"
SCRIPT(create);
params[["_task","",[""]],["_centerposition",[],[[]]],["_distance",1000,[0]],["_taskID","",[""]],["_location","",[""]]];
TRACEV_4(_task,_centerposition,_distance,_taskID);
[_centerposition] call EFUNC(headquarter,mission_init);
private _position = [_centerposition,_distance,0] call EFUNC(common,pos_random);
TRACEV_1(_position);
private _taskname = getText(missionconfigfile>>"missions_config">>"main">>_task>>"task">>"name");
private _taskdesc = getText(missionconfigfile>>"missions_config">>"main">>_task>>"task">>"description");
private _tasktype = getText(missionconfigfile>>"missions_config">>"main">>_task>>"task">>"tasktype");
private _taskmark = getText(missionconfigfile>>"missions_config">>"main">>_task>>"task">>"taskmarker");
private _taskpic = getText(missionconfigfile>>"CfgTaskTypes">>_tasktype>>"icon");

TRACEV_5(_position,_taskname,_taskdesc,_tasktype,_taskpic);

private _temp = [_position] call (missionNamespace getVariable [format ["%1_%2",QUOTE(DOUBLES(GVAR(fnc),PART)),_task],{}]);

CHECKRET(isNil "_temp",ERROR(FORMAT_1("Missing Maintask %1",_task));[]);
CHECKRET(_temp isEqualTo [],[]);

private _taskarray = [10,_taskID];
_taskarray append _temp;


///// spawn units

private _isTown = {((_x select 0)==_location)} count GVAR(town);
if (_isTown>0) then{
    [_centerposition,["_town","strikeforce","patrols"]] call EFUNC(spawn,mission);
}else{
    [_centerposition,["strikeforce","patrols"]] call EFUNC(spawn,mission);
    [_centerposition,1200,(floor(random 5)+5)] call EFUNC(spawn,defence_macros);
};
TRACEV_2(_isTown,_location);

//// Task creation
[
    _taskID,
    true,
    [_taskdesc,_taskname,_taskmark],
    _centerposition,
    "AUTOASSIGNED",
    10,
    false,
    true,
    _tasktype
] spawn BIS_fnc_setTask;

/// workaround for localisation on player
private _task_name = localize(format[localize LSTRING(TASKNAME_BLANK),toUpper(_task)]);
private _task_desc = localize(format[localize LSTRING(TASKDESC_BLANK),toUpper(_task)]);
[_task_name,_task_desc] spawn EFUNC(gui,globalmessage);

#ifdef DEBUG_MODE_FULL
    [_centerposition,"CENTERPOS"] call EFUNC(common,debug_marker_create);
    [_position,"MISSIONPOS"] call EFUNC(common,debug_marker_create);
#endif

/// taskhandler & display finished message
if (_taskarray call FUNC(taskhandler)) then {
    [_task_name,LSTRING(FINISHED),"green"] spawn EFUNC(gui,globalmessage);
}else{
    [_task_name,LSTRING(FAILED),"red"] spawn EFUNC(gui,globalmessage);
};

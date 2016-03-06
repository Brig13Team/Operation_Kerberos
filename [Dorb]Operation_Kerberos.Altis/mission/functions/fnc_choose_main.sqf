/*
    Author: Dorbedo
    
    Description:
        Selects Mission
    
    Parameter(s):
        0 : STRING    - TASKID
    
*/
#include "script_component.hpp"
SCRIPT(choose);
params [["_taskID",format["NOTNUMMER%1",random 1000000],[""]]];
TRACEV_1(_taskID);

private _taskarray = [];
private _config = missionconfigfile>>"missions_config">>"main";
for "_i" from 0 to (count _config)-1 do {
    _taskarray pushBack [configname (_config select _i),getNumber((_config select _i)>>"probability")];
};

private _task = ([_taskarray,1] call EFUNC(common,sel_array_weighted))select 0;
TRACEV_2(_taskarray,_task);
/// choose the army
private _armys = getArray(missionconfigfile>>"missions_config">>"main">>_task>>"armys");
private _army = ([_armys,1] call EFUNC(common,sel_array_weighted))select 0;
//[_army] call EFUNC(spawn,army_set);
["regular"] call EFUNC(spawn,army_set);

/// choose the position
private _positiontypes = getArray(missionconfigfile>>"missions_config">>"main">>_task>>"location">>"areas");
private _positions = [];
{
    _positions append (missionnamespace getVariable [_x,[]]);
}forEach _positiontypes;
CHECK(_positions isEqualTo [])
private _position = selectRandom _positions;
private _distance = getnumber(missionconfigfile>>"missions_config">>"main">>_task>>"location">>"distance");

[_task,((_position)select 1)] call FUNC(choose_side);
[_task,((_position)select 1),_distance,_taskID,(_position select 0)] call FUNC(mainmission_create);
LOG("RTB");
//[((_position)select 1),_task] call FUNC(rtb);
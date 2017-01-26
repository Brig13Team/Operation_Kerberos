/*
    Author: iJesuz

    Description:
        Mission "EMP"

    Parameter(s):
        0 : [STRING,ARRAY]  - Destination [Locationname, Position]

    Return:
        [CODE,ARRAY]    -   [Taskhandler conditional function, its arguments]
*/
#include "script_component.hpp"

_this params [["_destination","",[""]],["_position",[],[[]]]];


private _radius = getNumber(missionConfigFile >> "missions_config" >> "main" >> "emp" >> "location" >> "distance");

private _obj = [_position,"emp",_radius] call EFUNC(spawn,createMissionTarget);

[_obj] call FUNC(objects_device_init);

GVAR(last_emp) = CBA_missionTime;

private _intervall = getNumber(missionConfigFile >> "missions_config" >> "main" >> "emp" >> "intervall");
_intervall = _intervall * 60;
[QFUNC(mainmission_emp_cond),[_obj,_intervall]]

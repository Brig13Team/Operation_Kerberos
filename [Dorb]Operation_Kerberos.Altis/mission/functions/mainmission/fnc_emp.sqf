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

_this params [["_destination",["",[0,0,0]],[["",[]]]]];

private _obj = getText(missionConfigFile >> "missions_config" >> "main" >> "emp" >> "object");

private _position = _destination select 1;
private _radius = getNumber(missionConfigFile >> "missions_config" >> "main" >> "emp" >> "location" >> "distance");

_position = [_position,_radius,0] call EFUNC(common,pos_random);
private _tmp = [_position,25,100,15,0.15] call EFUNC(common,pos_flatempty);
if (not _tmp isEqualTo []) then { _position = +_temp; }

private _obj = [_temp,_position] call EFUNC(spawn,temp_spawner);
#ifdef DEBUG_MODE_FULL
    private _marker = createMarker ["DEBUG_EMP_MARKER",_position];
    _marker setMarkerType "hd_dot";
#endif

// TODO: spawn defence units
/*
    ...
*/

GVAR(last_emp) = diag_tickTime;

private _intervall = getNumber(missionConfigFile >> "missions_config" >> "main" >> "emp" >> "intervall");
_intervall = _intervall * 60000;
["dorb_mission_fnc_mainmission_emp_cond",[_obj,_intervall]]

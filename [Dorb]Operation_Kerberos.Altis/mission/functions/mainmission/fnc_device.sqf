/*
    Author: iJesuz

    Description:
        Mission "Device"

    Parameter(s):
        0 : [STRING,ARRAY]  - Destination [Locationname, Position]

    Return:
        [CODE,ARRAY]    -   [Taskhandler conditional function, its arguments]
*/
#include "script_component.hpp"

_this params [["_destination",["",[0,0,0]],[["",[]]]]];

private _class = getText(missionConfigFile >> "missions_config" >> "main" >> "device" >> "object");

private _position = _destination select 1;
private _radius = getNumber(missionConfigFile >> "missions_config" >> "main" >> "device" >> "location" >> "distance");

private _obj = [_destination,_radius] call EFUNC(spawn,mission_device);

/*
private _tmp = [_position,25,_radius,300,15,0.15] call EFUNC(common,pos_randomFlatEmpty);
if (not (_tmp isEqualTo [])) then { _position = +_tmp; };

private _obj = [_class,_position] call EFUNC(spawn,temp_spawner);
#ifdef DEBUG_MODE_FULL
    private _marker = createMarker ["DEBUG_DEVICE_MARKER",_position];
    _marker setMarkerType "hd_dot";
#endif
*/
// TODO: spawn defence units
/*
    ...
*/

GVAR(last_earthquake) = CBA_missionTime;

private _intervall = getNumber(missionConfigFile >> "missions_config" >> "main" >> "device" >> "intervall");
_intervall = _intervall * 60;
[QFUNC(mainmission_device_cond),[_obj,_intervall]]
//["dorb_mission_fnc_mainmission_device_cond",[_obj,_intervall]]

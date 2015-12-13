    /*
    Author: Dorbedo

    Description:
        Creates Side-Mission "convoi".

    Parameter(s):
        0 :    ARRAY - Position

    Returns:
    BOOL
*/
#include "script_component.hpp"
SCRIPT(convoi);
_this params [["_position",[],[[]],[2,3]],["_positionMain",[],[[]]],[2,3]];
TRACEV_1(_position);
private ["_startPosition","_transporttype","_spawnpos"];
/********************
    create convoi
********************/
_transporttype = GVAR(list_veh_mechanized) SELRND;
_spawnpos = _position findEmptyPosition [1,200,_transporttype];

if (_spawnpos isEqualTo []) exitWith {[]};
private ["_return"];
_return = [_spawnpos,GVARMAIN(side),_transporttype,0,true] call EFUNC(spawn,vehicle);
_return params ["_transportergroup","_transportervehicle"];
_return = [_transportervehicle,_transportergroup,true] call EFUNC(spawn,crew);
private ["_attackgroup"];
_attackgroup = _return select 1;
/********************
    send convoi
********************/
_transportergroup addWaypoint [_positionMain,50];
_transportervehicle doMove _positionMain;


/********************
    taskhandler
********************/

[
    QUOTE((((_this select 0)distance(_this select 1)) < 400)||(!(canMove (_this select 0)))),
    [_transportervehicle,_positionMain],
    QUOTE(canMove (_this select 0)),
    {},
    QUOTE({unassignVehicle (_x);_x allowDamage false;moveOut _x;uisleep 0.3;_x allowDamage true;}forEach (units (_this select 2));[_this select 1] call EFUNC(headquater,register_Group);[_this select 2] call EFUNC(headquater,register_Group);),
    [_transportervehicle,_transportergroup,_attackgroup]    
]
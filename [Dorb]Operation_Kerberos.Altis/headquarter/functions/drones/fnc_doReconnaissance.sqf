/*
    Author: iJesuz

    Description:

    Parameter(s):
        0 : OBJECT - drone
        1 : ARRAY/OBJECT - position or target object

    Retruns:
        BOOLEAN

*/
#include "script_component.hpp"
SCRIPT(doReconnaissance);

params ["_target",["_caller",objNull,[objNull]],["_func",{},[{}]]];
private ["_drone","_rdrones","_scan_radius","_pos","_wp_type","_dir","_height","_posBegin","_radius","_onExit"];

_onExit = {
    GVAR(drones_availableReconDrones) pushback (typeOf _this);
    deleteVehicle _this;
};

_rdrones = GVAR(drones_availableReconDrones);
if (count _rdrones == 0) exitWith { false };

_drone = _rdrones select (count _rdrones - 1);
_rdrones resize (count _rdrones - 1);
GVAR(drones_availableReconDrones) = _rdrones;

_drone = createVehicle [_drone,[0,0,2000],[],0,"FLY"];
createVehicleCrew _drone;

if (!isNumber(missionConfigFile >> "drones" >> typeOf _drone >> "scan_radius")) exitWith { _drone call _onExit; false };

_scan_radius = getNumber(missionConfigFile >> "drones" >> typeOf _drone >> "scan_radius");
_wp_type = getText (missionConfigFile >> "drones" >> typeOf _drone >> "scan_waypoint");
if (_wp_type == "LOITER") then {
    _radius = getNumber (missionConfigFile >> "drones" >> typeOf _drone >> "waypoints" >> _wp_type >> "radius");
} else {
    _radius = 0;
};

if (typeName _target == "OBJECT") then { _pos = getPos _target; };
if ((typeName _target == "ARRAY") && {count _target == 3}) then { _pos = _target; };

_dir = random 360;
_height = getNumber (missionConfigFile >> "drones" >> typeOf _drone >> "waypoints" >> _wp_type >> "height");
_posBegin = [(_pos select 0) - ((sin _dir) * 1000), (_pos select 1) - ((cos _dir) * 1000), _height];

_drone setPos _posBegin;
_drone setDir (_dir + 180);
if (!([_drone,_wp_type,_pos] call FUNC(drones_createWaypoint))) exitWith { _drone call _onExit; false };

while { (((waypointPosition (waypoints _drone select 0)) distance2D _drone) >= (_radius + 50)) } do {
    uiSleep 1;
    ((waypointPosition (waypoints _drone select 0)) distance2D _drone) call BIS_fnc_log;
};

if (isNull _drone) exitWith { _drone call _onExit; false };
uiSleep 30;
if (isNull _drone) exitWith { _drone call _onExit; false };
_ret = [_drone,_pos] call FUNC(drones_scan);

[_ret,_caller,_target] spawn _func;

uiSleep 30;

if(isNull _drone) exitWith { _drone call _onExit; false };
if (!([_drone,"MOVE",_posBegin] call FUNC(drones_createWaypoint))) exitWith { _drone call _onExit; false };

while { ((waypointPosition (waypoints _drone select 0)) distance2D _drone) >= 50 } do {
    uiSleep 1;
};

_drone call _onExit;

true

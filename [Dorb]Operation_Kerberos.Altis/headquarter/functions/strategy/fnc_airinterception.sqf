/*
    Author: Dorbedo
    
    Description:
        revon
    
    Parameter(s):
        none

    Returns:
        none
*/
#include "script_component.hpp"
_this params ["_currentLocation"];

private _currentPos = getPos _currentLocation;
private _currentTroops = _currentLocation getVariable [QGVAR(troopsSend),0];
private _spawnpos = [_currentPos,6000,2] call EFUNC(common,random_pos);
CHECKRET((_spawnpos isEqualTo []),_currentTroops);

GVAR(callIn_airinterception) = GVAR(callIn_airinterception) - 1;
private _allPlanes = getNumber(missionconfigfile >> "unitlists" >> str GVARMAIN(side) >> GVARMAIN(side_type)>> "callIn" >> "airinterception" >> "units");
private _plane = selectRandom _allPlanes;
_spawnpos set [2,3000];
_dir = [_spawnpos, _currentPos] call BIS_fnc_dirTo;

([_spawnpos,GVARMAIN(side),_plane,_dir,true,true,"FLY"] call EFUNC(spawn,vehicle)) params ["_planeGroup","_plane"];

_plane flyInHeight 600;
private _wp = _planeGroup addWaypoint [_currentPos, 0];
_wp setWaypointLoiterType "CIRCLE";
_wp setWaypointLoiterRadius 800;
_wp setWaypointBehaviour "SAD";
_wp setWaypointTimeout [300,400,500];
_wp = _planeGroup addWaypoint [_spawnpos, 0];
[_plane] spawn {
    SCRIPTIN(strategy_airinterception_refuel);
    params["_plane"];
    while {alive _plane} do {
        _plane setfuel 1;
        _plane setVehicleAmmo 1;
        sleep 500;
    };
};
[_plane,_spawnpos] spawn {
    SCRIPTIN(strategy_airinterception_reset);
    params ["_plane","_spawnpos"];
    uisleep 60;
    while {(alive _plane) && ((_plane distance2D _spawnpos)<500)} do {
        uisleep 5;
    };
    If (alive _plane) then {
        GVAR(callIn_airinterception) = GVAR(callIn_airinterception) + 1;
    };
};
([_planeGroup] call FUNC(strength_ai)) params ["_type","_cost","_threat"];
_currentTroops - _cost;
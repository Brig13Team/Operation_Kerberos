/*
 *  Author: Dorbedo
 *
 *  Description:
 *      spawns the sidemission (called with delay via CBA_fnc_waitAndExecute)
 *
 *  Parameter(s):
 *      0 : CONFIG - sidemissionconfig
 *      1 : STRING - type of mainmission
 *      2 : ARRAY - Location of the Mainmission
 *      3 : SCALAR - ID of Mainmission
 *
 *  Returns:
 *      [TYPE] - [return name]
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [
    ["_SideCfg",configNull,[configNull]],
    ["_MainType","",[""]],
    ["_MainLocation",[],[[]]],
    ["_ParentID",-1,[]]
];

CHECK((isNull _SideCfg)||(_MainLocation isEqualTo [])||(_ParentID < 0))

If !([_ParentID] call FUNC(taskmanager_exists)) exitWith {
    ERROR("Maintask not found");
};

private _spawnFnc = getText(_SideCfg >> "spawn_fnc");
private _posTypes = getArray (_SideCfg >> "location" >> "areas");
private _taskFnc = getText(_SideCfg >> "task_fnc");
private _taskDelay = getNumber(_SideCfg >> "task_delay");
private _showTaskMarker = getNumber(_SideCfg >> "markerOnSpot");


private _chosenLocation = [];

If (_posTypes isEqualTo []) then {
    _chosenLocation = _MainLocation;
}else{
    private _allLocations = [];
    {
        private _var = missionNamespace getVariable [_x,[]];
        _allLocations append _var;
    } forEach _posTypes;
    _possibleLocations = _possibleLocations - _MainLocation;
    private _area_distanceMin = getNumber(_SideCfg >> "location" >> "areas_minDistance");
    private _area_distanceMax = getNumber(_SideCfg >> "location" >> "areas_maxDistance");
    private _possibleLocations = [];
    {
        private _distance = (_x select 1) distance2D (_MainLocation select 1);
        If ((_distance >= _area_distanceMin)&&(_distance <= _area_distanceMax)) then {
            _possibleLocations pushBack _x;
        };
    } forEach _allLocations;
    _chosenLocation = selectRandom _possibleLocations;
};

private _distance = getNumber(_SideCfg >> "location" >> "distance");
private _parameter = [_chosenLocation,_distance] call (missionNamespace getVariable [_spawnFnc,{[]}]);
private _taskType = getText(_SideCfg >> "type");

If !(_showTaskMarker) then {
    _chosenLocation = ["",nil];
};


[
    LINKFUNC(taskmanager_addChild),
    [_taskType,_ParentID,_chosenLocation,(missionNamespace getVariable [_taskFnc,{true}]),_parameter],
    _taskDelay
] call CBA_fnc_waitAndExecute;

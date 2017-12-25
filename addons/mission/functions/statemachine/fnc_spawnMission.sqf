/**
 * Author: Dorbedo
 * spawns the missionobjects
 *
 * Arguments:
 * 0: <LOCATION> the mission
 *
 * Return Value:
 * Nothing
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_mission"];

 // if the spawning is not finished after 10 Minutes, we stop the mission
_mission setVariable ["spawntimeout",CBA_missiontime + 10*60];

// we move the spawning outside the sheduled environment, adding a delay to reduce the network peaks
private _type = _mission getVariable "type";
private _centerpos = _mission getVariable "centerpos";
private _spawnFunction = _mission getVariable ["spawnfunction",""];
private _missionCfg = _mission getVariable "missioncfg";

private _objects = [];
If (_spawnFunction isEqualTo "") then {
    _objects = [_type,_centerpos,_missionCfg] call FUNC(spawn_spawnTargets);

    private _objectsfunction = getText(_missionCfg >> "objective" >> "objectsfunction");
    [_mission, _objects] call (missionNamespace getVariable [_objectsfunction, {}]);

    _objects = _objects - [objNull];
    {
        _x setVariable [QGVAR(mission),_mission];
    } forEach _objects;
    _mission setVariable ["objects",_objects];
}else{
    _objects = [_centerpos,_mission] call (missionNamespace getVariable [_spawnFunction,{}]);

    // remove wrong spawned objects (0,0,0) or ATL
    _objects = _objects - [objNull];
    //_objects = _objects select {((getPos _x) distance2D [0,0,0])>10};

    {
        _x setVariable [QGVAR(mission),_mission];
    } forEach _objects;
    _mission setVariable ["objects",_objects];
    TRACEV_2(_objects,_type);
};

// the spawning has been finished, next state
_mission setVariable ["spawningfinished",true];

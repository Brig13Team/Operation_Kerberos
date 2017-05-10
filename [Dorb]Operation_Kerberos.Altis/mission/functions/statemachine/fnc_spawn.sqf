/*
 *  Author: iJesuz, Dorbedo
 *
 *  Description:
 *      ends a mission
 *
 *  Parameter(s):
 *      0 : LOCATION - the last MainMission
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params ["_mission"];

 // if the spawning is not finished after 10 Minutes, we stop the mission
_mission setVariable ["spawntimeout",CBA_missiontime + 10*60];

_mission spawn {
    _this params ["_mission"];
    // we move the spawning outside the sheduled environment, adding a delay to reduce the network peaks
    private _type = _mission getVariable "type";
    private _centerpos = _mission getVariable "centerpos";
    private _mainOrSide = If (isNull(_mission getVariable ["parent",locationNull])) then {"main"}else{"side"};

    private _objects = [_type,_centerpos,_mainOrSide] call FUNC(spawn_spawnTargets);

    If (_mainOrSide == "side") then {
        [_mission] call FUNC(statemachine_addSide);
    };



    // remove wrong spawned objects (0,0,0) or ATL
    _objects = _objects select {
        ((getPosATL _x) select 2 >= 0))&&
        {((getPos _x) distance2D [0,0,0])<10}
    };

    _mission setVariable ["objects",_objects];
    // the spawning has been finished, next state
    _mission setVariable ["spawningfinished",true];

};

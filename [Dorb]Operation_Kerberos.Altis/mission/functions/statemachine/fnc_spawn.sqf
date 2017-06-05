/*
 *  Author: iJesuz, Dorbedo
 *
 *  Description:
 *      spawns the missionobjects
 *
 *  Parameter(s):
 *      0 : LOCATION - the Mission
 *
 *  Returns:
 *      none
 *
 */
#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params ["_mission"];

 // if the spawning is not finished after 10 Minutes, we stop the mission
_mission setVariable ["spawntimeout",CBA_missiontime + 12*60];

_mission spawn {
    _this params ["_mission"];
    // we move the spawning outside the sheduled environment, adding a delay to reduce the network peaks
    private _type = _mission getVariable "type";
    private _centerpos = _mission getVariable "centerpos";
    private _mainOrSide = If (_mission getVariable ["isMain",true]) then {"main"}else{"side"};
    TRACEV_3(_type,_centerpos,_mainOrSide);
    private _spawnFunction = _mission getVariable ["spawnfunction",""];
    private _missionCfg = _mission getVariable "missioncfg";
    TRACEV_2(_spawnFunction,_missionCfg);

    private _objects = [];
    If (_spawnFunction isEqualTo "") then {
        _objects = [_type,_centerpos,_missionCfg] call FUNC(spawn_spawnTargets);

        If (_mainOrSide == "main") then {
            [_mission] call FUNC(statemachine_addSide);
            private _objectsfunction = getText(_missionCfg >> "objective" >> "objectsfunction");
            TRACEV_1(_objectsfunction);
            [_mission, _objects] call (missionNamespace getVariable [_objectsfunction, {}]);
        }else{
            private _objectsfunction = getText(_missionCfg >> "objective" >> "objectsfunction");
            [_mission, _objects] call (missionNamespace getVariable [_objectsfunction, {}]);
        };
        TRACEV_1(_objects);
        // remove wrong spawned objects (0,0,0) or ATL
        _objects = _objects - [objNull];
        _objects = _objects select {
            (((getPosATL _x) select 2) >= 0)&&
            {((getPos _x) distance2D [0,0,0])>10}
        };

        {
            _x setVariable [QGVAR(mission),_mission];
        } forEach _objects;
        _mission setVariable ["objects",_objects];
        TRACEV_1(_objects);
    }else{
        _objects = [_centerpos,_mission] call (missionNamespace getVariable [_spawnFunction,{}]);

        // remove wrong spawned objects (0,0,0) or ATL
        _objects = _objects - [objNull];
        _objects = _objects select {
            (((getPosATL _x) select 2) >= 0)&&
            {((getPos _x) distance2D [0,0,0])>10}
        };

        {
            _x setVariable [QGVAR(mission),_mission];
        } forEach _objects;
        _mission setVariable ["objects",_objects];
    };

    If (_mainOrSide == "main") then {
        // if the spawning of units errors out, the mission will still stay playable
        [
            {
                (_this select 0) setVariable ["spawningfinished",true];
            },
            [_mission],
            10*60
        ] call CBA_fnc_waitAndExecute;
        // spawn the big part of the units
        [_centerpos] call EFUNC(spawn,createMission);
        TRACEV_1(GVAR(CompositionDesigners));
        GVAR(CompositionDesigners) = GVAR(CompositionDesigners) arrayIntersect GVAR(CompositionDesigners);
        [QGVAR(showCompositionDesigners),[GVAR(CompositionDesigners)]] call CBA_fnc_globalEvent;
        GVAR(CompositionDesigners) = [];
    };
    // the spawning has been finished, next state
    _mission setVariable ["spawningfinished",true];

};

/*
 *  Author: Dorbedo
 *
 *  Description:
 *      triangulates
 *
 *  Parameter(s):
 *      0 : [TYPE] - [argument name]
 *
 *  Returns:
 *      [TYPE] - [return name]
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

#define TRIANGULATION_DISTANCE 2000

_this params ["_target","_caller"];

// get the closest Objects
private _allObjects = allMissionObjects "Land_DataTerminal_01_F";
TRACEV_2(_allObjects,_target);
_allObjects = _allObjects - [_target];

_allObjects = _allObjects select {
    // only close Terminals
    ((_x distance2D _target) < TRIANGULATION_DISTANCE)&&
    // they have to have their antenna active
    ((_x animationSourcePhase "Antenna_source")>=3)
};
TRACEV_1(_allObjects);
If ((count _allObjects)<2) exitWith {
    [LSTRING(TRIANGULATE_MISSING_MSG_TITLE),LSTRING(TRIANGULATE_MISSING_MSG)] call EFUNC(gui,Message);
};

private _objectSortArray = [];
{
    _objectSortArray pushBack [_target distance2D _x,_x];
} forEach _allObjects;

_objectSortArray sort true;
private _checker = [_target,(_objectSortArray select 0) select 1,(_objectSortArray select 1) select 1];
private _checkerPositions = [_target,(_objectSortArray select 0) select 1,(_objectSortArray select 1) select 1];
private _allMissionTargets = missionNamespace getVariable [QEGVAR(mission,targets_client),[]];

[
    15,
    [_checker,_checkerPositions,_allMissionTargets],
    {
        [_args select 0,_args select 2] spawn FUNC(effectTriangulation);
    },
    {
        [LSTRING(TRIANGULATE_MOVED_MSG_TITLE),LSTRING(TRIANGULATE_MOVED_MSG)] call EFUNC(gui,Message);
    },
    localize LSTRING(DATATERMINAL_TRIANGULATING),
    {
        private _check = true;
        {
            If ((_x distance ((_args select 1) select _forEachIndex))>5) then {
                TRACEV_2(_args,_x distance ((_args select 1) select _forEachIndex));
                _check = false;
            };
        } forEach (_args select 0);
        _check
    }
] call ace_common_fnc_progressBar;

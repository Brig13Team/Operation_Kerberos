/*
 *  Author: Dorbedo
 *
 *  Description:
 *      [Description]
 *
 *  Parameter(s):
 *      0 : [TYPE] - [argument name]
 *
 *  Returns:
 *      [TYPE] - [return name]
 *
 */
#define DEBUG_MODE_OFF
#include "script_component.hpp"
#define BLINK_TIME 30

_this params ["_checker","_possibleTargets"];
TRACEV_2(_checker,_possibleTargets);
// triangulate
_checker = _checker apply {If (IS_OBJECT(_x)) then {getPos _x}else{_x};};
_possibleTargets = _possibleTargets apply {
    If (IS_OBJECT(_x)) then {
        // ignore the already disabled targets
        If ((_x getVariable [QEGVAR(mission,isActive),true])&&(alive _x)) then {
            getPos _x;
        }else{
            objNull;
        };
    }else{
        _x;
    };
};

_possibleTargets = _possibleTargets - [objNull];

private _triangulatedTargets = [_checker,_possibleTargets] call FUNC(triangulate);
TRACEV_3(_triangulatedTargets,_checker,_possibleTargets);
// show the effect local

If (isNil QGVAR(obj_triangulationMarker)) then {GVAR(obj_triangulationMarker) = [];};

{
    private _initsize = ((_x distance (_checker select 0)) min (_x distance (_checker select 1)) min (_x distance (_checker select 2)) max 150);
    private _pos = [_x,140] call EFUNC(common,pos_random);
    private _markName = format[QGVAR(obj_triangulationMarker_%1),_forEachIndex];
    private _mark = createMarkerLocal [_markName, _pos];
    TRACEV_3(_initsize,_pos,_mark);
    _mark setMarkerShapeLocal "ELLIPSE";
    _mark setMarkerColorLocal "ColorRed";
    _mark setMarkerBrushLocal "Border";
    _mark setMarkerSizeLocal [_initsize,_initsize];
    GVAR(obj_triangulationMarker) pushBack _mark;
} forEach _triangulatedTargets;

#ifdef DEBUG_MODE_FULL
    // mark the triangle of the devices
    GVAR(obj_triangulationMarker2) = [];
    TRACEV_3(_triangulatedTargets,_checker select 0,_checker select 1);
    GVAR(obj_triangulationMarker2) append ([_checker select 0,_checker select 1,-0.2] call BIS_fnc_markerpath);
    GVAR(obj_triangulationMarker2) append ([_checker select 1,_checker select 2,-0.2] call BIS_fnc_markerpath);
    GVAR(obj_triangulationMarker2) append ([_checker select 2,_checker select 0,-0.2] call BIS_fnc_markerpath);
#endif
[
    {
        _this params ["_startTime","_handle"];

        If ((_startTime + BLINK_TIME)< CBA_missiontime) exitWith {
            [_handle] call CBA_fnc_removePerFrameHandler;
            disableSerialization;
            {deleteMarkerLocal _x;}forEach GVAR(obj_triangulationMarker);
            GVAR(obj_triangulationMarker) = [];
            #ifdef DEBUG_MODE_FULL
                {deleteMarkerLocal _x;}forEach GVAR(obj_triangulationMarker2);
                GVAR(obj_triangulationMarker2) = [];
            #endif
        };
        {
            private _size = (((getMarkerSize _x) select 0) * 0.997) max 80;
            _x setMarkerSizeLocal [_size,_size];
        } forEach GVAR(obj_triangulationMarker);
    },
    0.1,
    CBA_missiontime
] call CBA_fnc_addPerFrameHandler;

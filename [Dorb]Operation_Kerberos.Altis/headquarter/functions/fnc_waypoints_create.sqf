/*
    Author: Dorbedo
    
    Description:
        creates waypoints
    
    Parameter(s):
        none

    Returns:
        none
*/
#include "script_component.hpp"
_this params[
    ["_startposition",[],[[]]]
    ];
#define DEBUG_MODE_FULL
ISNILS(GVAR(waypoints),[]);

{deleteVehicle _x;}forEach GVAR(waypoints);

#define RASTER 500
#define DIAGONALMULTI 1

#ifdef DEBUG_MODE_FULL
    //#define MARKER_WAYPOINT
    //#define MARKER_MOVEMENTCOST
#endif
//GVAR(definitions)
//GVAR(centerpos)
private ["_startX","_startY","_waypoints","_endX","_endY"];
_startX = (GVAR(centerpos) select 0) - (GVAR(definitions) select 0);
_startY = (GVAR(centerpos) select 1) - (GVAR(definitions) select 0);
_endX = _startX + (GVAR(definitions) select 0)*2;
_endY = _startY + (GVAR(definitions) select 0)*2;

_waypoints = [];
/// create the Waypoints and register them
for "_i" from _startX to _endX step RASTER do {
    for "_j" from _startY to _endY step RASTER do {
        private ["_unit","_position","_temp"];
        _position = [_i,_j,0];
        //_position = [_startX + ((GVAR(definitions) select 1) * _i),_startX + ((GVAR(definitions) select 1) * _j),0];
        _unit = "Logic" createVehicleLocal _position;
        _waypoints pushBack _unit;
        
        _unit setVariable [QGVAR(WP_DANGER),0];
        _unit setVariable [QGVAR(WP_XP),[objNull,0]];
        _unit setVariable [QGVAR(WP_YP),[objNull,0]];
        _unit setVariable [QGVAR(WP_XM),[objNull,0]];
        _unit setVariable [QGVAR(WP_YM),[objNull,0]];
        _unit setVariable [QGVAR(WP_XMYM),[objNull,0]];
        _unit setVariable [QGVAR(WP_XPYM),[objNull,0]];
        _unit setVariable [QGVAR(WP_XMYP),[objNull,0]];
        _unit setVariable [QGVAR(WP_XPYP),[objNull,0]];
        
        _temp = [(_i - RASTER),(_j),0] nearestObject "Logic";
        If !(isNull _temp) then {
            _temp setVariable [QGVAR(WP_XP),[_unit,0]];
            _unit setVariable [QGVAR(WP_XM),[_temp,0]];
        };
        
        _temp = [(_i),(_j - RASTER),0] nearestObject "Logic";
        If !(isNull _temp) then {
            _temp setVariable [QGVAR(WP_YP),[_unit,0]];
            _unit setVariable [QGVAR(WP_YM),[_temp,0]];
        };
        
        _temp = [(_i - RASTER),(_j + RASTER),0] nearestObject "Logic";
        If !(isNull _temp) then {
            _temp setVariable [QGVAR(WP_XMYP),[_unit,0]];
            _unit setVariable [QGVAR(WP_XPYM),[_temp,0]];
        };
        
        _temp = [(_i - RASTER),(_j - RASTER),0] nearestObject "Logic";
        If !(isNull _temp) then {
            _temp setVariable [QGVAR(WP_XPYP),[_unit,0]];
            _unit setVariable [QGVAR(WP_XMYM),[_temp,0]];
        };
    };
};

{
    private ["_nearestRoad","_currentWP"];
    _currentWP = _x;
    _nearestRoad = [getPos _currentWP,150,[]] call BIS_fnc_nearestRoad;
    
    if !(isNull _nearestRoad) then {
        _currentWP setPos (getPos _nearestRoad);
    }else{
        _nearestPos = selectBestPlaces [getPos _x,150,"meadow",30,1];
        If ((!IS_ARRAY(_nearestPos select 0))||{((((_nearestPos select 0)select 0) isEqualTo [])||(surfaceIsWater ((_nearestPos select 0)select 0)))}) then {
            _temp = _currentWP getVariable [QGVAR(WP_XP),[]];
            if !(isNull (_temp select 0)) then {
                (_temp select 0) setVariable [QGVAR(WP_XM),[objNull,0]];
            };
            _temp = _currentWP getVariable [QGVAR(WP_YP),[]];
            if !(isNull (_temp select 0)) then {
                (_temp select 0) setVariable [QGVAR(WP_YM),[objNull,0]];
            };
            _temp = _currentWP getVariable [QGVAR(WP_XM),[]];
            if !(isNull (_temp select 0)) then {
                (_temp select 0) setVariable [QGVAR(WP_XP),[objNull,0]];
            };
            _temp = _currentWP getVariable [QGVAR(WP_YM),[]];
            if !(isNull (_temp select 0)) then {
                (_temp select 0) setVariable [QGVAR(WP_YP),[objNull,0]];
            };
            
            _temp = _currentWP getVariable [QGVAR(WP_XMYM),[]];
            if !(isNull (_temp select 0)) then {
                (_temp select 0) setVariable [QGVAR(WP_XPYP),[objNull,0]];
            };
            _temp = _currentWP getVariable [QGVAR(WP_XPYP),[]];
            if !(isNull (_temp select 0)) then {
                (_temp select 0) setVariable [QGVAR(WP_XMYM),[objNull,0]];
            };
            _temp = _currentWP getVariable [QGVAR(WP_XMYP),[]];
            if !(isNull (_temp select 0)) then {
                (_temp select 0) setVariable [QGVAR(WP_XPYM),[objNull,0]];
            };
            _temp = _currentWP getVariable [QGVAR(WP_XPYM),[]];
            if !(isNull (_temp select 0)) then {
                (_temp select 0) setVariable [QGVAR(WP_XMYP),[objNull,0]];
            };
            deleteVehicle _currentWP;
        }else{
            _currentWP setPos ((_nearestPos select 0)select 0);
        };
    };
} forEach _waypoints;

_waypoints = _waypoints - [objNull];




{
    private ["_temp","_value"];
    _temp = _x getVariable [QGVAR(WP_XP),[objNull,0]];
    if !(isNull (_temp select 0)) then {
        _value = [getPos _x,getPos (_temp select 0)] call FUNC(waypoints_movementcost);
        _x setVariable [QGVAR(WP_XP),[_temp select 0,_value]];
        (_temp select 0) setVariable [QGVAR(WP_XM),[_x,_value]];
        
#ifdef MARKER_MOVEMENTCOST        
        private ["_position","_dir"];
        //_position = [[getPos _x,getPos (_temp select 0)]] call EFUNC(common,positionsMean);
        _position = [[(getPos _x)select 0,(getPos (_temp select 0))select 0] call BIS_fnc_arithmeticMean,[(getPos _x)select 1,(getPos (_temp select 0))select 1] call BIS_fnc_arithmeticMean,0];
        _dir = [_x,(_temp select 0)] call BIS_fnc_relativeDirTo;
        [_position,format["%1",_value],"ColorGreen","mil_arrow2",_dir] call EFUNC(common,debug_marker_create);
#endif        
    };
    _temp = _x getVariable [QGVAR(WP_YP),[objNull,0]];
    if !(isNull (_temp select 0)) then {
        _value = [getPos _x,getPos (_temp select 0)] call FUNC(waypoints_movementcost);
        _x setVariable [QGVAR(WP_YP),[_temp select 0,_value]];
        (_temp select 0) setVariable [QGVAR(WP_YM),[_x,_value]];
#ifdef MARKER_MOVEMENTCOST
        private ["_position","_dir"];
        //_position = [[getPos _x,getPos (_temp select 0)]] call EFUNC(common,positionsMean);
        _position = [[(getPos _x)select 0,(getPos (_temp select 0))select 0] call BIS_fnc_arithmeticMean,[(getPos _x)select 1,(getPos (_temp select 0))select 1] call BIS_fnc_arithmeticMean,0];
        _dir = [_x,(_temp select 0)] call BIS_fnc_relativeDirTo;
        [_position,format["%1",_value],"ColorBlue","mil_arrow2",_dir] call EFUNC(common,debug_marker_create);
#endif
    };
    _temp = _x getVariable [QGVAR(WP_XPYP),[objNull,0]];
    if !(isNull (_temp select 0)) then {
        _value = [getPos _x,getPos (_temp select 0)] call FUNC(waypoints_movementcost);
        _value = _value * DIAGONALMULTI;
        _x setVariable [QGVAR(WP_XPYP),[_temp select 0,_value]];
        (_temp select 0) setVariable [QGVAR(WP_XMYM),[_x,_value]];
#ifdef MARKER_MOVEMENTCOST        
        private ["_position","_dir"];
        //_position = [[getPos _x,getPos (_temp select 0)]] call EFUNC(common,positionsMean);
        _position = [[(getPos _x)select 0,(getPos (_temp select 0))select 0] call BIS_fnc_arithmeticMean,[(getPos _x)select 1,(getPos (_temp select 0))select 1] call BIS_fnc_arithmeticMean,0];
        _dir = [_x,(_temp select 0)] call BIS_fnc_relativeDirTo;
        [_position,format["%1",_value],"ColorOrange","mil_arrow2",_dir] call EFUNC(common,debug_marker_create);
#endif        
    };
    _temp = _x getVariable [QGVAR(WP_XMYP),[objNull,0]];
    if !(isNull (_temp select 0)) then {
        _value = [getPos _x,getPos (_temp select 0)] call FUNC(waypoints_movementcost);
        _value = _value * DIAGONALMULTI;
        _x setVariable [QGVAR(WP_XMYP),[_temp select 0,_value]];
        (_temp select 0) setVariable [QGVAR(WP_XPYM),[_x,_value]];
#ifdef MARKER_MOVEMENTCOST        
        
        private ["_position","_dir"];
        //_position = [[getPos _x,getPos (_temp select 0)]] call EFUNC(common,positionsMean);
        _position = [[(getPos _x)select 0,(getPos (_temp select 0))select 0] call BIS_fnc_arithmeticMean,[(getPos _x)select 1,(getPos (_temp select 0))select 1] call BIS_fnc_arithmeticMean,0];
        _dir = [_x,(_temp select 0)] call BIS_fnc_relativeDirTo;
        [_position,format["%1",_value],"ColorPink","mil_arrow2",_dir] call EFUNC(common,debug_marker_create);
#endif        
    };
}forEach _waypoints;

#ifdef MARKER_WAYPOINT
{
    private ["_position","_value"];
    _position = getPos _x;
    _value = _x getVariable [QGVAR(WP_DANGER),0];
    [_position,format["%1",_value]] call EFUNC(common,debug_marker_create);
    
} forEach _waypoints;
#endif



GVAR(waypoints) = _waypoints;
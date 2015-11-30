/*
	Author: Dorbedo
	
	Description:
		generates waypoints
	
	Parameter(s):
		none

	Returns:
		none
*/
#include "script_component.hpp"
SCRIPT(waypoints_generate);
_this params[
	["_start",[],[[],objNull]],
	["_target",[],[[],objNull]]
	];

_nearestLogic = {
	private ["_logics","_temp","_return"];
	_logics = _this nearObjects ["Logic",500];
	_return = objNull;
	{
		if ((_this distance2D _x)<(_return distance2D _this) )then {
			_return = _x;
		};
	}forEach _logics;
	_return;
};
_startLogic = _start call _nearestLogic;
_targetLogic = _target call _nearestLogic;	
If (_startLogic == _targetLogic) exitWith {
	[_start,_target]
};

#undef DEBUG_MODE_FULL

_counter = 0;
_active = true;
_waypointsActivated = [[0,floor((_startLogic distance2D _targetLogic)/10),0,_startLogic]];
_waypointsDeactivated = [];

while {_active} do {
	
	TRACEV_2(_waypointsActivated,_waypointsDeactivated);
	_waypointsActivated sort true;
	
	(_waypointsActivated select 0) params ["_currentValue","_currentDistance","_currentWay","_currentWP"];
	//_currentWP = (_waypointsActivated select 0)select 2;
	
	_temp = _currentWP getVariable [QGVAR(WP_XM),[objNull,0]];
	if !(isNull (_temp select 0)) then {
		_value = (_temp select 1) + _currentWay + _currentDistance; 
		_inside = 0;
		_inside = ({
				If ((_x select 3)==(_temp select 0)) then {
					If ((_x select 0)>_value) then {
						_x set [0,_value];
					};
					true;
				}else{
					false;
				};
			}count _waypointsActivated) + (
			{
				If ((_x select 3)==(_temp select 0)) then {
					true;
				}else{
					false;
				};
			}count _waypointsDeactivated);
		If (_inside < 1) then {
			_waypointsActivated pushBack [_value,floor(((_temp select 0) distance2D _targetLogic)/10),_currentWay + (_temp select 1),(_temp select 0)];
		};
	};
	if ((!(isNull (_temp select 0)))&&{(_temp select 0) == _targetLogic}) exitWith {_delete = (_waypointsActivated deleteAt 0);_waypointsDeactivated pushBack _delete;_waypointsDeactivated pushBack [-1,0,0,_targetLogic];_active = false;};
	
	_temp = _currentWP getVariable [QGVAR(WP_XP),[objNull,0]];
	if !(isNull (_temp select 0)) then {
		_value = (_temp select 1) + _currentWay + _currentDistance;
		_inside = 0;
		_inside = ({
				If ((_x select 3)==(_temp select 0)) then {
					If ((_x select 0)>_value) then {
						_x set [0,_value];
					};
					true;
				}else{
					false;
				};
			}count _waypointsActivated) + (
			{
				If ((_x select 3)==(_temp select 0)) then {
					true;
				}else{
					false;
				};
			}count _waypointsDeactivated);
		If (_inside < 1) then {
			_waypointsActivated pushBack [_value,floor(((_temp select 0) distance2D _targetLogic)/10),_currentWay + (_temp select 1),(_temp select 0)];
		};
	};
	if ((!(isNull (_temp select 0)))&&{(_temp select 0) == _targetLogic}) exitWith {_delete = (_waypointsActivated deleteAt 0);_waypointsDeactivated pushBack _delete;_waypointsDeactivated pushBack [-1,0,0,_targetLogic];_active = false;};
	
	_temp = _currentWP getVariable [QGVAR(WP_YM),[objNull,0]];
	if !(isNull (_temp select 0)) then {
		_value = (_temp select 1) + _currentWay + _currentDistance;
		_inside = 0;
		_inside = ({
				If ((_x select 3)==(_temp select 0)) then {
					If ((_x select 0)>_value) then {
						_x set [0,_value];
					};
					true;
				}else{
					false;
				};
			}count _waypointsActivated) + (
			{
				If ((_x select 3)==(_temp select 0)) then {
					true;
				}else{
					false;
				};
			}count _waypointsDeactivated);
		If (_inside < 1) then {
			_waypointsActivated pushBack [_value,floor(((_temp select 0) distance2D _targetLogic)/10),_currentWay + (_temp select 1),(_temp select 0)];
		};
	};
	if ((!(isNull (_temp select 0)))&&{(_temp select 0) == _targetLogic}) exitWith {_delete = (_waypointsActivated deleteAt 0);_waypointsDeactivated pushBack _delete;_waypointsDeactivated pushBack [-1,0,0,_targetLogic];_active = false;};
	
	_temp = _currentWP getVariable [QGVAR(WP_YP),[objNull,0]];
	if !(isNull (_temp select 0)) then {
		_value = (_temp select 1) + _currentWay + _currentDistance;
		_inside = 0;
		_inside = ({
				If ((_x select 3)==(_temp select 0)) then {
					If ((_x select 0)>_value) then {
						_x set [0,_value];
					};
					true;
				}else{
					false;
				};
			}count _waypointsActivated) + (
			{
				If ((_x select 3)==(_temp select 0)) then {
					true;
				}else{
					false;
				};
			}count _waypointsDeactivated);
		If (_inside < 1) then {
			_waypointsActivated pushBack [_value,floor(((_temp select 0) distance2D _targetLogic)/10),_currentWay + (_temp select 1),(_temp select 0)];
		};
	};
	if ((!(isNull (_temp select 0)))&&{(_temp select 0) == _targetLogic}) exitWith {_delete = (_waypointsActivated deleteAt 0);_waypointsDeactivated pushBack _delete;_waypointsDeactivated pushBack [-1,0,0,_targetLogic];_active = false;};
	
	_temp = _currentWP getVariable [QGVAR(WP_XMYM),[objNull,0]];
	if !(isNull (_temp select 0)) then {
		_value = (_temp select 1) + _currentWay + _currentDistance;
		_inside = 0;
		_inside = ({
				If ((_x select 3)==(_temp select 0)) then {
					If ((_x select 0)>_value) then {
						_x set [0,_value];
					};
					true;
				}else{
					false;
				};
			}count _waypointsActivated) + (
			{
				If ((_x select 3)==(_temp select 0)) then {
					true;
				}else{
					false;
				};
			}count _waypointsDeactivated);
		If (_inside < 1) then {
			_waypointsActivated pushBack [_value,floor(((_temp select 0) distance2D _targetLogic)/10),_currentWay + (_temp select 1),(_temp select 0)];
		};
	};
	if ((!(isNull (_temp select 0)))&&{(_temp select 0) == _targetLogic}) exitWith {_delete = (_waypointsActivated deleteAt 0);_waypointsDeactivated pushBack _delete;_waypointsDeactivated pushBack [-1,0,0,_targetLogic];_active = false;};
	
	_temp = _currentWP getVariable [QGVAR(WP_XMYP),[objNull,0]];
	if !(isNull (_temp select 0)) then {
		_value = (_temp select 1) + _currentWay + _currentDistance;
		_inside = 0;
		_inside = ({
				If ((_x select 3)==(_temp select 0)) then {
					If ((_x select 0)>_value) then {
						_x set [0,_value];
					};
					true;
				}else{
					false;
				};
			}count _waypointsActivated) + (
			{
				If ((_x select 3)==(_temp select 0)) then {
					true;
				}else{
					false;
				};
			}count _waypointsDeactivated);
		If (_inside < 1) then {
			_waypointsActivated pushBack [_value,floor(((_temp select 0) distance2D _targetLogic)/10),_currentWay + (_temp select 1),(_temp select 0)];
		};
	};
	if ((!(isNull (_temp select 0)))&&{(_temp select 0) == _targetLogic}) exitWith {_delete = (_waypointsActivated deleteAt 0);_waypointsDeactivated pushBack _delete;_waypointsDeactivated pushBack [-1,0,0,_targetLogic];_active = false;};
	
	_temp = _currentWP getVariable [QGVAR(WP_XPYM),[objNull,0]];
	if !(isNull (_temp select 0)) then {
		_value = (_temp select 1) + _currentWay + _currentDistance;
		_inside = 0;
		_inside = ({
				If ((_x select 3)==(_temp select 0)) then {
					If ((_x select 0)>_value) then {
						_x set [0,_value];
					};
					true;
				}else{
					false;
				};
			}count _waypointsActivated) + (
			{
				If ((_x select 3)==(_temp select 0)) then {
					true;
				}else{
					false;
				};
			}count _waypointsDeactivated);
		If (_inside < 1) then {
			_waypointsActivated pushBack [_value,floor(((_temp select 0) distance2D _targetLogic)/10),_currentWay + (_temp select 1),(_temp select 0)];
		};
	};
	if ((!(isNull (_temp select 0)))&&{(_temp select 0) == _targetLogic}) exitWith {_delete = (_waypointsActivated deleteAt 0);_waypointsDeactivated pushBack _delete;_waypointsDeactivated pushBack [-1,0,0,_targetLogic];_active = false;};
	
	_temp = _currentWP getVariable [QGVAR(WP_XPYP),[objNull,0]];
	if !(isNull (_temp select 0)) then {
		_value = (_temp select 1) + _currentWay + _currentDistance;
		_inside = 0;
		_inside = ({
				If ((_x select 3)==(_temp select 0)) then {
					If ((_x select 0)>_value) then {
						_x set [0,_value];
					};
					true;
				}else{
					false;
				};
			}count _waypointsActivated) + (
			{
				If ((_x select 3)==(_temp select 0)) then {
					true;
				}else{
					false;
				};
			}count _waypointsDeactivated);
		If (_inside < 1) then {
			_waypointsActivated pushBack [_value,floor(((_temp select 0) distance2D _targetLogic)/10),_currentWay + (_temp select 1),(_temp select 0)];
		};
	};
	if ((!(isNull (_temp select 0)))&&{(_temp select 0) == _targetLogic}) exitWith {_delete = (_waypointsActivated deleteAt 0);_waypointsDeactivated pushBack _delete;_waypointsDeactivated pushBack [-1,0,0,_targetLogic];_active = false;};
	_delete = (_waypointsActivated deleteAt 0);
	_waypointsDeactivated pushBack _delete;
};



{
	#ifdef DEBUG_MODE_FULL
		[getPos (_x select 3),format["%1_%2",_x select 0,_x select 1]] call EFUNC(common,debug_marker_create);
	#endif
}forEach _waypointsActivated;

{
	#ifdef DEBUG_MODE_FULL
		[getPos (_x select 3),format["%1_%2",_x select 0,_x select 1],"ColorBlue"] call EFUNC(common,debug_marker_create);
	#endif
}forEach _waypointsDeactivated;



_waypoints = [(_waypointsDeactivated deleteAt ((count _waypointsDeactivated) -1))select 3];
_active = true;
while {_active} do {
	_currentWP = _waypoints select ((count _waypoints) -1);
	_nextWP = objNull;
	if (_currentWP == _startLogic) exitWith {_active=false;};
	_value = 999999999;
	{
		_curVar = _x;
		_temp = (_currentWP getVariable [_x,[objNull,0]])select 0;
		_tempVal = 0;
		if (_temp in _waypoints) then {
			_temp = objNull;
		};
		if !(isNull _temp) then {
			{
				if ((_x select 3) == _temp) exitWith {
					if ((_x select 0)<_value) then {
						_nextWP = _x select 3;
						_value = (_x select 0);
					};
				};
			}count _waypointsDeactivated;
		};
	}forEach [QGVAR(WP_XM),QGVAR(WP_XMYM),QGVAR(WP_XMYP),QGVAR(WP_XP),QGVAR(WP_XPYM),QGVAR(WP_XPYP),QGVAR(WP_YM),QGVAR(WP_YP)];
	If !(isNull _nextWP) then {
		_waypoints append [_nextWP];
	};
};

{
	#ifdef DEBUG_MODE_FULL
		[getPos _x,"","ColorBlue","hd_objective"] call EFUNC(common,debug_marker_create);
	#endif
}forEach _waypoints;










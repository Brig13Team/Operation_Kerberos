/*
	Author: iJesuz

	Description:
		Calculates the Point between two points (see arguments).
		The new point has the distance s (see arguments) from the first point.

	Arguments:
		0 - Array : Point1
		1 - Array : Point2
		2 - Real : distance

	Return:
		Array : Point3

*/
private["_point1", "_point2", "_left", "_right", "_distance", "_point3", "_buffer", "_y1", "_y2", "_x1", "_x2", "_m", "_n"];

scriptName "pointBetween";

_point1 = _this select 0;
_point2 = _this select 1;

if ((_point2 select 0) < (_point1 select 0)) then {
	_left = _point2;
	_right = _point1;
} else {
	_left = _point1;
	_right = _point2;
};

_distance = _this select 2;

_x1 = _left select 0;
_y1 = _left select 1;
_x2 = _right select 0;
_y2 = _right select 1;

_m = (_y2 - _y1)/(_x2 - _x1);
_n = _y1 - _m*_x1;

_buffer = cos ( atan _m ) * _distance;
if ( [_point1,_right] call BIS_fnc_areEqual ) then {
	_point3 = [ _x2 - _buffer ];
} else {
	_point3 = [ _x1 + _buffer ];
};
_point3 = _point3 + [_m*(_point3 select 0) + _n];
_point3 = _point3 + [0];

_point3

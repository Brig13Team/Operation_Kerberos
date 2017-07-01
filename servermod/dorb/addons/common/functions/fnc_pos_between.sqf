/*
    Author: iJesuz

    Description:
        Calculates the Point between two points (see arguments).
        The new point has the distance s (see arguments) from the first point.

    Arguments:
        0 - ARRAY : Point1
        1 - ARRAY : Point2
        2 - SCALAR : distance (optimal)

    Return:
        ARRAY : Point3

*/
#include "script_component.hpp"
_this params["_point1","_point2"];

if ((count _point1 == 3) && (count _point2 == 3)) exitWith {
    private ["_v","_l","_d","_f"];
    _v = [(_point2 select 0) - (_point1 select 0), (_point2 select 1) - (_point1 select 1), (_point2 select 2) - (_point1 select 2)];
    _l = sqrt((_v select 0)^2 + (_v select 1)^2 + (_v select 1)^2);

    _d = param[2,_l/2,[0]];

    _f = _d / _l;

    [(_point1 select 0) + (_v select 0) * _f, (_point1 select 1) + (_v select 1) * _f, (_point1 select 2) + (_v select 2) * _f]
};

if ((count _point1 == 2) && (count _point2 == 2)) exitWith {
    private ["_v","_l","_d","_f"];
    _v = [(_point2 select 0) - (_point1 select 0), (_point2 select 1) - (_point1 select 1)];
    _l = sqrt((_v select 0)^2 + (_v select 1)^2);

    _d = param[2,_l/2,[0]];

    _f = _d / _l;

    [(_point1 select 0) + (_v select 0) * _f, (_point1 select 1) + (_v select 1) * _f]
};

[]

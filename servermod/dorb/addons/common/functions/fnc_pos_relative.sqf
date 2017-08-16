/*
 *  Author: Dorbedo
 *
 *  Description:
 *      returns a position relative to the given one
 *
 *  Parameter(s):
 *      0 : ARRAY - position
 *      1 : SCALAR - distance
 *      2 : SCALAR - direction
 *
 *  Returns:
 *      ARRAY - position
 *
 */
#include "script_component.hpp"
_this params[["_position",[],[[],objNull],[2,3]],["_distance",-1,[0]],["_dir",0,[0]]];
If (_position isEqualType objNull) then {_position = getPos _position;};
If (_position isEqualTo []) exitWith {[];};
if (count _position==3) then {
    [(_position select 0) + _distance*sin _dir, (_position select 1) + _distance*cos _dir, _position select 2];
} else {
    [(_position select 0) + _distance*sin _dir, (_position select 1) + _distance*cos _dir];
};

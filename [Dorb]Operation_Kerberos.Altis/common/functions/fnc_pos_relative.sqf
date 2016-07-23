/*
    Author: Dorbedo

    Description:
    returns Array with a Position relative to a given one

    Parameter(s):
        0 : ARRAY    - Position
        1 : SCALAR   - Distance
        2 : SCALAR   - direction     

    Returns:
    ARRAY : Array with Position

*/
#include "script_component.hpp"
_this params[["_position",[],[[],objNull],[2,3]],["_distance",-1,[0]],["_dir",0,[0]]];
If (_position isEqualType objNull) then {_position = getPos _position;};
CHECKRET((_position isEqualTo []),[]);
if (count _position==3) then {
    [(_position select 0) + _distance*sin _dir, (_position select 1) + _distance*cos _dir, _position select 2];
} else {
    [(_position select 0) + _distance*sin _dir, (_position select 1) + _distance*cos _dir];
};

/*
 *  Author: Dorbedo
 *
 *  Description:
 *      returns array with positions from a square
 *
 *  Parameter(s):
 *      0 : ARRAY - centerposition
 *      0 : SCALAR - step
 *      0 : SCALAR - lenght in x direction
 *      0 : SCALAR - lenght in y direction
 *
 *  Returns:
 *      ARRAY - [[_position,_step,_sideX,_sideY],_positions]
 *
 */
#include "script_component.hpp"

_this params[["_position",[],[[]],[2,3]],["_step",30,[0]],["_sideX",600,[0]],["_sideY",-1,[0]]];
If (_position isEqualTo []) exitWIth {[];};
If ((_step < 3)||(_sideX < 10)) exitWith {[_position]};
If (_sideY < 0) then {_sideY=_sideX;};

private _startpos = [((_position select 0)-(_sideX*0.5)),((_position select 1)-(_sideY*0.5)),0];
private _return = [];

for "_i" from 0 to (floor(_sideX/_step)) do {
    for "_j" from 0 to (floor(_sideY/_step)) do {
        _return pushBack [(_startpos select 0)+(_i*_step),(_startpos select 1)+(_j*_step),0];
    };
};

[[_position,_step,_sideX,_sideY],_return];

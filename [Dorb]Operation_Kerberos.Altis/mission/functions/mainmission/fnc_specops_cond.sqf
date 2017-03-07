/*
 * (old file)
 *
 *  Author: Dorbedo
 *
 *  Description:
 *      Mission "Specops" : Conditional Function
 *
 *  Parameter(s):
 *      0 : ARRAY - the centerposition
 *      1 : SCALAR - radius
 *      2 : SCALAR - units to skip
 *
 *  Returns:
 *      STRING - taskstate
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_centerposition",[],[[]]],["_radius",0,[0]],["_skipamount",0,[0]]];

private _unitsinArea = {
    (side _x == GVARMAIN(side))&&
    {(_x distance2D _centerposition) < _radius}
} count allUnits;

If (_unitsinArea < _skipamount) then { "Succeeded" };
""

/*
    Author: Dorbedo
    v1.0
    
    Description:
        buffering the dangerzone
    
    Parameter(s):
        none

    Returns:
        none
*/
#include "script_component.hpp"

CHECK(GVAR(buffer) isEqualTo [])

private _temp = (GVAR(buffer)) deleteAt 0;
CHECK(_temp isEqualTo [])
_temp params [["_X_pos",0,[0]],["_Y_pos",0,[0]],["_value",0,[0]]];

{
    ([QGVAR(dangerzones)] append _x) call EFUNC(common,matrix_value_add);
} forEach [
    [_X_pos,_Y_pos,_value],
    [_X_pos-1,_Y_pos,_value*HQ_DANGERMOD],
    [_X_pos+1,_Y_pos,_value*HQ_DANGERMOD],
    [_X_pos,_Y_pos-1,_value*HQ_DANGERMOD],
    [_X_pos,_Y_pos+1,_value*HQ_DANGERMOD]
];
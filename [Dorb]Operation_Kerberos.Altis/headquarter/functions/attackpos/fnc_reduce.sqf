/*
    Author: Dorbedo
    
    Description:
        revon
    
    Parameter(s):
        none

    Returns:
        none
*/
#include "script_component.hpp"

_this params [["_group",grpNull,[grpNull]]];
CHECK(isNull _group)
private _target = _group getVariable [QGVAR(target),locationNull];

CHECK(IS_ARRAY(_target))
CHECK(isNull _target)

private _strength = _group getVariable [QGVAR(cost),0];

private _temp = _target getVariable [QGVAR(troopsNeeded),0];

_temp = (_temp - cost) max 0;

_target setVariable [QGVAR(troopsNeeded),_temp];

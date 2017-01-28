/*
    Author: Dorbedo

    Description:
        pirmary to register the dead to the HQ

    Parameter(s):
        0:OBJECT    - killed unit
        1:OBJECT    - Killer

    Returns:
        none
*/
#include "script_component.hpp"

_this params["_unit","_killer"];

if (_unit getVariable [QEGVAR(mission,ishostage),false]) exitWith {
    [QGVAR(hostage_killed),[_unit,_killer]] call CBA_fnc_globalEvent;
};

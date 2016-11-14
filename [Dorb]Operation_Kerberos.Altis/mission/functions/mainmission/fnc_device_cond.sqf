/*
    Author: iJesuz

    Description:
        Mission "Device" : Conditional Function

    Parameter(s):
        0 : OBJECT  -   the device

    Return:
        STRING  - taskstate
*/
#include "script_component.hpp"

_this params [["_device",objNull,[objNull]],["_intervall",0,[0]]];

if (isNull _device) exitWith { "" };

if (not (alive _device)) exitWith { "Succeeded" };

if (GVAR(last_earthquake) + _intervall <= CBA_missionTime) then {
    GVAR(last_earthquake) = CBA_missionTime;
    [QGVAR(earthquake)] call CBA_fnc_globalEvent;
};

""

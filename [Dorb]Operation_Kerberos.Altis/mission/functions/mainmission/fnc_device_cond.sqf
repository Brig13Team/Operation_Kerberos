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

_this params [["_device",objNull,[objNull]],["_intervall",-1,[0]]];

if (isNull _device) exitWith { "" };

if (not alive _device) exitWith { "Succeeded" };

if (GVAR(last_earthquake) + _intervall >= diag_tickTime) then {
    [QGVAR(earthquake)] call CBA_fnc_globalEvent;
}

""

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

if !(_device getVariable [QGVAR(isActive),true]) exitWith { "Succeeded" };
if (!(alive _device)) exitWith { "Failed" };

if (GVAR(last_earthquake) + _intervall <= CBA_missionTime) then {
    GVAR(last_earthquake) = CBA_missionTime;
    private _strenght = (floor(random 4)+1);
    [QGVAR(earthquake),_strenght] call CBA_fnc_globalEvent;
};

""

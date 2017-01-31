/*
    Author: iJesuz

    Description:
        Mission "EMP" : Conditional Function

    Parameter(s):
        0 : OBJECT  -   the device

    Return:
        STRING  - taskstate
*/
#include "script_component.hpp"

_this params [["_emp",objNull,[objNull]],["_intervall",-1,[0]]];

if (isNull _emp) exitWith { "" };

if !(_emp getVariable [QGVAR(isActive),true]) exitWith { "Succeeded" };
if (!(alive _emp)) exitWith { "Failed" };

if (GVAR(last_emp) + _intervall >= CBA_missionTime) then {
    GVAR(last_emp) = CBA_missionTime;
    [QGVAR(emp),getPos _emp] call CBA_fnc_serverEvent;
};

""

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

if (not alive _emp) exitWith { "Succeeded" };

if (GVAR(last_emp) + _intervall >= diag_tickTime) then {
    QGVAR(emp),getPos _emp] call CBA_fnc_serverevent;
}

""

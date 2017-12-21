#include "script_component.hpp"
/**
 * Author: Dorbedo
 * post init
 *
 * Arguments:
 * Nothing
 *
 * Return Value:
 * Nothing
 *
 */
If (!isServer) exitWith {};
/*
[
    QGVAR(changeOwner),
    {_this call FUNC(changeOwner);}
] call CBA_fnc_addEventHandler;
*/

/*
 *  Author: Dorbedo
 *
 *  Description:
 *      removes an arsenal from an object
 *
 *  Parameter(s):
 *      0 : OBJECT - The object whre the arsenal should be removed
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"
params [["_target",objNull,[objNull]]];

If (!isServer) exitWith {
    [QGVAR(ArsenalRemoveAction),[_target]] call CBA_fnc_serverEvent;
};

GVAR(arsenal_boxes) = GVAR(arsenal_boxes) - [_target];

If !(missionNamespace getVariable [QGVAR(ArsenalIsTransmitting),false]) then {
    GVAR(ArsenalIsTransmitting) = true;
    [
        {
            GVAR(ArsenalIsTransmitting) = false;
            publicvariable QGVAR(arsenal_boxes);
            publicvariable QGVAR(allowedPositions);
            [QGVAR(ArsenalAddAction)] call CBA_fnc_globalEvent;
        },
        [],
        5
    ] call CBA_fnc_waitAndExecute;
};

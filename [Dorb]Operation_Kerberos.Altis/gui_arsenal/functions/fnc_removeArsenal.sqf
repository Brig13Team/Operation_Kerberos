/*
 *  Author: [Name of Author(s)]
 *
 *  Description:
 *      [Description]
 *
 *  Parameter(s):
 *      0 : [TYPE] - [argument name]
 *
 *  Returns:
 *      [TYPE] - [return name]
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"
_this params [["_target",objNull,[objNull]]];

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

/*
    Author: Dorbedo

    Description:
        adds Arsenal to a unit
        can be called via unit-init
*/
//#define DEBUG_MODE_FULL
#include "script_component.hpp"
params [["_target",objNull,[objNull]]];

GVAR(arsenal_boxes) pushBackUnique _target;

CHECK(!isServer)

If !(missionNamespace getVariable [QGVAR(ArsenalIsTransmitting),false]) then {
    GVAR(ArsenalIsTransmitting) = true;
    [
        {
            GVAR(ArsenalIsTransmitting) = false;
            publicvariable QGVAR(arsenal_boxes);
            publicvariable QGVAR(allowedPositions);
        },
        [],
        5
    ] call CBA_fnc_waitAndExecute;
};

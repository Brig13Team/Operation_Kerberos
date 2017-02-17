/*
    Author: Dorbedo

    Description:
        adds Arsenal to a unit
        can be called via unit-init
*/

#include "script_component.hpp"
_this params [["_target",objNull,[objNull]]];

CHECK(!isServer)

GVAR(arsenal_boxes) pushBackUnique _target;

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

/*
    Author: Dorbedo

    Description:
        adds Arsenalaction to object

*/
#include "script_component.hpp"
_this params [["_box",objNull,[objNull]],["_removeAction",false,[true]]];

private _boxes = missionnamespace getvariable [QGVAR(arsenal_boxes),[]];
_boxes = _boxes - [_box];
if !(_removeAction) then {_boxes = _boxes + [_box];};
missionnamespace setvariable [QGVAR(arsenal_boxes),_boxes];

// small delay
If !(missionNamespace getVariable [QGVAR(ArsenalIsTransmitting),false]) then {
    GVAR(ArsenalIsTransmitting) = true;
    [
        {
            GVAR(ArsenalIsTransmitting) = false;
            publicvariable QGVAR(arsenal_boxes);
            [QGVAR(ArsenalAddAction)] call CBA_fnc_globalEvent;
        },
        [],
        5
    ] call CBA_fnc_waitAndExecute;
};

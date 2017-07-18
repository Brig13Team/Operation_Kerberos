/*
 * Author: Dorbedo
 *
 */
#include "script_component.hpp"

If (hasInterface) then {
    [] spawn FUNC(ArsenalRemoveRadio);
    GVAR(arsenalSaved) = false;
    [
        QGVARMAIN(arsenalClosed),
        {
            If (GVAR(arsenalSaved)) then {
                [] spawn FUNC(ArsenalRemoveRadio);
                GVAR(arsenalSaved) = false;
            };
        }
    ] call CBA_fnc_addEventHandler;

    [
        QGVARMAIN(arsenalOpened),
        {
            disableSerialization;
            private _display = (uinamespace getVariable "RscDisplayGarage");
            (_display displayctrl 44147) ctrladdeventhandler ["buttonclick",QUOTE(GVAR(arsenalSaved) = false;)];
        }
    ] call CBA_fnc_addEventHandler;
};

/**
 * Author: Dorbedo
 * closes the metro
 *
 * Arguments:
 * 0: <DISPLAY> the display
 *
 * Return Value:
 * Nothing
 *
 */

#include "script_component.hpp"
disableSerialization;
params ["_display"];

{
    {
        ctrlDelete _x
    } forEach _x;
} forEach (uiNamespace getVariable [QGVAR(metroBttns), []]);

uiNamespace setVariable [QGVAR(metroBttns), []];

private _ctrl = _display displayCtrl IDC_GUI_MAIN_METRO_GRP;
if !(isNull _ctrl) then {
    ctrlDelete _ctrl;
};

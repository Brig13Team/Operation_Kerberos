/**
 * Author: Dorbedo
 * onLoad Event of the menu
 *
 * Arguments:
 * 0: <DIALOG> the Dialog
 *
 * Return Value:
 * Nothing
 *
 */

#include "script_component.hpp"

disableSerialization;
params ["_display"];

with uiNamespace do {
    GVAR(currentDisplays) pushBack _display;
    while {((count GVAR(currentDisplays)) > 1)} do {
        private _dispToClose = GVAR(currentDisplays) deleteAt 0;
        _dispToClose closeDisplay 1;
    };
};

[_display] call FUNC(initHeader);

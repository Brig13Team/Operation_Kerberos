/*
 *  Author: DOrbedo
 *
 *  Description:
 *      starts general display functions
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      none
 *
 */
#include "script_component.hpp"

disableSerialization;

private _dialog = uiNamespace getVariable QGVAR(dialog);

[_dialog] call FUNC(clock);
[_dialog] call FUNC(showNotifications);

["0"] call FUNC(displayPage);

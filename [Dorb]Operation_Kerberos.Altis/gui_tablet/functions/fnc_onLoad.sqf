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
#define INCLUDE_GUI
#include "script_component.hpp"

disableSerialization;

private _dialog = uiNamespace getVariable QGVAR(dialog);

/*
private _text = ((parsingNamespace getVariable ["MISSION_ROOT",""]) + QPAAPATH(tablet_background));
((findDisplay IDD_TABLET_MAIN) displayCtrl IDC_TABLET_Background) ctrlSetText _text;
*/
[_dialog] spawn FUNC(clock);
[_dialog] call FUNC(showNotifications);

["0"] call FUNC(displayPage);

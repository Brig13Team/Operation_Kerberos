/**
 * Author: Dorbedo
 * initializes the Header of the menu
 *
 * Arguments:
 * 0: <DISPLAY> the main display
 *
 * Return Value:
 * Nothing
 *
 */

#include "script_component.hpp"


params ["_display"];

[_display] spawn FUNC(clock);


private _ctrl = _display displayCtrl IDC_GUI_MAIN_MENUBTTN;
_ctrl ctrlSetText "\A3\ui_f\data\GUI\rsc\rscdisplayconfigviewer\bookmark_gs.paa";
_ctrl ctrlcommit 0;

private _ctrl = _display displayCtrl IDC_GUI_MAIN_LOGO;
_ctrl ctrlSetText ((parsingNamespace getVariable ["MISSION_ROOT", ""]) + "gui\data\logo\logo_512w.paa");
_ctrl ctrlcommit 0;

private _ctrl = _display displayCtrl IDC_GUI_MAIN_HEADERTEXT;
_ctrl ctrlSetText (localize LSTRING(HEADER));

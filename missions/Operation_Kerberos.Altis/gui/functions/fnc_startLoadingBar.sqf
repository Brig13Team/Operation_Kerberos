/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Opens the loading-bar and changes the title
 *
 *  Parameter(s):
 *      0 : STRING - the title (optional)
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_title","",[""]]];

IDD_LOADINGBAR cutRsc [QAPP(loadingbar),"PLAIN"];
If !(_title isEqualTo "") then {
    If (isLocalized _title) then {_title = localize _title;};
    private _display = uiNamespace getvariable QGVAR(loadingbar);
    if (!isNull _display) then {
        private _ctrl = _display displayCtrl IDC_LOADINGBAR_HEADER;
        _ctrl ctrlSetText _title;
    };
};

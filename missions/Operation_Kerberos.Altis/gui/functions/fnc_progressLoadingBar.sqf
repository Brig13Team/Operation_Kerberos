/*
 *  Author: Dorbedo
 *
 *  Description:
 *      progresses the loadingbar
 *
 *  Parameter(s):
 *      0 : SCALAR - Current Value
 *      1 : SCALAR - Min Value
 *      2 : SCALAR - Max Value
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params [["_value",0,[0]],["_value_min",0,[0]],["_value_max",1,[0]]];

private _progress = _value / (_value_max - _value_min);

private _display = uiNamespace getvariable QGVAR(loadingbar);
TRACEV_1(_display);
if (!isNull _display) then {
    private _ctrl = _display displayCtrl IDC_LOADINGBAR_BAR;
    _ctrl progressSetPosition _progress;
    _ctrl ctrlSetTextColor (_this call FUNC(getColorGradient));
    _ctrl ctrlCommit 0;

    _ctrl = _display displayCtrl IDC_LOADINGBAR_STATE;
    _ctrl ctrlSetText (format["%1 ",floor(_progress * 100)] + "%");
    _ctrl ctrlSetPosition [
        (GUI_LOADINGBAR_STATE_X + (GUI_LOADINGBAR_BAR_W * _progress)),
        GUI_LOADINGBAR_STATE_Y
    ];
    _ctrl ctrlCommit 0;

    _ctrl = _display displayCtrl IDC_LOADINGBAR_ARROW;
    _ctrl ctrlSetPosition [
        (GUI_LOADINGBAR_ARROW_X + (GUI_LOADINGBAR_BAR_W * _progress)),
        GUI_LOADINGBAR_ARROW_Y
    ];
    _ctrl ctrlCommit 0;
};

/*
 *  Author: Dorbedo
 *
 *  Description:
 *      displays a Page
 *
 *  Parameter(s):
 *      0 : STRING - Pagename
 *
 *  Returns:
 *      none
 *
 */
#define DEBUG_MODE_FULL
#define INCLUDE_GUI
#include "script_component.hpp"
disableSerialization;

private _display = (findDisplay IDD_ECHNIDA_MAIN);

private _ctrlBackground = _display displayCtrl IDC_ECHNIDA_METRO_BACK;
_ctrlBackground ctrlSetPosition [0,0,0,0];
_ctrlBackground ctrlCommit 0;


private _ctrlGroup = _display displayCtrl IDC_ECHNIDA_METRO_SIDE_GRP;
private _ctrlBackground = _ctrlGroup controlsGroupCtrl IDC_ECHNIDA_METRO_BACK_SIDE;
private _ctrl = _ctrlGroup controlsGroupCtrl IDC_ECHNIDA_METRO_SIDE_SHUTDOWN;
_ctrlBackground ctrlSetPosition [0, 0, 0, 0];
_ctrlBackground ctrlCommit 0;
_ctrl ctrlSetPosition [0,0,0,0];
_ctrl ctrlRemoveAllEventHandlers "ButtonClick";
_ctrlGroup ctrlsetPosition [0,0,0,0];
_ctrlGroup ctrlCommit 0;

private _ctrlGroup = _display displayCtrl IDC_ECHNIDA_METRO_GRP;
private _ctrlBackground = _ctrlGroup controlsGroupCtrl IDC_ECHNIDA_METRO_BACK_HELPER;
_ctrlBackground ctrlSetPosition [0, 0, 0, 0];
_ctrlBackground ctrlCommit 0;
{
    private _idc = _x;
    private _ctrl = _ctrlGroup controlsGroupCtrl _idc;
    _ctrl ctrlSetPosition [0, 0, 0, 0];
    _ctrl ctrlSetText "";
    _ctrl ctrlSetTooltip "";
    _ctrl ctrlEnable false;
    _ctrl ctrlRemoveAllEventHandlers "ButtonClick";
    _ctrl ctrlCommit 0;
} forEach [

];
TRACEV_2(_display,_ctrlGroup);
_ctrlGroup ctrlsetPosition [SafeZoneX + safeZoneWAbs + 1, SafeZoneY + SafeZoneH + 1, 0, 0];
_ctrlGroup ctrlCommit 0;

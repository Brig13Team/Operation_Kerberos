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
//#define DEBUG_MODE_FULL
#define INCLUDE_GUI
#include "script_component.hpp"
disableSerialization;

{
    private _idc = _x;
    private _ctrl = (findDisplay IDD_ECHNIDA_MAIN) displayCtrl _idc;
    _ctrl ctrlSetPosition [0, 0, 0, 0];
    _ctrl ctrlSetText "";
    _ctrl ctrlSetTooltip "";
    _ctrl ctrlEnable false;
    _ctrl ctrlRemoveAllEventHandlers "ButtonClick";
    _ctrl ctrlCommit 0;
} forEach [

];

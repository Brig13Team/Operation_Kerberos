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
#define INCLUDE_GUI
#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_page","0",[""]]];

private _currentApps = HASH_GET(GVAR(Applications),_page);
TRACEV_1(_currentApps);
{
    _x params ["_displayName","_function","_condition","_picture","_size","_grid"];
    TRACEV_6(_displayName,_function,_condition,_picture,_size,_grid);
    private _idc = _forEachIndex + IDC_TABLET_BTTN1;
    private _pos_x = GUI_GRID_TABLET_BTTN_X + (_grid select 0) * GUI_GRID_TABLET_BTTN_W;
    private _pos_y = GUI_GRID_TABLET_BTTN_Y + (_grid select 1) * GUI_GRID_TABLET_BTTN_H;
    private _pos_w = GUI_GRID_TABLET_BTTN_W - GUI_GRID_TABLET_BTTN_DIS_W;
    private _pos_h = GUI_GRID_TABLET_BTTN_H - GUI_GRID_TABLET_BTTN_DIS_H;
    switch _size do {
        case 3 : {
            _pos_w = GUI_GRID_TABLET_BTTN_W * 2 - GUI_GRID_TABLET_BTTN_DIS_W;
            _pos_h = GUI_GRID_TABLET_BTTN_H * 2 - GUI_GRID_TABLET_BTTN_DIS_H;
        };
        case 2 : {
            _pos_w = GUI_GRID_TABLET_BTTN_W * 2 - GUI_GRID_TABLET_BTTN_DIS_W;
        };
    };
    private _ctrl = (findDisplay IDD_TABLET_MAIN) displayCtrl _idc;
    TRACEV_6(_ctrl,_displayName,_pos_x, _pos_y, _pos_w, _pos_h);
    _ctrl ctrlSetPosition [_pos_x, _pos_y, _pos_w, _pos_h];
    _ctrl ctrlSetStructuredText (text format[" <img image='%1' /> %2",_picture,_displayName]);
    //_ctrl ctrlSetText (_displayName);
    private _test = call _condition;
    TRACEV_2(_test,_condition);
    If (call _condition) then {
        TRACE("enabled");
        _ctrl ctrlEnable true;
        _ctrl ctrlAddEventHandler ["onKlick",_function];
        _ctrl ctrlCommit 0;
    }else{
        TRACE("disabled");
        _ctrl ctrlEnable false;
        _ctrl ctrlRemoveAllEventHandlers "onKlick";
        _ctrl ctrlCommit 0;
    };
} forEach _currentApps;

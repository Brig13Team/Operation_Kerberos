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
#include "script_component.hpp"

_this params [["_page","0",[""]]];

private _currentApps = HASH_GET(GVAR(Applications),_page);

{
    _x params ["_displayName","_function","_condition","_picture","_size","_grid"];
    private _idc = _forEachIndex + IDC_TABLET_BTTN;
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
    _ctrl ctrlSetPosition [_pos_x, _pos_y, _pos_w, _pos_h];
    _ctrl ctrlSetText (text _displayName);
    If (call _condition) then {
        _ctrl ctrlEnable true;
        _ctrl ctrlAddEventHandler ["onKlick",_function];
    }else{
        _ctrl ctrlEnable false;
        _ctrl ctrlRemoveAllEventHandlers "onKlick";
    };
} forEach _currentApps;

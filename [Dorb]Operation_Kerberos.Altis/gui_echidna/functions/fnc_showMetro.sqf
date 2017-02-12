/*
 *  Author: Dorbedo
 *
 *  Description:
 *      shows the Metro-Interface
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      none
 *
 */
#define DEBUG_MODE_FULL
#define INCLUDE_GUI
#include "script_component.hpp"
disableSerialization;

private _idc = IDC_ECHNIDA_METRO_BTTN1;
private _display = (findDisplay IDD_ECHNIDA_MAIN);
private _ctrlGroup = _display displayCtrl IDC_ECHNIDA_METRO_SIDE_GRP;

If !((ctrlPosition _ctrlGroup) isEqualTo [0,0,0,0]) exitWith {
    [] call FUNC(hideMetro);
};
// Background
_ctrl = _display displayCtrl IDC_ECHNIDA_METRO_BACK;
_ctrl ctrlSetPosition [
    GUI_ECHIDNA_X,
    GUI_ECHIDNA_Y,
    GUI_ECHIDNA_WAbs,
    GUI_ECHIDNA_METRO_H
];
_ctrl ctrlCommit 0;
TRACEV_2(_ctrl,ctrlPosition _ctrl);
// sidebar
_ctrlGroup ctrlSetPosition [
    GUI_ECHIDNA_X,
    GUI_ECHIDNA_Y,
    GUI_ECHIDNA_METRO_SIDE,
    GUI_ECHIDNA_METRO_H
];
_ctrlGroup ctrlCommit 0;
private _ctrlBackground = _ctrlGroup controlsGroupCtrl IDC_ECHNIDA_METRO_SIDE_BACK;
_ctrlBackground ctrlSetPosition [0, 0, GUI_ECHIDNA_METRO_SIDE, GUI_ECHIDNA_METRO_H];
_ctrlBackground ctrlCommit 0;
private _ctrl = _ctrlGroup controlsGroupCtrl IDC_ECHNIDA_METRO_SIDE_SHUTDOWN;
_ctrl ctrlSetPosition [0, GUI_ECHIDNA_METRO_H - GUI_ECHIDNA_METRO_SIDE - GUI_ECHIDNA_METRO_BTTN_DIST, GUI_ECHIDNA_METRO_SIDE,GUI_ECHIDNA_METRO_SIDE];
_ctrl ctrlAddEventHandler ["ButtonClick",EFUNC(gui_echidna,close)];
_ctrl ctrlSetText ((parsingNamespace getVariable ["MISSION_ROOT",""]) + QEPAAPATH(echidna,shutdown));
_ctrl ctrlCommit 0;
TRACEV_2(_ctrlBackground,_ctrlGroup);

// metro surface
private _ctrlGroup = _display displayCtrl IDC_ECHNIDA_METRO_GRP;
_ctrlGroup ctrlSetPosition [
    GUI_ECHIDNA_X + GUI_ECHIDNA_METRO_SIDE,
    GUI_ECHIDNA_Y,
    GUI_ECHIDNA_METRO_W,
    GUI_ECHIDNA_METRO_H
];
_ctrlGroup ctrlCommit 0;
private _ctrlBackground = _ctrlGroup controlsGroupCtrl IDC_ECHNIDA_METRO_BACK_HELPER;
_ctrlBackground ctrlSetPosition [
    0,
    0,
    GUI_ECHIDNA_METRO_W - GUI_ECHIDNA_METRO_SIDE,
    GUI_ECHIDNA_METRO_H
];
_ctrlBackground ctrlCommit 0;


{
    private _currentApps = HASH_GET_DEF(GVAR(Applications),_x,[]);
    If !(_currentApps isEqualTo []) then {
        private _curX = GUI_ECHIDNA_METRO_BTTN_X + (GUI_ECHIDNA_METRO_BTTN_W * 3 + GUI_ECHIDNA_METRO_BTTN_DIST + GUI_ECHIDNA_METRO_ROW_DIST) * _forEachIndex;
        private _ctrlBackground = _ctrlGroup controlsGroupCtrl IDC_ECHNIDA_METRO_BACK_HELPER;
        _ctrlBackground ctrlSetPosition [
            0,
            0,
            GUI_ECHIDNA_METRO_W max (GUI_ECHIDNA_METRO_BTTN_X + GUI_ECHIDNA_METRO_BTTN_DIST + (GUI_ECHIDNA_METRO_BTTN_W * 3 + GUI_ECHIDNA_METRO_BTTN_DIST + GUI_ECHIDNA_METRO_ROW_DIST) * (_forEachIndex+1)),
            GUI_ECHIDNA_METRO_H
        ];
        _ctrlBackground ctrlCommit 0;
        TRACEV_2(_currentApps,_curX);
        {
            _x params ["_displayName","_function","_condition","_picture","_size","_parameter","_grid"];
            TRACEV_6(_displayName,_function,_condition,_picture,_size,_grid);
            private _pos_x = _curX + (_grid select 0) * (GUI_ECHIDNA_METRO_BTTN_W + GUI_ECHIDNA_METRO_BTTN_DIST);
            private _pos_y = GUI_ECHIDNA_METRO_BTTN_Y + (_grid select 1) * (GUI_ECHIDNA_METRO_BTTN_H + GUI_ECHIDNA_METRO_BTTN_DIST);
            private _pos_w = GUI_ECHIDNA_METRO_BTTN_W;
            private _pos_h = GUI_ECHIDNA_METRO_BTTN_H;
            switch _size do {
                case 3 : {
                    _pos_w = GUI_ECHIDNA_METRO_BTTN_W * 2 + GUI_ECHIDNA_METRO_BTTN_DIST;
                    _pos_h = GUI_ECHIDNA_METRO_BTTN_H * 2 + GUI_ECHIDNA_METRO_BTTN_DIST;
                };
                case 2 : {
                    _pos_w = GUI_ECHIDNA_METRO_BTTN_W * 2 + GUI_ECHIDNA_METRO_BTTN_DIST;
                };
            };
            //private _ctrl = _display displayCtrl _idc;
            private _ctrl = _ctrlGroup controlsGroupCtrl _idc;
            TRACEV_6(_ctrl,_displayName,_pos_x, _pos_y, _pos_w, _pos_h);
            _ctrl ctrlSetPosition [_pos_x, _pos_y, _pos_w, _pos_h];
            _ctrl ctrlSetText _picture;
            _ctrl ctrlSetTooltip _displayName;
            _ctrl ctrlSetFontHeight GUI_ECHIDNA_METRO_BTTN_H;


            #ifdef DEBUG_MODE_FULL
                private _conditionTest = call _condition;
                TRACEV_2(_conditionTest,_condition);
            #endif
            If (call _condition) then {
                TRACE("enabled");
                _ctrl ctrlEnable true;
                #ifdef DEBUG_MODE_FULL
                    private _actionAdded = _ctrl ctrlAddEventHandler ["ButtonClick",_function];
                    TRACEV_3(_actionAdded,_ctrl,_function);
                #else
                    _ctrl ctrlAddEventHandler ["ButtonClick",_function];
                #endif
                _ctrl ctrlCommit 0;
            }else{
                TRACE("disabled");
                _ctrl ctrlEnable false;
                _ctrl ctrlRemoveAllEventHandlers "ButtonClick";
                _ctrl ctrlCommit 0;
            };
            INC(_idc);
        } forEach _currentApps;
    };
} forEach ["0","1","2","3","4","5","6","7","8","9","10"];

/**
 * Author: Dorbedo
 * creates the metro display
 *
 * Arguments:
 * 0: <DISPLAY> the main display
 *
 * Return Value:
 * <TYPENAME> return name
 *
 */

#include "script_component.hpp"

disableSerialization;

params [["_MainBttn", controlNull, [controlNull]]];

private _display = uiNamespace getVariable [QEGVAR(gui_main,dialog),(findDisplay IDD_GUI_MAIN)];


private _ctrlGroup = _display getVariable [QGVAR(metro),controlNull];

If !(isNull _ctrlGroup) exitWith {
    [_display] call FUNC(closeMetro);
};

_ctrlGroup = _display ctrlCreate [QRSC(Metro),IDC_GUI_MAIN_METRO_GRP];
_display setVariable [QGVAR(metro),_ctrlGroup];

private _ctrlGroupbackground = _ctrlGroup controlsGroupCtrl IDC_GUI_MAIN_METRO_BACK;
private _allCategories = allVariables GVAR(Applications);


private _xNull = GUI_DISP_W*2;
private _yNull = GUI_DISP_H*14;

#define METRO_BTTN_SIZEW (getNumber(missionConfigFile >> QRSC(MetroBttn_background) >> "w"))
#define METRO_BTTN_SIZEH (getNumber(missionConfigFile >> QRSC(MetroBttn_background) >> "h"))
#define METRO_BTTN_DISTH (GUI_DISP_H*2)
#define METRO_BTTN_DISTW (GUI_DISP_W*2)

{
    private _curCategorie = _x;
    private _curButtons = GVAR(Applications) getVariable _curCategorie;

    private _catName = _display ctrlCreate [QRSC(MetroCategorie), -1, _ctrlGroup];
    _catName ctrlSetPosition [_xNull, _yNull - GUI_DISP_H * 10];
    _catName ctrlSetText _curCategorie;
    _catName ctrlCommit 0;

    if (_forEachIndex > 0) then {
        private _catSplit = _display ctrlCreate [QRSC(MetroSplit), -1, _ctrlGroup];
        _catSplit ctrlSetPosition [
            _xNull - GUI_DISP_W*1 - (getNumber(missionConfigFile >> QRSC(MetroSplit) >> "w"))/2,
            _yNull
        ];
        _catSplit ctrlCommit 0;
    };

    private _index = 0;
    {
        _x params ["_displayName", "_picture", "_function", "_condition", "_parameter", "_color"];
        //LOG_6("_active=%6 - _disp=%1 - _pic=%2 - _func=%3 - _cond=%4 - _param=%5", _displayName, _picture, _function, _condition, _parameter, _parameter call _condition);
        private _posX = _xNull;
        private _posY = _yNull + _index * (METRO_BTTN_SIZEH+METRO_BTTN_DISTH);
        _index = If (_index >= 4) then {
            _xNull = _xNull + METRO_BTTN_DISTW + METRO_BTTN_SIZEW;
            0
        } else {
            _index + 1
        };
        private ["_ctrl", "_ctrlBack"];
        If (_picture isEqualTo "") then {
            _ctrl = ["createText", [_posX, _posY]] call FUNC(metroBttn);
            _ctrlBack = _ctrl select 1;
            _ctrl = _ctrl select 0;
            _ctrl ctrlSetText _displayName;
        } else {
            _ctrl = ["create", [_posX, _posY]] call FUNC(metroBttn);
            _ctrlBack = _ctrl select 1;
            _ctrl = _ctrl select 0;
            _ctrl ctrlSetText _picture;
        };
        _ctrl ctrlSetTooltip _displayName;
        _ctrl ctrlSetTextColor [1, 1, 1, 1];

        If ([ace_player,ace_player,_parameter] call _condition) then {
            _ctrl ctrlEnable true;
            _ctrl setVariable [QGVAR(function), _function];
            _ctrl setVariable [QGVAR(params), _parameter];
            _ctrl ctrlAddEventHandler ["ButtonClick", {((_this select 0) getVariable QGVAR(params)) call ((_this select 0) getVariable QGVAR(function))}];
        } else {
            _ctrl ctrlEnable false;
            _ctrl ctrlRemoveAllEventHandlers "ButtonClick";
            _ctrl ctrlSetTextColor [1, 1, 1, 0.4];
        };
        _ctrl ctrlCommit 0;
        _ctrlBack ctrlSetTextColor _color;
        _ctrlBack ctrlCommit 0;
    } forEach _curButtons;

    _xNull = _xNull + GUI_DISP_W*4 + METRO_BTTN_SIZEW;

} forEach _allCategories;

_ctrlGroupbackground ctrlSetPosition [
    0,
    0,
    (_xNull + METRO_BTTN_DISTW) max (getNumber(missionConfigFile >> QRSC(Metro) >> "w")),
    (getNumber(missionConfigFile >> QRSC(Metro) >> "h"))];
_ctrlGroupbackground ctrlCommit 0;

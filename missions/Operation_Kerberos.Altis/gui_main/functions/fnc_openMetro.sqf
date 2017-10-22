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
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

disableSerialization;

params [["_MainBttn", controlNull, [controlNull]]];
TRACEV_1(_mainbttn);

private _display = ctrlParent _mainbttn;

private _ctrlGroup = _display getVariable [QGVAR(metro),controlNull];

TRACEV_3(ctrlParent _mainbttn,_display,_ctrlGroup);

If !(isNull _ctrlGroup) exitWith {
    [_display] call FUNC(closeMetro);
};
TRACEV_4(_ctrlGroup,_display displayCtrl IDC_GUI_MAIN_METRO_GRP,allControls _display,allDisplays);
_ctrlGroup = _display ctrlCreate [QRSC(Metro), IDC_GUI_MAIN_METRO_GRP];
_display setVariable [QGVAR(metro),_ctrlGroup];
TRACEV_2(_ctrlGroup,_display);
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
    //TRACEV_2(_display,_curButtons);
    private _catName = _display ctrlCreate [QRSC(MetroCategorie), -1, _ctrlGroup];
    _catName ctrlSetPosition [_xNull, _yNull - GUI_DISP_H * 10];
    _catName ctrlSetText (If (toUpper _curCategorie == "NONE") then {""} else {_curCategorie});
    _catName ctrlCommit 0;
    TRACEV_2(_curCategorie,uiNamespace getvariable 'GVAR(metroBttns)');
    If !((uiNamespace getvariable 'GVAR(metroBttns)')isEqualTo []) then {
        private _buttons = (uiNamespace getvariable 'GVAR(metroBttns)') select 0;
        TRACEV_1(ctrlPosition (_buttons select 1));
    };
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
            _ctrl = ["createText", [_ctrlGroup,_posX, _posY]] call FUNC(metroBttn);
            _ctrlBack = _ctrl select 1;
            _ctrl = _ctrl select 0;
            _ctrl ctrlSetText _displayName;
        } else {
            _ctrl = ["create", [_ctrlGroup,_posX, _posY]] call FUNC(metroBttn);
            _ctrlBack = _ctrl select 1;
            _ctrl = _ctrl select 0;
            _ctrl ctrlSetText _picture;
        };
        //TRACEV_4(_displayname,_picture,uiNamespace getvariable 'GVAR(metroBttns)',_ctrl);
        _ctrl ctrlSetTooltip _displayName;
        _ctrl ctrlSetTextColor [1, 1, 1, 1];

        If ([ace_player,ace_player,_parameter] call _condition) then {
            _ctrl ctrlEnable true;
            _ctrl setVariable [QGVAR(function), _function];
            _ctrl setVariable [QGVAR(params), [ace_player,ace_player,_parameter]];
            _ctrl ctrlAddEventHandler ["ButtonClick", {/*
                private _params = (_this select 0) getVariable QGVAR(params);
                private _fnc = (_this select 0) getVariable QGVAR(function);
                [ctrlParent (_this select 0)] call FUNC(close);
                _params call _fnc;*/
                ((_this select 0) getVariable QGVAR(params)) call ((_this select 0) getVariable QGVAR(function));
                _this call FUNC(close);
                false;
            }];
        } else {
            _ctrl ctrlEnable false;
            _ctrl ctrlRemoveAllEventHandlers "ButtonClick";
            _ctrl ctrlSetTextColor [1, 1, 1, 0.7];
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

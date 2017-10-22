/**
 * Author: Dorbedo
 * The Metro Bttn handling
 *
 * Arguments:
 * 0: <STRING> the handling Event
 * 1: <ARRAY> parameter
 *
 * Return Value:
 * <CONTROL> the button
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_event", ["_params", [controlNull]]];

switch (toLower _event) do {
    case "create" : {
        _params params ["_ctrlGroup",["_posX", 0, [0]], ["_posY", 0, [0]]];
        private _idc = (count (uiNamespace getVariable [QGVAR(metroBttns), []]))*3 + IDC_GUI_MAIN_METRO_BTTN_START;
        private _ctrlPicture = (ctrlParent _ctrlGroup) ctrlCreate [QRSC(MetroBttn_background), _idc, _ctrlGroup];
        _ctrlPicture ctrlSetPosition [_posX + GUI_DISP_W, _posY];
        _ctrlPicture ctrlCommit 0;

        INC(_idc);
        private _ctrlBttn = (ctrlParent _ctrlGroup) ctrlCreate [QRSC(MetroBttn), _idc, _ctrlGroup];
        _ctrlBttn ctrlSetPosition [_posX + GUI_DISP_W, _posY];
        _ctrlBttn ctrlCommit 0;
        _ctrlBttn ctrlAddEventHandler ["MouseEnter", {["onMouseEnter", _this] call FUNC(metroBttn);}];
        _ctrlBttn ctrlAddEventHandler ["MouseExit", {["onMouseExit", _this] call FUNC(metroBttn);}];
        _ctrlBttn ctrlAddEventHandler ["ButtonDown", {["onButtonDown", _this] call FUNC(metroBttn);}];
        _ctrlBttn ctrlAddEventHandler ["ButtonUp", {["onButtonUp", _this] call FUNC(metroBttn);}];
        _ctrlBttn ctrlAddEventHandler ["SetFocus", {["onSetFocus", _this] call FUNC(metroBttn);}];
        _ctrlBttn ctrlAddEventHandler ["KillFocus", {["onKillFocus", _this] call FUNC(metroBttn);}];
        _ctrlBttn setVariable ["background", _ctrlPicture];
        private _temp = (uiNamespace getVariable [QGVAR(metroBttns), []]);
        _temp pushBack [_ctrlBttn, _ctrlPicture];
        uiNamespace setVariable [QGVAR(metroBttns), _temp];
        TRACEV_4(_ctrlGroup,ctrlParent _ctrlGroup,_ctrlBttn, _ctrlPicture);
        [_ctrlBttn, _ctrlPicture]
    };
    case "createtext" : {
        _params params ["_ctrlGroup",["_posX", 0, [0]], ["_posY", 0, [0]]];
        private _idc = (count (uiNamespace getVariable [QGVAR(metroBttns), []]))*3 + IDC_GUI_MAIN_METRO_BTTN_START;
        private _ctrlPicture = (ctrlParent _ctrlGroup) ctrlCreate [QRSC(MetroBttn_background), _idc, _ctrlGroup];
        _ctrlPicture ctrlSetPosition [_posX + GUI_DISP_W, _posY];
        _ctrlPicture ctrlCommit 0;

        INC(_idc);
        private _ctrlBttn = (ctrlParent _ctrlGroup) ctrlCreate [QRSC(MetroTextBttn), _idc, _ctrlGroup];
        _ctrlBttn ctrlSetPosition [_posX + GUI_DISP_W, _posY];
        _ctrlBttn ctrlCommit 0;
        _ctrlBttn ctrlAddEventHandler ["MouseEnter", {["onMouseEnter", _this] call FUNC(metroBttn);}];
        _ctrlBttn ctrlAddEventHandler ["MouseExit", {["onMouseExit", _this] call FUNC(metroBttn);}];
        _ctrlBttn ctrlAddEventHandler ["ButtonDown", {["onButtonDown", _this] call FUNC(metroBttn);}];
        _ctrlBttn ctrlAddEventHandler ["ButtonUp", {["onButtonUp", _this] call FUNC(metroBttn);}];
        _ctrlBttn ctrlAddEventHandler ["SetFocus", {["onSetFocus", _this] call FUNC(metroBttn);}];
        _ctrlBttn ctrlAddEventHandler ["KillFocus", {["onKillFocus", _this] call FUNC(metroBttn);}];
        _ctrlBttn setVariable ["background", _ctrlPicture];
        private _temp = (uiNamespace getVariable [QGVAR(metroBttns), []]);
        _temp pushBack [_ctrlBttn, _ctrlPicture];
        uiNamespace setVariable [QGVAR(metroBttns), _temp];
        TRACEV_4(_ctrlGroup,ctrlParent _ctrlGroup,_ctrlBttn, _ctrlPicture);
        [_ctrlBttn, _ctrlPicture]
    };
    case "delete" : {
        _params params ["_ctrlBttn", controlNull];
        private _ctrlPicture = _ctrlBttn getVariable "background";
        ctrlDelete _ctrlPicture;
        ctrlDelete _ctrlBttn;
    };
    case "onmouseenter" : {
        _params params ["_ctrlBttn"];
        private _ctrlPicture = _ctrlBttn getVariable "background";
        _ctrlPicture ctrlSetText ((parsingNamespace getVariable ["MISSION_ROOT", ""]) + "gui\data\buttons\button_256_over.paa");
        _ctrlPicture ctrlSetBackgroundColor [1, 1, 1, 1];
        _ctrlPicture ctrlCommit 0;
    };
    case "onmouseexit" : {
        _params params ["_ctrlBttn"];
        private _ctrlPicture = _ctrlBttn getVariable "background";
        _ctrlPicture ctrlSetText ((parsingNamespace getVariable ["MISSION_ROOT", ""]) + "gui\data\buttons\button_256_normal.paa");
        _ctrlPicture ctrlSetBackgroundColor [0, 0, 0, 1];
        _ctrlPicture ctrlCommit 0;
    };
    case "onbuttondown" : {
        _params params ["_ctrlBttn"];
        private _ctrlPicture = _ctrlBttn getVariable "background";
        _ctrlPicture ctrlSetText ((parsingNamespace getVariable ["MISSION_ROOT", ""]) + "gui\data\buttons\button_256_pressed.paa");
        _ctrlPicture ctrlSetBackgroundColor [1, 1, 1, 1];
        _ctrlPicture ctrlCommit 0;
    };
    case "onbuttonup" : {
        _params params ["_ctrlBttn"];
        private _ctrlPicture = _ctrlBttn getVariable "background";
        _ctrlPicture ctrlSetText ((parsingNamespace getVariable ["MISSION_ROOT", ""]) + "gui\data\buttons\button_256_normal.paa");
        _ctrlPicture ctrlSetBackgroundColor [0, 0, 0, 1];
        _ctrlPicture ctrlCommit 0;
    };
    case "onsetfocus" : {
        _params params ["_ctrlBttn"];
        private _ctrlPicture = _ctrlBttn getVariable "background";
        _ctrlPicture ctrlSetText ((parsingNamespace getVariable ["MISSION_ROOT", ""]) + "gui\data\buttons\button_256_focused.paa");
        _ctrlPicture ctrlSetBackgroundColor [1, 1, 1, 1];
        _ctrlPicture ctrlCommit 0;
    };
    case "onkillfocus" : {
        _params params ["_ctrlBttn"];
        private _ctrlPicture = _ctrlBttn getVariable "background";
        _ctrlPicture ctrlSetText ((parsingNamespace getVariable ["MISSION_ROOT", ""]) + "gui\data\buttons\button_256_normal.paa");
        _ctrlPicture ctrlSetBackgroundColor [1, 1, 1, 1];
        _ctrlPicture ctrlCommit 0;
    };
};

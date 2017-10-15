/**
 * Author: Dorbedo
 * animated button handling
 *
 * Arguments:
 * 0: <STRING> dialog Event
 * 1: <ANY> parameter
 *
 * Return Value:
 * <TYPENAME> return name
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_event", "_params"];

switch (toLower _event) do {
    case "create" : {
        _params params [
            "_display",
            ["_posX", 0, [0]],
            ["_posY", 0, [0]],
            ["_posW", GUI_DISP_W*10, [0]],
            ["_posH", GUI_DISP_H*10, [0]]
        ];
        private _idc = (count (uiNamespace getVariable [QGVAR(animBttns), []]))*3 + IDC_GUI_ANIM_BTTN_START;
        private ["_ctrlPicture","_ctrlBttn"];
        If (IS_CONTROL(_display)) then {
            _ctrlPicture = (ctrlParent _display) ctrlCreate [QRSC(AnimBttn_background), _idc, _display];
            INC(_idc);
            _ctrlBttn = (ctrlParent _display) ctrlCreate [QRSC(AnimBttn), _idc, _display];
        } else {
            _ctrlPicture = _display ctrlCreate [QRSC(AnimBttn_background), _idc];
            INC(_idc);
            _ctrlBttn = _display ctrlCreate [QRSC(AnimBttn), _idc];
        };

        _ctrlPicture ctrlSetPosition [_posX, _posY, _posW, _posH];
        _ctrlPicture ctrlCommit 0;

        _ctrlBttn ctrlSetPosition [
            _posX+GUI_DISP_W*0.5,
            _posY+GUI_DISP_H*0.5,
            _posW-GUI_DISP_W*1,
            _posH-GUI_DISP_H*1
        ];
        _ctrlBttn ctrlCommit 0;
        _ctrlBttn ctrlAddEventHandler ["MouseEnter", {["onMouseEnter", _this] call FUNC(animButton);}];
        _ctrlBttn ctrlAddEventHandler ["MouseExit", {["onMouseExit", _this] call FUNC(animButton);}];
        _ctrlBttn ctrlAddEventHandler ["ButtonDown", {["onButtonDown", _this] call FUNC(animButton);}];
        _ctrlBttn ctrlAddEventHandler ["ButtonUp", {["onButtonUp", _this] call FUNC(animButton);}];
        _ctrlBttn ctrlAddEventHandler ["SetFocus", {["onSetFocus", _this] call FUNC(animButton);}];
        _ctrlBttn ctrlAddEventHandler ["KillFocus", {["onKillFocus", _this] call FUNC(animButton);}];
        _ctrlBttn setVariable ["background", _ctrlPicture];
        private _temp = (uiNamespace getVariable [QGVAR(animBttns), []]);
        _temp pushBack [_ctrlBttn, _ctrlPicture];
        uiNamespace setVariable [QGVAR(animBttns), _temp];
        //TRACEV_2(_ctrlBttn, _ctrlPicture);
        [_ctrlBttn, _ctrlPicture]
    };
    case "createtext" : {
        _params params [
            "_display",
            ["_posX", 0, [0]],
            ["_posY", 0, [0]],
            ["_posW", GUI_DISP_W*10, [0]],
            ["_posH", GUI_DISP_H*10, [0]]
        ];
        private _idc = (count (uiNamespace getVariable [QGVAR(animBttns), []]))*3 + IDC_GUI_ANIM_BTTN_START;
        private _ctrlPicture = _display ctrlCreate [QRSC(AnimBttn_background), _idc];
        _ctrlPicture ctrlSetPosition [_posX, _posY, _posW, _posH];
        _ctrlPicture ctrlCommit 0;

        INC(_idc);
        private _ctrlBttn = _display ctrlCreate [QRSC(AnimTextBttn), _idc];
        _ctrlBttn ctrlSetPosition [
            _posX+GUI_DISP_W*0.5,
            _posY+GUI_DISP_H*0.5,
            _posW-GUI_DISP_W*1,
            _posH-GUI_DISP_H*1
        ];
        _ctrlBttn ctrlCommit 0;
        _ctrlBttn ctrlAddEventHandler ["MouseEnter", {["onMouseEnter", _this] call FUNC(animButton);}];
        _ctrlBttn ctrlAddEventHandler ["MouseExit", {["onMouseExit", _this] call FUNC(animButton);}];
        _ctrlBttn ctrlAddEventHandler ["ButtonDown", {["onButtonDown", _this] call FUNC(animButton);}];
        _ctrlBttn ctrlAddEventHandler ["ButtonUp", {["onButtonUp", _this] call FUNC(animButton);}];
        _ctrlBttn ctrlAddEventHandler ["SetFocus", {["onSetFocus", _this] call FUNC(animButton);}];
        _ctrlBttn ctrlAddEventHandler ["KillFocus", {["onKillFocus", _this] call FUNC(animButton);}];
        _ctrlBttn setVariable ["background", _ctrlPicture];
        private _temp = (uiNamespace getVariable [QGVAR(animBttns), []]);
        _temp pushBack [_ctrlBttn, _ctrlPicture];
        uiNamespace setVariable [QGVAR(animBttns), _temp];
        TRACEV_2(_ctrlBttn, _ctrlPicture);
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

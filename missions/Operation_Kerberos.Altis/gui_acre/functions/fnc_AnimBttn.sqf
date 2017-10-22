/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Anomation for the metro button
 *
 *  Parameter(s):
 *      0 : STRING - dialog Eventhandler
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params ["_event","_params"];
_params params ["_ctrlBttn"];
private _display = uiNamespace getVariable [QEGVAR(gui_main,dialog),(findDisplay IDD_GUI_ACRE)];
private _ctrlIDC = parseNumber ((str _ctrlBttn) select [9]);
private _ctrlPicture = _display displayCtrl (-_ctrlIDC);
TRACEV_4(_event,_ctrlBttn,_ctrlIDC,_ctrlPicture);
switch (toLower _event) do {
    case "changepos" : {
        private _pos = _params param [1];
        _ctrlBttn ctrlSetPosition _pos;
        _ctrlBttn ctrlCommit 0;
        _ctrlBttn ctrlAddEventHandler ["MouseEnter", {["onMouseEnter",_this] call FUNC(AnimBttn);}];
        _ctrlBttn ctrlAddEventHandler ["MouseExit", {["onMouseExit",_this] call FUNC(AnimBttn);}];
        _ctrlBttn ctrlAddEventHandler ["ButtonDown", {["onButtonDown",_this] call FUNC(AnimBttn);}];
        _ctrlBttn ctrlAddEventHandler ["ButtonUp", {["onButtonUp",_this] call FUNC(AnimBttn);}];
        _ctrlBttn ctrlAddEventHandler ["SetFocus", {["onSetFocus",_this] call FUNC(AnimBttn);}];
        _ctrlBttn ctrlAddEventHandler ["KillFocus", {["onKillFocus",_this] call FUNC(AnimBttn);}];
        _ctrlPicture ctrlSetPosition _pos;
        _ctrlPicture ctrlCommit 0;
    };
    case "delete" : {
        _ctrlBttn ctrlSetPosition [0,0,0,0];
        _ctrlBttn ctrlCommit 0;
        _ctrlBttn ctrlRemoveAllEventHandlers "MouseEnter";
        _ctrlBttn ctrlRemoveAllEventHandlers "MouseExit";
        _ctrlBttn ctrlRemoveAllEventHandlers "ButtonDown";
        _ctrlBttn ctrlRemoveAllEventHandlers "ButtonUp";
        _ctrlBttn ctrlRemoveAllEventHandlers "SetFocus";
        _ctrlBttn ctrlRemoveAllEventHandlers "KillFocus";
        _ctrlBttn ctrlRemoveAllEventHandlers "ButtonClick";
        _ctrlPicture ctrlSetPosition [0,0,0,0];
        _ctrlPicture ctrlCommit 0;
    };
    case "hide" : {
        _ctrlBttn ctrlSetPosition [0,0,0,0];
        _ctrlBttn ctrlCommit 0;
        _ctrlBttn ctrlRemoveAllEventHandlers "ButtonClick";
        _ctrlPicture ctrlSetPosition [0,0,0,0];
        _ctrlPicture ctrlCommit 0;
    };
    case "onmouseenter" : {
        _ctrlPicture ctrlSetText ((parsingNamespace getVariable ["MISSION_ROOT",""]) + QUOTE(gui\data\buttons\button_256_over.paa));
        _ctrlPicture ctrlSetBackgroundColor [1,1,1,1];
        _ctrlPicture ctrlCommit 0;
         TRACEV_1(ctrlText _ctrlPicture);
    };
    case "onmouseexit" : {
        _ctrlPicture ctrlSetText ((parsingNamespace getVariable ["MISSION_ROOT",""]) + QUOTE(gui\data\buttons\button_256_normal.paa));
        _ctrlPicture ctrlSetBackgroundColor [0,0,0,1];
        _ctrlPicture ctrlCommit 0;
    };
    case "onbuttondown" : {
        _ctrlPicture ctrlSetText ((parsingNamespace getVariable ["MISSION_ROOT",""]) + QUOTE(gui\data\buttons\button_256_pressed.paa));
        _ctrlPicture ctrlSetBackgroundColor [1,1,1,1];
        _ctrlPicture ctrlCommit 0;
    };
    case "onbuttonup" : {
        _ctrlPicture ctrlSetText ((parsingNamespace getVariable ["MISSION_ROOT",""]) + QUOTE(gui\data\buttons\button_256_normal.paa));
        _ctrlPicture ctrlSetBackgroundColor [0,0,0,1];
        _ctrlPicture ctrlCommit 0;
    };
    case "onsetfocus" : {
        _ctrlPicture ctrlSetText ((parsingNamespace getVariable ["MISSION_ROOT",""]) + QUOTE(gui\data\buttons\button_256_focused.paa));
        _ctrlPicture ctrlSetBackgroundColor [1,1,1,1];
        _ctrlPicture ctrlCommit 0;
    };
    case "onkillfocus" : {
        _ctrlPicture ctrlSetText ((parsingNamespace getVariable ["MISSION_ROOT",""]) + QUOTE(gui\data\buttons\button_256_normal.paa));
        _ctrlPicture ctrlSetBackgroundColor [1,1,1,1];
        _ctrlPicture ctrlCommit 0;
    };
    default{
        TRACEV_3(missing_Entry,_this,ctrlParentControlsGroup (_params select 0));
    };
};

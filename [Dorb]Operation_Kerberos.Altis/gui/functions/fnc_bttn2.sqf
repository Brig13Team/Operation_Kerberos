/*
 *  Author: [Name of Author(s)]
 *
 *  Description:
 *      [Description]
 *
 *  Parameter(s):
 *      0 : [TYPE] - [argument name]
 *
 *  Returns:
 *      [TYPE] - [return name]
 *
 */
#define INCLUDE_GUI
#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params ["_event","_params"];
private _ctrlIDC = parseNumber ((str (_params select 0)) select [9]);

//TRACEV_4(_event,_params,_ctrlIDC,_this);
switch (toLower _event) do {
    case "onload" : {
        _params params ["_ctrlGroup"];
        //private _ctrlPicture = _ctrlGroup controlsGroupCtrl (_ctrlIDC+1);
        //private _ctrlBttn = _ctrlGroup controlsGroupCtrl (_ctrlIDC+2);
        private _ctrlPicture = _ctrlGroup controlsGroupCtrl 101;
        private _ctrlBttn = _ctrlGroup controlsGroupCtrl 102;
        private _idcPicture = _ctrlIDC + 2;

        private _enter = _ctrlBttn ctrlAddEventHandler ["MouseEnter", {["onMouseEnter",_this] call FUNC(bttn2);}];
        private _enter2 = _ctrlBttn ctrlAddEventHandler ["MouseExit", {["onMouseExit",_this] call FUNC(bttn2);}];
        _ctrlBttn ctrlAddEventHandler ["ButtonDown", {["onButtonDown",_this] call FUNC(bttn2);}];
        _ctrlBttn ctrlAddEventHandler ["ButtonClick", {["onButtonClick",_this] call FUNC(bttn2);}];
        _ctrlBttn ctrlAddEventHandler ["ButtonUp", {["onButtonUp",_this] call FUNC(bttn2);}];

        _ctrlBttn ctrlAddEventHandler ["SetFocus", {["onSetFocus",_this] call FUNC(bttn2);}];
        _ctrlBttn ctrlAddEventHandler ["KillFocus", {["onKillFocus",_this] call FUNC(bttn2);}];


        _ctrlPicture ctrlSetTextColor [RAL6018, 1];
        _ctrlPicture ctrlCommit 0;
        private _text = ctrlText _ctrlPicture;
        private _pos = ctrlPosition _ctrl;
        TRACEV_8(_ctrlGroup,_ctrlIDC,(_ctrlIDC isEqualType 0),_ctrlGroup,_ctrlPicture,[ARR_2(_enter,_enter2)],_pos,_text);
    };
    case "onmouseenter" : {
        _params params ["_ctrl"];
        private _ctrlGroup = ctrlParentControlsGroup _ctrl;
        private _IDC_Pic = _ctrlIDC - 1;
        _IDC_Pic = 101;
        private _ctrlPicture = _ctrlGroup controlsGroupCtrl _IDC_Pic;
        _ctrlPicture ctrlSetText QEPAAPATH(buttons,button_256_over);
        _ctrlPicture ctrlSetBackgroundColor [1,1,1,1];
        _ctrlPicture ctrlCommit 0;
        private _text = ctrlText _ctrlPicture;
        //TRACEV_5(_text,_ctrlGroup,_ctrlPicture,_IDC_Pic,(_IDC_Pic isEqualType 0));
    };
    case "onmouseexit" : {
        _params params ["_ctrl"];
        private _ctrlGroup = ctrlParentControlsGroup _ctrl;
        private _IDC_Pic = _ctrlIDC - 1;
        _IDC_Pic = 101;
        private _ctrlPicture = _ctrlGroup controlsGroupCtrl _IDC_Pic;
        _ctrlPicture ctrlSetText QEPAAPATH(buttons,button_256_normal);
        _ctrlPicture ctrlSetBackgroundColor [0,0,0,1];
        _ctrlPicture ctrlCommit 0;
        private _text = ctrlText _ctrlPicture;
        //TRACEV_1(_text);
    };
    case "onbuttondown" : {
        _params params ["_ctrl"];
        private _ctrlGroup = ctrlParentControlsGroup _ctrl;
        private _IDC_Pic = _ctrlIDC - 1;
        _IDC_Pic = 101;
        private _ctrlPicture = _ctrlGroup controlsGroupCtrl _IDC_Pic;
        _ctrlPicture ctrlSetText QEPAAPATH(buttons,button_256_pressed);
        _ctrlPicture ctrlSetBackgroundColor [1,1,1,1];
        _ctrlPicture ctrlCommit 0;
        private _text = ctrlText _ctrlPicture;
        //TRACEV_1(_text);
    };
    case "onbuttonup" : {
        _params params ["_ctrl"];
        private _ctrlGroup = ctrlParentControlsGroup _ctrl;
        private _IDC_Pic = _ctrlIDC - 1;
        _IDC_Pic = 101;
        private _ctrlPicture = _ctrlGroup controlsGroupCtrl _IDC_Pic;
        _ctrlPicture ctrlSetText QEPAAPATH(buttons,button_256_normal);
        _ctrlPicture ctrlSetBackgroundColor [0,0,0,1];
        _ctrlPicture ctrlCommit 0;
        private _text = ctrlText _ctrlPicture;
        //TRACEV_1(_text);
    };
    case "onbuttonclick" : {
        _params params ["_ctrl"];
        private _ctrlGroup = ctrlParentControlsGroup _ctrl;
        private _IDC_Pic = _ctrlIDC - 1;
        _IDC_Pic = 101;
        private _ctrlPicture = _ctrlGroup controlsGroupCtrl _IDC_Pic;
        _ctrlPicture ctrlSetText QEPAAPATH(buttons,button_256_over);
        _ctrlPicture ctrlSetBackgroundColor [1,1,1,1];
        _ctrlPicture ctrlCommit 0;
        private _text = ctrlText _ctrlPicture;
        //TRACEV_1(_text);
    };
    case "onsetfocus" : {
        _params params ["_ctrl"];
        private _ctrlGroup = ctrlParentControlsGroup _ctrl;
        private _IDC_Pic = _ctrlIDC - 1;
        _IDC_Pic = 101;
        private _ctrlPicture = _ctrlGroup controlsGroupCtrl _IDC_Pic;
        _ctrlPicture ctrlSetText QEPAAPATH(buttons,button_256_focused);
        _ctrlPicture ctrlSetBackgroundColor [1,1,1,1];
        _ctrlPicture ctrlCommit 0;
        private _text = ctrlText _ctrlPicture;
        TRACEV_2(_ctrlGroup,_text);
    };
    case "onkillfocus" : {
        _params params ["_ctrl"];
        private _ctrlGroup = ctrlParentControlsGroup _ctrl;
        private _IDC_Pic = _ctrlIDC - 1;
        _IDC_Pic = 101;
        private _ctrlPicture = _ctrlGroup controlsGroupCtrl _IDC_Pic;
        _ctrlPicture ctrlSetText QEPAAPATH(buttons,button_256_normal);
        _ctrlPicture ctrlSetBackgroundColor [1,1,1,1];
        _ctrlPicture ctrlCommit 0;
        private _text = ctrlText _ctrlPicture;
        TRACEV_2(_ctrlGroup,_text);
    };
    default{
        TRACEV_3(missing_Entry,_this,ctrlParentControlsGroup (_params select 0));
    };
};

/*
    Author: Dorbedo

    Description:
    Opens the Save dialog

    Parameter(s):
        0 : STRING    - Name of Var in Profilenamespace
        1 : BOOL        - Is Save - else is Load

*/
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

CHECK(!hasInterface)

_this params[["_namespaceVariable","",[""]],["_isSave",true,[true]],["_arraytoSave",[],[[]]]];
CHECK(_namespaceVariable isEqualTo "")
CHECK((_arraytoSave isEqualTo [])&&(_isSave));

GVAR(current) =  _arraytoSave;
GVAR(list) = format["DORB_SAVE_%1",_namespaceVariable];
GVAR(isopened) = true;
createDialog QAPP(dialog);

disableSerialization;
private _text = localize LSTRING(LOAD);
private _action = QUOTE([] call FUNC(load));
If (_isSave) then {
    _text = localize LSTRING(SAVE);
    _action = QUOTE([] call FUNC(save));

};

private _ctrl = (findDisplay IDD_SAVE_DLG displayCtrl IDC_SAVE_BTTN3);
_ctrl ctrlSetText _text;
_ctrl ctrlShow true;
_ctrl buttonSetAction _action;
_ctrl = (findDisplay IDD_SAVE_DLG displayCtrl IDC_SAVE_HEADER);
_ctrl ctrlSetText _text;


GVAR(handle) = [
    {
        _this call FUNC(OnOpen);
    },
    0,
    []
    ] call CBA_fnc_addPerFrameHandler;

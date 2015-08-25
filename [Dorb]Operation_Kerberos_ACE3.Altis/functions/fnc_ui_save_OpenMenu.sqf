/*
    Author: Dorbedo

    Description:
    Opens the Save dialog
	
	Parameter(s):
		0 : STRING	- Name of Var in Profilenamespace
		1 : BOOL		- Is Save - else is Load

*/
#include "script_component.hpp"
SCRIPT(ui_save_OpenMenu);
#define SAVE_OK 600244
#define SAVE_IDD	600240
#define SAVE_LIST 600241
#define SAVE_HEADER 600246
CHECK(!hasInterface)

params[["_namespaceVariable","",[""]],["_isSave",true,[true]],["_arraytoSave",[],[[]]]];
CHECK(_namespaceVariable isEqualTo "")
CHECK((_arraytoSave isEqualTo [])&&(_isSave));

DORB_SAVE_CURRENT =  _arraytoSave;
DORB_SAVE_LIST = format["DORB_SAVE_%1",_namespaceVariable];
DORB_SAVE_ISOPENED = true;
createDialog "dorb_save";

disableSerialization;
_text = localize "STR_DORB_SAVE_LOAD";
_action = "[] call dorb_fnc_ui_save_load;";
If (_isSave) then {
	_text = localize "STR_DORB_SAVE_SAVE";
	_action = "[] call dorb_fnc_ui_save_save;";
	
};

_ctrl = (findDisplay SAVE_IDD displayCtrl SAVE_OK);
_ctrl ctrlSetText _text;
_ctrl ctrlShow true;
_ctrl buttonSetAction _action;
_ctrl = (findDisplay SAVE_IDD displayCtrl SAVE_HEADER);
_ctrl ctrlSetText _text;


DORB_SAVE_HANDLE = [
	{
		_this call FM(ui_save_OnOpen);
	},
	0,
	[]
	] call CBA_fnc_addPerFrameHandler;

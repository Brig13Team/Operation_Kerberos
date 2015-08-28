/*
    Author: Dorbedo

    Description:
    Opens the Save dialog
	
	Parameter(s):
		0 : STRING	- Name of Var in Profilenamespace
		1 : BOOL		- Is Save - else is Load

*/
#include "script_component.hpp"
SCRIPT(save_OpenMenu);
#define SAVE_OK 600244
#define SAVE_IDD	600240
#define SAVE_LIST 600241
#define SAVE_HEADER 600246
CHECK(!hasInterface)

params[["_namespaceVariable","",[""]],["_isSave",true,[true]],["_arraytoSave",[],[[]]]];
CHECK(_namespaceVariable isEqualTo "")
CHECK((_arraytoSave isEqualTo [])&&(_isSave));

GVAR(save_current) =  _arraytoSave;
GVAR(save_list) = format["DORB_SAVE_%1",_namespaceVariable];
GVAR(save_isopened) = true;
createDialog "dorb_save";

disableSerialization;
_text = localize "STR_DORB_SAVE_LOAD";
_action = QUOTE([] call FUNC(save_load));
If (_isSave) then {
	_text = localize "STR_DORB_SAVE_SAVE";
	_action = QUOTE([] call FUNC(save_save));
	
};

_ctrl = (findDisplay SAVE_IDD displayCtrl SAVE_OK);
_ctrl ctrlSetText _text;
_ctrl ctrlShow true;
_ctrl buttonSetAction _action;
_ctrl = (findDisplay SAVE_IDD displayCtrl SAVE_HEADER);
_ctrl ctrlSetText _text;


GVAR(save_handle) = [
	{
		_this call FUNC(save_OnOpen);
	},
	0,
	[]
	] call CBA_fnc_addPerFrameHandler;

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
#define DEBUG_MODE_FULL
#define INCLUDE_GUI
#include "script_component.hpp"
disableSerialization;
_this params ["_dialog"];

private _inboxMain = localize LSTRING(inbox);
private _allFolders = HASH_KEYS(GVAR(mail));

_allFolders = _allFolders - [_inboxMain];
TRACEV_3(_this,_allFolders,_inboxMain);

private _ctrlList = _dialog displayCtrl IDC_ECHIDNA_MAIL_FOLDER;
TRACEV_2(_dialog,_ctrlList);
lbClear _ctrlList;
_ctrlList lbAdd _inboxMain;
{
    _ctrlList lbAdd format["  %1",_x];
} forEach _allFolders;
TRACEV_3(_allFolders,_ctrlList,lbSize _ctrlList);
_ctrlList ctrlAddEventHandler ["LBSelChanged",{_this call FUNC(onFolderSelect)}];
private _ctrlList = _dialog displayCtrl IDC_ECHIDNA_MAIL_LIST;
_ctrlList ctrlAddEventHandler ["LBSelChanged",{_this call FUNC(onMailSelect)}];

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
//#define DEBUG_MODE_FULL
#define INCLUDE_GUI
#include "script_component.hpp"
disableSerialization;
_this params ["_dialog"];

private _inboxMain = localize LSTRING(inbox);
private _allFolders = HASH_KEYS(GVAR(mail));

_allFolders = _allFolders - [_inboxMain];
TRACEV_3(_this,_allFolders,_inboxMain);

private _ctrlListFolder = _dialog displayCtrl IDC_ECHIDNA_MAIL_FOLDER;
TRACEV_2(_dialog,_ctrlListFolder);
lbClear _ctrlListFolder;
_ctrlListFolder lbAdd _inboxMain;
{
    _ctrlListFolder lbAdd format["  %1",_x];
} forEach _allFolders;
TRACEV_3(_allFolders,_ctrlListFolder,lbSize _ctrlListFolder);
_ctrlListFolder ctrlAddEventHandler ["LBSelChanged",{_this call FUNC(onFolderSelect)}];
private _ctrlListMail = _dialog displayCtrl IDC_ECHIDNA_MAIL_LIST;
_ctrlListMail ctrlAddEventHandler ["LBSelChanged",{_this call FUNC(onMailSelect)}];

_ctrlListFolder lbSetCurSel 0;
If (lbSize _ctrlListMail > 0) then {
    _ctrlListMail lbSetCurSel 0;
    TRACE("bigger");
};

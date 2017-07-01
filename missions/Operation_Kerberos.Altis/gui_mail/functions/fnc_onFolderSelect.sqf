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
_this params ["_listbox","_selectionIndex"];
TRACEV_2(_listbox,_selectionIndex);

private _folder = _listbox lbText _selectionIndex;
_folder = [_folder] call CBA_fnc_trim;
private _allMails = [];
{
    private _mailHash = _x;
    private _date = HASH_GET(_mailHash,"date");
    private _sender = HASH_GET(_mailHash,"sender");
    private _header = HASH_GET(_mailHash,"header");
    private _content = HASH_GET(_mailHash,"content");
    TRACEV_4(_sender,_header,_content,_date);
    _allMails pushBack [_date select 0,_date select 1,_date select 2,_date select 3,_date select 4,_sender,_header,_content];
} forEach (HASH_GET(GVAR(mail),_folder));

_allMails sort false;

private _ctrlList = (findDisplay IDD_ECHIDNA_MAIN) displayCtrl IDC_ECHIDNA_MAIL_LIST;
lbClear _ctrlList;

private _sel = [];
{
    _x params ["_year","_month","_day","_hour","_minute","_sender","_header","_content"];
    _sel pushBack [_sender,_header,_content,format[localize LSTRING(DATE),_day,_month,_year,_hour,_minute]];
    private _index = _ctrlList lbAdd _header;
    _ctrlList lbSetData [_index, str _forEachIndex];
} forEach _allMails;

_ctrlList setVariable [QGVAR(current),_sel];

if ((lbSize _ctrlList)>0) then {
    _ctrlList lbSetSelected [0, true];
};

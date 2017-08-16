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

private _index = parseNumber (_listbox lbData _selectionIndex);
private _data = _listbox getVariable [QGVAR(current),[]];

(_data select _index) params ["_sender","_header","_content","_date"];

TRACEV_4(_sender,_header,_content,_date);


private _display = findDisplay IDD_ECHIDNA_MAIN;

private _ctrl = _display displayCtrl IDC_ECHIDNA_MAIL_HEADER_SENDER;
_ctrl ctrlsetText _sender;
private _ctrl = _display displayCtrl IDC_ECHIDNA_MAIL_HEADER;
_ctrl ctrlsetText _header;

private _ctrl = _display displayCtrl IDC_ECHIDNA_MAIL_HEADER_DATE;
_ctrl ctrlsetText _date;

private _ctrl = _display displayCtrl IDC_ECHIDNA_MAIL_CONTENT;
_ctrl ctrlSetStructuredText (parseText _content);

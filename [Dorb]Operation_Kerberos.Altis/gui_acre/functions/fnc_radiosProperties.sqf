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

_this params [["_index",-1,[0]]];

private _textIDC = [];
for [{_i=IDC_ACRE_MENU_PROPERTIES_TEXT_1},{_i<=IDC_ACRE_MENU_PROPERTIES_TEXT_30},{INC(_i)}] do {
    _textIDC pushBack _i;
};
private _editIDC = [];
for [{_i=IDC_ACRE_MENU_PROPERTIES_EDIT_1},{_i<=IDC_ACRE_MENU_PROPERTIES_EDIT_25},{INC(_i)}] do {
    _editIDC pushBack _i;
};
private _boolIDC = [];
for [{_i=IDC_ACRE_MENU_PROPERTIES_BOOL_1},{_i<=IDC_ACRE_MENU_PROPERTIES_BOOL_5},{INC(_i)}] do {
    _boolIDC pushBack _i;
};

private _display = uiNamespace getVariable QEGVAR(gui_Echidna,dialog);
private _ctrlGroup = _display displayCtrl IDC_ACRE_MENU_PROPERTIES;

// hide all
{
    private _ctrl = _ctrlGroup controlsGroupCtrl _x;
    _ctrl ctrlsetPosition [0,0,0,0];
    _ctrl ctrlsetText "";
    _ctrl ctrlCommit 0;
} forEach _textIDC;
/*
{
    private _ctrl = _ctrlGroup controlsGroupCtrl _x;
    _ctrl ctrlsetPosition [0,0,0,0];
    _ctrl ctrlsetText "";
    _ctrl ctrlCommit 0;
} forEach _editIDC;
*/
{
    private _ctrl = _ctrlGroup controlsGroupCtrl _x;
    _ctrl ctrlsetPosition [0,0,0,0];
    _ctrl ctrlCommit 0;
} forEach _boolIDC;

If (_index < 0) exitWith {};

TRACEV_1(_index);

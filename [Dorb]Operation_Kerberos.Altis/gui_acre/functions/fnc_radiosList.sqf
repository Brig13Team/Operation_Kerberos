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
#include "script_component.hpp"
TRACE("LISTING RADIOS");
private _display = uiNamespace getVariable QEGVAR(gui_Echidna,dialog);
private _radiolist = _display displayCtrl IDC_ACRE_MENU_RADIOLIST;

lbClear _radiolist;
{
    private _curRadioHash = _x;
    private _radioType = HASH_GET(_curRadioHash,"radioType");
    private _radioHash = HASH_GET(GVAR(radioTypeList),_radioType);
    private _picture = HASH_GET(_radioHash,"picture");
    private _description = HASH_GET(_radioHash,"displayname");
    private _channel = "Channel: ";
    If ([_curRadioHash] call FUNC(isPreset)) then {
        If (HASH_HASKEY(_curRadioHash,"channelName")) then {
            _channel = format["Channel: %1",HASH_GET(_curRadioHash,"channelName")];
        }else{
            _channel = format["Channel: %1",HASH_GET_DEF(_curRadioHash,"channel",1)];
        };
    };
    private _index = _radiolist lbAdd _channel;
    _radiolist lbSetPicture [_index, _picture];
    _radiolist lbSetToolTip [_index, _description];
    _radiolist lbSetValue [_index, _forEachIndex];
} forEach GVAR(tempRadioList);

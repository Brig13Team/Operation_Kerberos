/*
 *  Author: Dorbedo
 *
 *  Description:
 *      displays the list of possible radios
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"
TRACE("LISTING RADIOS");
private _display = uiNamespace getVariable QEGVAR(gui_main,dialog);
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
        private _tempchannelName = HASH_GET(_curRadioHash,"channelName");
        TRACEV_1(_tempchannelName);
        If (HASH_HASKEY(_curRadioHash,"channelName")) then {
            _channel = format["Channel: %1",HASH_GET(_curRadioHash,"channelName")];
        }else{
            _channel = format["Channel: %1",HASH_GET_DEF(_curRadioHash,"channel",0)+1];
        };
    };
    private _index = _radiolist lbAdd _channel;
    _radiolist lbSetPicture [_index, _picture];
    _radiolist lbSetToolTip [_index, _description];
    _radiolist lbSetValue [_index, _forEachIndex];
} forEach GVAR(tempRadioList);
If ((GVAR(curSelIndex)<0)&&(lbSize _radiolist>0)) then {
    GVAR(curSelIndex) = 0;
};
If ((lbSize _radiolist - 1) < GVAR(curSelIndex)) then {
    GVAR(curSelIndex) = (lbSize _radiolist);
};
_radiolist lbSetCurSel GVAR(curSelIndex);

/*
    Author: Dorbedo

    Description:
        Sets teleport buttons

*/
#define INCLUDE_GUI
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

disableSerialization;
_this params ["_dialog"];

private _type = switch (true) do {
    case (vehicle ace_player == ace_player): {"infanterie"};
    case (vehicle ace_player isKindOf "Air"): {"air"};
    case (vehicle ace_player isKindOf "Ship"): {"ship"};
    default {"default"};
};

private _teleportTargets = missionNamespace getVariable [(format[QGVAR(%1),_type]),[]];



private _table = _dialog displayCtrl IDC_ECHIDNA_TELEPORT_TABLE;

(ctAddHeader _table) params ["_headerindex","_headercontrols"];
_headercontrols params ["_background","_headertext"];
_headertext ctrlsetText localize LSTRING(TELEPORT);


If ((GVAR(teleport_lead_active))&&{_type == "infanterie"}) then {
    (ctAddRow _table) params ["_index","_controls"];
    _controls params ["_background","_number","_text","_button"];
    _number ctrlsetText "A";
    _text ctrlsetText (localize LSTRING(LEAD));
    _button ctrlsetText (localize LSTRING(DOTELEPORT));
    _button ctrlAddEventHandler ["ButtonClick",'[] call FUNC(lead)'];
};


{
    _x params ["_position","_targetName","_condition","_params"];

    (ctAddRow _table) params ["_index","_controls"];
    _controls params ["_background","_number","_text","_button"];
    _number ctrlsetText str (_forEachIndex + 1);
    _text ctrlsetText _targetName;
    _button ctrlsetText (localize LSTRING(DOTELEPORT));
    If (_params call _condition) then {
        _button ctrlAddEventHandler ["ButtonClick",format['[%1,%2] call FUNC(teleport)',str _type,_forEachIndex]];
        _button ctrlEnable true;
    }else{
        _button ctrlEnable false;
    };
} forEach _teleportTargets;

private _pos_x = GUI_ECHIDNA_X + GUI_ECHIDNA_W*32;
private _pos_y = GUI_ECHIDNA_Y + GUI_ECHIDNA_H*19.5;
private _pos_w = GUI_ECHIDNA_W*7;
private _pos_h = GUI_ECHIDNA_H*7;
private _picture = "A3\ui_f\data\gui\cfg\Hints\map_ca.paa";
private _displayName = localize LSTRING(MAP);
private _ctrl = _dialog displayCtrl IDC_ECHIDNA_TELEPORT_BTTN_MAP;
_ctrl ctrlAddEventHandler ["ButtonClick",format['[%1] call FUNC(openMap)',str _type]];
["changepos",[_ctrl,[_pos_x, _pos_y, _pos_w, _pos_h]]] call FUNC(AnimBttn);
_ctrl ctrlSetText _picture;
_ctrl ctrlSetTooltip _displayName;
_ctrl ctrlSetFontHeight (GUI_ECHIDNA_METRO_BTTN_H * 0.1);
_ctrl ctrlSetTextColor [1,1,1,1];

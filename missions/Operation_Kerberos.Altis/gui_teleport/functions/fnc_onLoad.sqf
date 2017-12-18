/*
    Author: Dorbedo

    Description:
        Sets teleport buttons

*/
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

disableSerialization;
_this params ["_dialog"];

private _type = switch (true) do {
    case ((vehicle ace_player) == ace_player): {"infanterie"};
    case ((vehicle ace_player) isKindOf "Air"): {"air"};
    case ((vehicle ace_player) isKindOf "Ship"): {"ship"};
    default {"default"};
};

private _teleportTargets = missionNamespace getVariable [(format[QGVAR(%1),_type]),[]];



private _table = _dialog displayCtrl IDC_GUI_TELEPORT_TABLE;

(ctAddHeader _table) params ["_headerindex","_headercontrols"];
_headercontrols params ["_background","_headertext"];
_headertext ctrlsetText localize LSTRING(TELEPORT);


If ((GVAR(to_lead_active))&&{_type == "infanterie"}) then {
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

// mapButton
(["create",
    [
        _dialog,
        GUI_DISP_X+GUI_DISP_WAbs-GUI_DISP_W*14,
        GUI_DISP_Y+GUI_DISP_HAbs-GUI_DISP_H*14,
        GUI_DISP_W*10,
        GUI_DISP_H*10
    ]
] call EFUNC(gui,animButton)) params ["_ctrlButton", "_ctrlBackground"];
_ctrlButton ctrlSetText "A3\ui_f\data\gui\cfg\Hints\map_ca.paa";
_ctrlButton ctrlSetTooltip (localize LSTRING(MAP));
_ctrlButton ctrlAddEventHandler ["ButtonClick",format['[%1] call FUNC(openMap)',str _type]];
_ctrlBackground ctrlSetTextColor [COLOR_TELEPORT_BTTN_MAP_SQF];

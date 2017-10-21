/*
 *  Author: Dorbedo
 *
 *  Description:
 *      adds the interaction for the cargo-helper
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      none
 *
 */
#define INCLUDE_GUI
#define DEBUG_MODE_FULL
#include "script_component.hpp"


disableSerialization;
createDialog QAPP(helper);
private _display = (findDisplay 10000);
private _table = _display displayCtrl 10001;

(ctAddHeader _table) params ["_headerindex","_headercontrols"];
_headercontrols params ["_background","_headertext"];
_headertext ctrlsetText "Cargo Helper";


private _update_fnc = {
    TRACE("click");
    private _table = ((findDisplay 10000)displayCtrl 10001);
    private _curRow = ctCurSel _table;
    (_table ctRowControls _curRow) params ["_background","_text","_edit","_button"];
    private _value = parseNumber (ctrlText _edit);
    TRACEV_2(_edit,_value);
    if (_value isEqualType 0) then {
        private _var = [
            QGVAR(helper_cargo_w),
            QGVAR(helper_cargo_l),
            QGVAR(helper_cargo_h),
            QGVAR(helper_cargo_x),
            QGVAR(helper_cargo_y),
            QGVAR(helper_cargo_z)
        ] select _curRow;
        TRACEV_2(_var,_value);
        missionNamespace setVariable [_var,_value];
    };
};


(ctAddRow _table) params ["_index","_controls"];
_controls params ["_background","_text","_edit","_button"];
_text ctrlsetText "width";
_edit ctrlsetText str GVAR(helper_cargo_w);
_button ctrlsetText "ok";
_button ctrlAddEventHandler ["ButtonClick",_update_fnc];

(ctAddRow _table) params ["_index","_controls"];
_controls params ["_background","_text","_edit","_button"];
_text ctrlsetText "lenght";
_edit ctrlsetText str GVAR(helper_cargo_l);
_button ctrlsetText "ok";
_button ctrlAddEventHandler ["ButtonClick",_update_fnc];

(ctAddRow _table) params ["_index","_controls"];
_controls params ["_background","_text","_edit","_button"];
_text ctrlsetText "height";
_edit ctrlsetText str GVAR(helper_cargo_h);
_button ctrlsetText "ok";
_button ctrlAddEventHandler ["ButtonClick",_update_fnc];

(ctAddRow _table) params ["_index","_controls"];
_controls params ["_background","_text","_edit","_button"];
_text ctrlsetText "offset x";
_edit ctrlsetText str GVAR(helper_cargo_x);
_button ctrlsetText "ok";
_button ctrlAddEventHandler ["ButtonClick",_update_fnc];

(ctAddRow _table) params ["_index","_controls"];
_controls params ["_background","_text","_edit","_button"];
_text ctrlsetText "offset y";
_edit ctrlsetText str GVAR(helper_cargo_y);
_button ctrlsetText "ok";
_button ctrlAddEventHandler ["ButtonClick",_update_fnc];

(ctAddRow _table) params ["_index","_controls"];
_controls params ["_background","_text","_edit","_button"];
_text ctrlsetText "offset z";
_edit ctrlsetText str GVAR(helper_cargo_z);
_button ctrlsetText "ok";
_button ctrlAddEventHandler ["ButtonClick",_update_fnc];


private _targetBttn = _display ctrlCreate ["RscButton",9998];
_targetBttn ctrlsetText "Set Target";
_targetBttn ctrlAddEventHandler ["ButtonClick",
    {
        private _obj = cursorTarget;
        if (_obj isEqualType objNull) then {
            GVAR(helper_vehicle) = _obj;
            hint format ["New Vehicle = %1",typeOf GVAR(helper_vehicle)];
        };
    }];
_targetBttn ctrlSetPosition [
    SafeZoneX + GUI_DISP_W*3 * 1.5,
    SafeZoneY + GUI_DISP_H*3 * 19,
    GUI_DISP_W*3 * 5,
    GUI_DISP_H*3 * 2
];
_targetBttn ctrlCommit 0;

private _exportBttn = _display ctrlCreate ["RscButton",9999];
_exportBttn ctrlsetText "Export";
_exportBttn ctrlAddEventHandler ["ButtonClick",{[] call FUNC(helper_cargo_export)}];
_exportBttn ctrlSetPosition [
    SafeZoneX + GUI_DISP_W*3 * 7,
    SafeZoneY + GUI_DISP_H*3 * 19,
    GUI_DISP_W*3 * 5,
    GUI_DISP_H*3 * 2
];
_exportBttn ctrlCommit 0;




if !(isNil QGVAR(helper_pfh)) then {
    [GVAR(helper_pfh)] call CBA_fnc_removePerFrameHandler;
    {
        deleteVehicle _x;
    } forEach GVAR(helper_arrows);
    {
        deleteVehicle _x;
    } forEach GVAR(helper_passenger);
    GVAR(helper_passenger) = [];
    GVAR(helper_arrows) = [];
};

GVAR(helper_arrows) = [
    (createVehicle ["Sign_Arrow_F", [0,0,0], [], 0, "CANCOLLIDE"]),
    (createVehicle ["Sign_Arrow_Pink_F", [0,0,0], [], 0, "CANCOLLIDE"]),
    (createVehicle ["Sign_Arrow_Blue_F", [0,0,0], [], 0, "CANCOLLIDE"]),
    (createVehicle ["Sign_Arrow_Cyan_F", [0,0,0], [], 0, "CANCOLLIDE"]),
    (createVehicle ["Sign_Arrow_Green_F", [0,0,0], [], 0, "CANCOLLIDE"]),
    (createVehicle ["Sign_Arrow_Yellow_F", [0,0,0], [], 0, "CANCOLLIDE"])
    ];

GVAR(helper_pfh) = [{
    private["_pos"];
    private _cargo = GVAR(helper_vehicle);
    // center top
    _pos = _cargo modelToWorld [
        GVAR(helper_cargo_x),
        GVAR(helper_cargo_y),
        GVAR(helper_cargo_z)+(GVAR(helper_cargo_h)/2)
        ];
    (GVAR(helper_arrows) select 0) setPos _pos;
    //bottom
    _pos = _cargo modelToWorld [
        GVAR(helper_cargo_x) - (GVAR(helper_cargo_w)/2),
        GVAR(helper_cargo_y) - (GVAR(helper_cargo_l)/2),
        GVAR(helper_cargo_z)-(GVAR(helper_cargo_h)/2)
    ];
    (GVAR(helper_arrows) select 1) setPos _pos;
    //bottom
    _pos = _cargo modelToWorld [
        GVAR(helper_cargo_x) + (GVAR(helper_cargo_w)/2),
        GVAR(helper_cargo_y) - (GVAR(helper_cargo_l)/2),
        GVAR(helper_cargo_z)-(GVAR(helper_cargo_h)/2)
    ];
    (GVAR(helper_arrows) select 2) setPos _pos;
    //bottom
    _pos = _cargo modelToWorld [
        GVAR(helper_cargo_x) - (GVAR(helper_cargo_w)/2),
        GVAR(helper_cargo_y) + (GVAR(helper_cargo_l)/2),
        GVAR(helper_cargo_z)-(GVAR(helper_cargo_h)/2)
    ];
    (GVAR(helper_arrows) select 3) setPos _pos;
    //bottom
    _pos = _cargo modelToWorld [
        GVAR(helper_cargo_x) + (GVAR(helper_cargo_w)/2),
        GVAR(helper_cargo_y) + (GVAR(helper_cargo_l)/2),
        GVAR(helper_cargo_z)-(GVAR(helper_cargo_h)/2)
    ];
    (GVAR(helper_arrows) select 4) setPos _pos;
    // front top
    _pos = _cargo modelToWorld [
        GVAR(helper_cargo_x),
        GVAR(helper_cargo_y) - (GVAR(helper_cargo_l)/2),
        GVAR(helper_cargo_z)+(GVAR(helper_cargo_h)/2)
    ];
    (GVAR(helper_arrows) select 5) setPos _pos;

}, 0, []] call CBA_fnc_addPerFrameHandler;

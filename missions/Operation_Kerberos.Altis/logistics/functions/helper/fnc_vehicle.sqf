/*
 *  Author: Dorbedo
 *
 *  Description:
 *      adds the interaction for the veh-helper
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

/*
GVAR(helper_veh_w) = 0;
GVAR(helper_veh_h) = 0;
GVAR(helper_veh_l) = 0;
GVAR(helper_veh_x) = 0;
GVAR(helper_veh_y) = 0;
GVAR(helper_veh_z) = 0;
GVAR(helper_veh_load_x) = 0;
GVAR(helper_veh_load_y) = 0;
GVAR(helper_veh_load_z) = 0;
*/


disableSerialization;
createDialog QAPP(helper);
private _display = (findDisplay 10000);
private _table = _display displayCtrl 10001;

(ctAddHeader _table) params ["_headerindex","_headercontrols"];
_headercontrols params ["_background","_headertext"];
_headertext ctrlsetText "Vehicle Helper";


private _update_fnc = {
    TRACE("click");
    private _table = ((findDisplay 10000)displayCtrl 10001);
    private _curRow = ctCurSel _table;
    (_table ctRowControls _curRow) params ["_background","_text","_edit","_button"];
    private _value = parseNumber (ctrlText _edit);
    TRACEV_2(_edit,_value);
    if (_value isEqualType 0) then {
        private _var = [
            QGVAR(helper_veh_w),
            QGVAR(helper_veh_l),
            QGVAR(helper_veh_h),
            QGVAR(helper_veh_x),
            QGVAR(helper_veh_y),
            QGVAR(helper_veh_z),
            QGVAR(helper_veh_load_x),
            QGVAR(helper_veh_load_y),
            QGVAR(helper_veh_load_z)
        ] select _curRow;
        TRACEV_2(_var,_value);
        missionNamespace setVariable [_var,_value];
    };
};


(ctAddRow _table) params ["_index","_controls"];
_controls params ["_background","_text","_edit","_button"];
_text ctrlsetText "width";
_edit ctrlsetText str GVAR(helper_veh_w);
_button ctrlsetText "ok";
_button ctrlAddEventHandler ["ButtonClick",_update_fnc];

(ctAddRow _table) params ["_index","_controls"];
_controls params ["_background","_text","_edit","_button"];
_text ctrlsetText "lenght";
_edit ctrlsetText str GVAR(helper_veh_l);
_button ctrlsetText "ok";
_button ctrlAddEventHandler ["ButtonClick",_update_fnc];

(ctAddRow _table) params ["_index","_controls"];
_controls params ["_background","_text","_edit","_button"];
_text ctrlsetText "height";
_edit ctrlsetText str GVAR(helper_veh_h);
_button ctrlsetText "ok";
_button ctrlAddEventHandler ["ButtonClick",_update_fnc];

(ctAddRow _table) params ["_index","_controls"];
_controls params ["_background","_text","_edit","_button"];
_text ctrlsetText "offset x";
_edit ctrlsetText str GVAR(helper_veh_x);
_button ctrlsetText "ok";
_button ctrlAddEventHandler ["ButtonClick",_update_fnc];

(ctAddRow _table) params ["_index","_controls"];
_controls params ["_background","_text","_edit","_button"];
_text ctrlsetText "offset y";
_edit ctrlsetText str GVAR(helper_veh_y);
_button ctrlsetText "ok";
_button ctrlAddEventHandler ["ButtonClick",_update_fnc];

(ctAddRow _table) params ["_index","_controls"];
_controls params ["_background","_text","_edit","_button"];
_text ctrlsetText "offset z";
_edit ctrlsetText str GVAR(helper_veh_z);
_button ctrlsetText "ok";
_button ctrlAddEventHandler ["ButtonClick",_update_fnc];


(ctAddRow _table) params ["_index","_controls"];
_controls params ["_background","_text","_edit","_button"];
_text ctrlsetText "loadpoint x";
_edit ctrlsetText str GVAR(helper_veh_load_x);
_button ctrlsetText "ok";
_button ctrlAddEventHandler ["ButtonClick",_update_fnc];

(ctAddRow _table) params ["_index","_controls"];
_controls params ["_background","_text","_edit","_button"];
_text ctrlsetText "loadpoint y";
_edit ctrlsetText str GVAR(helper_veh_load_y);
_button ctrlsetText "ok";
_button ctrlAddEventHandler ["ButtonClick",_update_fnc];

(ctAddRow _table) params ["_index","_controls"];
_controls params ["_background","_text","_edit","_button"];
_text ctrlsetText "loadpoint z";
_edit ctrlsetText str GVAR(helper_veh_load_z);
_button ctrlsetText "ok";
_button ctrlAddEventHandler ["ButtonClick",_update_fnc];

private _targetBttn = _display ctrlCreate ["RscButton",9998];
_targetBttn ctrlsetText "Set Target";
_targetBttn ctrlAddEventHandler ["ButtonClick",
    {
        private _obj = cursorTarget;
        if (_obj isEqualType objNull) then {
            GVAR(helper_vehicle) = _obj;
            hint format ["New Vehicle = %1%2%3",
                typeOf GVAR(helper_vehicle),
                endl,
                getText(configFile >> "cfgVehicles" >> typeOf GVAR(helper_vehicle) >> "displayName")];

            GVAR(helper_passenger_pos) = [];
            for "_i" from 0 to ((GVAR(helper_vehicle) emptyPositions "cargo")-1) do {
                GVAR(helper_passenger_pos) set [_i,[]];
            };

            If (isClass(missionconfigfile >> "logistics" >> "vehicles" >> (typeOf GVAR(helper_vehicle)))) then {
                hint format ["Found Vehicle = %1%2%3",
                    typeOf GVAR(helper_vehicle),
                    endl,
                    getText(configFile >> "cfgVehicles" >> typeOf GVAR(helper_vehicle) >> "displayName")
                ];
                copyToClipboard format ["%1 %2",typeOf GVAR(helper_vehicle),getText(configFile >> "cfgVehicles" >> typeOf GVAR(helper_vehicle) >> "displayName")];
                GVAR(helper_veh_w) = getNumber(missionconfigfile >> "logistics" >> "vehicles" >> (typeOf GVAR(helper_vehicle)) >> "max_width");
                GVAR(helper_veh_l) = getNumber(missionconfigfile >> "logistics" >> "vehicles" >> (typeOf GVAR(helper_vehicle)) >> "max_length");
                GVAR(helper_veh_h) = getNumber(missionconfigfile >> "logistics" >> "vehicles" >> (typeOf GVAR(helper_vehicle)) >> "max_height");
                [getArray(missionconfigfile >> "logistics" >> "vehicles" >> (typeOf GVAR(helper_vehicle)) >> "cargo_point")] params [["_temp",[0,0,0],[[]],[3]]];
                GVAR(helper_veh_x) = _temp select 0;
                GVAR(helper_veh_y) = _temp select 1;
                GVAR(helper_veh_z) = _temp select 2;
                [getArray(missionconfigfile >> "logistics" >> "vehicles" >> (typeOf GVAR(helper_vehicle)) >> "load_point")] params [["_temp",[0,0,0],[[]],[3]]];
                GVAR(helper_veh_load_x) = _temp select 0;
                GVAR(helper_veh_load_y) = _temp select 1;
                GVAR(helper_veh_load_z) = _temp select 2;
            };

            closeDialog 10000;
            [] spawn FUNC(helper_vehicle);
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
_exportBttn ctrlAddEventHandler ["ButtonClick",{[] call FUNC(helper_vehicle_export)}];
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
    GVAR(helper_arrows) = [];
};

GVAR(helper_arrows) = [
    (createVehicle ["Sign_Arrow_F", [0,0,0], [], 0, "CANCOLLIDE"]),
    (createVehicle ["Sign_Arrow_Pink_F", [0,0,0], [], 0, "CANCOLLIDE"]),
    (createVehicle ["Sign_Arrow_Blue_F", [0,0,0], [], 0, "CANCOLLIDE"]),
    (createVehicle ["Sign_Arrow_Cyan_F", [0,0,0], [], 0, "CANCOLLIDE"]),
    (createVehicle ["Sign_Arrow_Green_F", [0,0,0], [], 0, "CANCOLLIDE"]),
    (createVehicle ["Sign_Arrow_Yellow_F", [0,0,0], [], 0, "CANCOLLIDE"]),
    (createVehicle ["Sign_Sphere25cm_F", [0,0,0], [], 0, "CANCOLLIDE"])
    ];

GVAR(helper_pfh) = [{
    private["_pos"];
    private _veh = GVAR(helper_vehicle);
    // center bottom front
    _pos = _veh modelToWorld [
        GVAR(helper_veh_x),
        GVAR(helper_veh_y),
        GVAR(helper_veh_z)
        ];
    (GVAR(helper_arrows) select 0) setPos _pos;
    //
    _pos = _veh modelToWorld [
        GVAR(helper_veh_x) + (GVAR(helper_veh_w)/2),
        GVAR(helper_veh_y),
        GVAR(helper_veh_z)
    ];
    (GVAR(helper_arrows) select 1) setPos _pos;
    //bottom
    _pos = _veh modelToWorld [
        GVAR(helper_veh_x) - (GVAR(helper_veh_w)/2),
        GVAR(helper_veh_y),
        GVAR(helper_veh_z)
    ];
    (GVAR(helper_arrows) select 2) setPos _pos;
    //bottom
    _pos = _veh modelToWorld [
        GVAR(helper_veh_x),
        GVAR(helper_veh_y) - GVAR(helper_veh_l),
        GVAR(helper_veh_z)
    ];
    (GVAR(helper_arrows) select 3) setPos _pos;
    //bottom
    _pos = _veh modelToWorld [
        GVAR(helper_veh_x),
        GVAR(helper_veh_y),
        GVAR(helper_veh_z) + GVAR(helper_veh_h)
    ];
    (GVAR(helper_arrows) select 4) setPos _pos;
    // front top
    _pos = _veh modelToWorld [
    GVAR(helper_veh_x) + (GVAR(helper_veh_w)/2),
    GVAR(helper_veh_y),
    GVAR(helper_veh_z) + GVAR(helper_veh_h)
    ];
    (GVAR(helper_arrows) select 5) setPos _pos;

    // front top
    _pos = _veh modelToWorld [
    GVAR(helper_veh_load_x),
    GVAR(helper_veh_load_y),
    GVAR(helper_veh_load_z)
    ];
    (GVAR(helper_arrows) select 6) setPos _pos;

}, 0, []] call CBA_fnc_addPerFrameHandler;

/*
    Cargo Positions

*/


private _AddBttn = _display ctrlCreate ["RscButton",9997];
_AddBttn ctrlsetText "Add VR-Men";
_AddBttn ctrlAddEventHandler ["ButtonClick",{[] call FUNC(helper_passenger)}];
_AddBttn ctrlSetPosition [
    SafeZoneX + GUI_DISP_W*3 * 1.5,
    SafeZoneY + GUI_DISP_H*3 * 21.5,
    GUI_DISP_W*3 * 5,
    GUI_DISP_H*3 * 2
];
_AddBttn ctrlCommit 0;

private _clearBttn = _display ctrlCreate ["RscButton",9996];
_clearBttn ctrlsetText "Clear VR-Men";
_clearBttn ctrlAddEventHandler ["ButtonClick",
    {
        {
            deleteVehicle _x;
        } forEach GVAR(helper_passenger)
    }];
_clearBttn ctrlSetPosition [
    SafeZoneX + GUI_DISP_W*3 * 7,
    SafeZoneY + GUI_DISP_H*3 * 21.5,
    GUI_DISP_W*3 * 5,
    GUI_DISP_H*3 * 2
];
_clearBttn ctrlCommit 0;



private _table = _display displayCtrl 11001;

(ctAddHeader _table) params ["_headerindex","_headercontrols"];
_headercontrols params ["_background","_headertext"];
_headertext ctrlsetText "Passenger Helper";

{
    (ctAddRow _table) params ["_index","_controls"];
    _controls params ["_background","_number","_checkbox"];
    _number ctrlsetText str _forEachIndex;
    _checkbox cbSetChecked (!(_x isEqualTo []));
} forEach GVAR(helper_passenger_pos);

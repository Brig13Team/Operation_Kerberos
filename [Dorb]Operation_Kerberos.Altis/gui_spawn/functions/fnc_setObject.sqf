/*
 *  Author: Dorbedo
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
#include "script_component.hpp"

_this params [["_vehicleType","",[""]]];

CHECK(_vehicleType isEqualTo "")

private _display = uiNamespace getVariable [QEGVAR(gui_Echidna,dialog),(findDisplay IDD_ECHIDNA_SPAWN)];
private _vehicleObject = _dialog displayCtrl IDC_ECHIDNA_SPAWN_VEHICLENAME;

If !(HASH_GET_DEF(GVAR(vehicleSpace),"objInitialized",false)) then {
    [_vehicleType] call FUNC(initVehicle);
};

private _model = HASH_GET_DEF(GVAR(vehicleSpace),"model","");
private _ctrlPos = HASH_GET(GVAR(vehicleSpace),"ctrlPos");
private _scale = HASH_GET(GVAR(vehicleSpace),"scale");

If (_model isEqualTo "") exitWith {
    ISNILS(GVAR(objecthandler),-1);
    _vehicleObject ctrlSetModel "\A3\Weapons_F\empty.p3d";
    [GVAR(objecthandler)] call CBA_fnc_removePerFrameHandler;
};

_ctrl ctrlSetPosition _ctrlPos;
_ctrl ctrlSetModel _model;
_ctrl ctrlSetModelScale _scale;

ISNILS(GVAR(objecthelper),objNull);
uiNamespace setVariable [QGVAR(ObjectCtrl),_ctrl];

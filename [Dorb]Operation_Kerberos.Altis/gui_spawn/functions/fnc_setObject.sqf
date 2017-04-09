/*
 *  Author: Dorbedo
 *
 *  Description:
 *      changes the vehicleobject to the the selected one
 *
 *  Parameter(s):
 *      0 : STRING - VehicleName
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_vehicleType","",[""]]];

CHECK(_vehicleType isEqualTo "")

private _dialog = uiNamespace getVariable [QEGVAR(gui_Echidna,dialog),(findDisplay IDD_ECHIDNA_SPAWN)];
private _vehicleObject = _dialog displayCtrl IDC_ECHIDNA_SPAWN_VEHICLEOBJECT;
TRACEV_2(_vehicleObject,_vehicleType);
private _vehicleHash = HASH_GET(GVAR(vehiclesHash),_vehicleType);

If !(HASH_GET_DEF(_vehicleHash,"objInitialized",false)) then {
    [_vehicleType] call FUNC(initVehicle);
};

private _model = HASH_GET_DEF(_vehicleHash,"model","");
private _ctrlPos = HASH_GET(_vehicleHash,"ctrlPos");
private _scale = HASH_GET(_vehicleHash,"scale");
TRACEV_3(_model,_ctrlPos,_scale);
If (_model isEqualTo "") exitWith {
    ISNILS(GVAR(objecthandler),-1);
    _vehicleObject ctrlSetModel "\A3\Weapons_F\empty.p3d";
    [GVAR(objecthandler)] call CBA_fnc_removePerFrameHandler;
};

_vehicleObject ctrlSetPosition _ctrlPos;
_vehicleObject ctrlSetModel _model;
_vehicleObject ctrlSetModelScale _scale;

ISNILS(GVAR(objecthelper),objNull);
uiNamespace setVariable [QGVAR(ObjectCtrl),_vehicleObject];

If ((isNil QGVAR(objecthandler))||{GVAR(objecthandler)<0}) then {
    [LINKFUNC(handleObject),0] call CBA_fnc_addPerFrameHandler;
};

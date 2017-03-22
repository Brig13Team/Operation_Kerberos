/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Handles the turning of the object container
 *      TODO: No helper Object should be needed. Just needs some calc magic.
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

private _ctrl = uiNamespace getVariable [QGVAR(ObjectCtrl),controlNull];
If (isNull _ctrl) exitWith {
    GVAR(objecthandler) = -1;
    [_this select 1] call CBA_fnc_removePerFrameHandler;
};

If (isNull GVAR(objecthelper)) then {
    GVAR(objecthelper) = "CBA_NamespaceDummy" createVehicleLocal [-10000,-10000,0];
    GVAR(objectStarttime) = CBA_missionTime;
};

GVAR(objecthelper) setDir (((diag_tickTime - GVAR(objectStarttime))mod 60) * 25);
GVAR(objecthelper) setVectorUp [0,-0.2,0.8];
_ctrl ctrlSetModelDirAndUp [
    vectorDir GVAR(objecthelper),
    vectorUP GVAR(objecthelper)
];

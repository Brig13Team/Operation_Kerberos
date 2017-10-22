/**
 * Author: Dorbedo
 * fills the vehicleslist
 *
 * Arguments:
 * 0: <DIALOG> sortorder
 *
 * Return Value:
 * Nothing
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_display"];

private _lnb = _display displayCtrl IDC_GUI_VEHICLESPAWN_VEHICLELIST;

lnbClear _lnb;
{
    _x params ["_modPicture", "_modName", "_vehiclePicture", "_vehicleName", "_vehicleClass"];
    private _rowIndex = _lnb lnbAddRow [_vehicleName, _modName];
    _lnb lnbSetData [[_rowIndex, 0], _vehicleClass];
    _lnb lnbSetData [[_rowIndex, 1], _modPicture];
    //_lnb lnbSetPicture [[_rowIndex, 1], _modPicture];
    _lnb lnbSetPicture [[_rowIndex, 0], _vehiclePicture];
    If (GVAR(curVeh) isEqualTo _vehicleClass) then {
        //_lnb lnbSetCurSelRow _rowIndex;
    };
} forEach (missionNamespace getVariable [QGVAR(curVehListFiltered), GVAR(curVehList)]);

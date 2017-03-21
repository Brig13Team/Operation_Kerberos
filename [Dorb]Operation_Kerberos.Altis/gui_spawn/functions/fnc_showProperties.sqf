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


private _display = uiNamespace getVariable [QEGVAR(gui_Echidna,dialog),(findDisplay IDD_ECHIDNA_SPAWN)];
private _ctrl = _display displayCtrl IDC_ECHIDNA_SPAWN_VEHICLEPROPERTIES;

lnbClear _ctrl;
CHECK(_vehicleType isEqualTo "")

private _vehicleHash = HASH_GET(GVAR(vehiclesHash),_vehicleType);
private _propertiesList = HASH_GET_DEF(_vehicleType,"propertiesList",[]);
{
    private _key = _x;
    private _value = HASH_GET(_vehicleHash,_key);
    private _name = localize format[LSTRING(PROPERTY_%1),_key];
    _ctrl lnbAddRow [_name,_value];
} forEach _propertiesList;

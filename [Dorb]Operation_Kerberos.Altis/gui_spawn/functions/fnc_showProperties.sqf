/*
 *  Author: Dorbedo
 *
 *  Description:
 *      displays the properties of the vehicle
 *
 *  Parameter(s):
 *      0 : STRING - VehicleType
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"


_this params [["_vehicleType","",[""]]];


private _dialog = uiNamespace getVariable [QEGVAR(gui_Echidna,dialog),(findDisplay IDD_ECHIDNA_SPAWN)];
private _ctrl = _dialog displayCtrl IDC_ECHIDNA_SPAWN_VEHICLEPROPERTIES;

lnbClear _ctrl;
CHECK(_vehicleType isEqualTo "")

private _vehicleHash = HASH_GET(GVAR(vehiclesHash),_vehicleType);
private _propertiesList = HASH_GET_DEF(_vehicleHash,"propertiesList",[]);
TRACEV_1(_propertiesList);
{
    private _key = _x;
    private _value = HASH_GET(_vehicleHash,_key);

    private _LocalizeString = format[LSTRING(PROPERTY_%1),_key];
    private _name = If (isLocalized _LocalizeString) then {localize _LocalizeString}else{""};
    TRACEV_3(_ctrl,_name,_value);
    _ctrl lnbAddRow [_name,format["%1",_value]];
} forEach _propertiesList;
nil;

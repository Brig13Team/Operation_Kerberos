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
#define DEBUG_MODE_FULL
#include "script_component.hpp"


private _dialog = uiNamespace getVariable [QEGVAR(gui_Echidna,dialog),(findDisplay IDD_ECHIDNA_SPAWN)];
private _ctrl = _dialog displayCtrl IDC_ECHIDNA_SPAWN_VEHICLELIST;


lnbClear _ctrl;

private _vehicleList = [] call FUNC(getVehicleList);
TRACEV_1(_vehicleList);
{
    private _vehicleArray = _x;
    (_vehicleArray) params ["_content","_picture","_vehicleType"];
    private _rowindex = _ctrl lnbAddRow _content;
    _ctrl lnbSetData [[_rowindex, 0], _vehicleType];
    If !(_picture in ["iconstaticmg","iconstaticmortar","iconcrate","iconstaticaa","iconobject_2x1","iconobject_circle","iconcrateord"]) then {
        _ctrl lnbSetPicture [[_rowindex, 0], _picture];
    };    
} forEach _vehicleList;

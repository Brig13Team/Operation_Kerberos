/*
 *  Author: [Name of Author(s)]
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

private _display = uiNamespace getVariable [QEGVAR(gui_Echidna,dialog),(findDisplay IDD_ECHIDNA_MAIN)];
private _ctrlGrp = _display displayCtrl IDC_FDC_INFO_GRP;
private _ctrl = _display ctrlCreate ["RscListNBox", (IDC_FDC_INFO_GRP + 1), _ctrlGrp];
private _ctrlGrpPos = ctrlPosition _ctrlGrp;
private _ctrlPos = [(_ctrlGrpPos select 2)*0.1,(_ctrlGrpPos select 2)*0.2,(_ctrlGrpPos select 2)*0.8,(_ctrlGrpPos select 1)-(_ctrlGrpPos select 2)*0.2];
_ctrl ctrlSetPosition _ctrlPos;

lnbClear _ctrl;
{
    private _key = _x;
    (HASH_GET(GVAR(info_protection),_key)) params ["_var1","_var2","_var3"];
    _ctrl lnbAddRow [_key,_var1,_var2,_var3];
} forEach ["CODE","1","2","3","4","5","6"];

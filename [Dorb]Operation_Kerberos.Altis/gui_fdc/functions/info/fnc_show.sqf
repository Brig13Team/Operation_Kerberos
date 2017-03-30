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

ISNILS(GVAR(currentInfoCtrls),[]);

private _display = uiNamespace getVariable [QEGVAR(gui_Echidna,dialog),(findDisplay IDD_ECHIDNA_MAIN)];
private _ctrlGrp = _display displayCtrl IDC_FDC_INFO_GRP;
private _ctrl = _display ctrlCreate ["RscListNBox", (IDC_FDC_INFO_GRP + 1), _ctrlGrp];
private _ctrlGrpPos = ctrlPosition _ctrlGrp;
private _ctrlPos = [(_ctrlGrpPos select 2)*0.1,(_ctrlGrpPos select 2)*0.2,(_ctrlGrpPos select 2)*0.8,(_ctrlGrpPos select 1)-(_ctrlGrpPos select 2)*0.2];
_ctrl ctrlSetPosition _ctrlPos;

lnbClear _ctrl;
{
    private _key = _x;
    (HASH_GET(GVAR(info_targetType),_key)) params ["_class","_type"];
    _ctrl lnbAddRow [_key,_class,_type];
} forEach ["01","02","03","04","05","06","00","07","08","09","10","11","12","00","13","14","15","16","17","00","18","19","20","21","22",
"00","23","24","25","26","27","28","00","29","30","31","32","33","34","35","36","37","00","38","39","40","41","42","43","00",
"44","45","46","47","48","49","00","50","51","52","53","54","55","00","56","57","58","59","60","61","00","62","63","64","65",
"66","67","68","00","69","70","71","72","73","74","00","75","76","77","78","79","80","81","00","82","83","84","85","86","87",
"88","00","89","90","91","92","93"];

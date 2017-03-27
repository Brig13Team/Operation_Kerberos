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
private _ctrlGrp = _display displayCtrl IDC_ARTILLERY_PARAMS;
private _ctrlAmmo = _ctrlGrp controlsGroupCtrl IDC_ARTILLERY_PARAMS_AMMO;
private _ctrlFuze = _ctrlGrp controlsGroupCtrl IDC_ARTILLERY_PARAMS_FUZE;


private _curAmmo = _ctrlAmmo lbData (lbCurSel _ctrlAmmo);
private _allFuzes = [_curAmmo] call FUNC(getFuzeFromAmmo);

private _allValues = [];
lbClear _ctrlFuze;
{
    private _name = localize format[LSTRING(FUZE_%1),_x];
    private _index = _ctrlFuze lbAdd _name;
    _ctrlFuze lbSetValue [_index, _x];
    _allValues pushBack _x;
} forEach _allFuzes;
_ctrlFuze setVariable ["values",_allValues];
_ctrlFuze lbSetCurSel 0;

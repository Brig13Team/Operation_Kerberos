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
#define DEBUG_MODE_FULL
#include "script_component.hpp"

private _reloadtime = 12; //TODO evaluate this time
private _lastShot = GVAR(curArtillery) getVariable [QGVAR(lastShot),-100];
If ((_lastShot + _reloadtime)<CBA_missiontime) then {
    GVAR(curArtillery) setVariable [QGVAR(lastShot),CBA_missiontime - 8];
};

GVAR(curArtillery) setVariable [QGVAR(lastShot),CBA_missiontime - 4];

private _display = uiNamespace getVariable [QEGVAR(gui_Echidna,dialog),(findDisplay IDD_ECHIDNA_MAIN)];
private _ctrlGrp = _display displayCtrl IDC_ARTILLERY_PARAMS;
private _ctrl = _ctrlGrp controlsGroupCtrl IDC_ARTILLERY_PARAMS_MILS;
private _mils = parseNumber(ctrlText _ctrl);
private _ctrl = _ctrlGrp controlsGroupCtrl IDC_ARTILLERY_PARAMS_ELEVATION;
private _elevation = parseNumber(ctrlText _ctrl);

private _ctrl = _ctrlGrp controlsGroupCtrl IDC_ARTILLERY_PARAMS_AMMO;
private _ammo = _ctrl lbData (lbCurSel _ctrl);
private _ctrl = _ctrlGrp controlsGroupCtrl IDC_ARTILLERY_PARAMS_CHARGE;
private _charge = _ctrl lbValue (lbCurSel _ctrl);
private _ctrl = _ctrlGrp controlsGroupCtrl IDC_ARTILLERY_PARAMS_FUZE;
private _fuze = _ctrl lbValue (lbCurSel _ctrl);


private _dummyPos = [_mils,_elevation] call FUNC(getDummyPos);
private _velocity = [_ammo,_charge] call FUNC(getMuzzleVelo);
TRACEV_1(_dummyPos);

GVAR(curArtillery) setVariable [QGVAR(cur_dummyPos),_dummyPos];
GVAR(curArtillery) setVariable [QGVAR(cur_velocity),_velocity];
GVAR(curArtillery) setVariable [QGVAR(cur_fuze),_fuze];

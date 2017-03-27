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
#define INCLUDE_GUI
#include "script_component.hpp"


TRACE("adding");


If !([] call FUNC(checkInput)) exitWith {};

disableSerialization;

private _lastID = (GVAR(curArtillery) getVariable [QGVAR(lastID),0]) + 1;
GVAR(curArtillery) setVariable [QGVAR(lastID),_lastID];
private _newHash = HASH_CREATE;
private _localOrd = GVAR(curArtillery) getVariable [QGVAR(localorders),[]];
_localOrd pushBack _newHash;
GVAR(curArtillery) setVariable [QGVAR(localorders),_localOrd];

private _id = format["%1",_lastID];
while {(count _id) < 4} do {
    _id = format["0%1",_id];
};
private _id = format["**-%1",_id];

HASH_SET(_newHash,"ID",_id);

private _display = uiNamespace getVariable [QEGVAR(gui_Echidna,dialog),(findDisplay IDD_ECHIDNA_MAIN)];
private _ctrlGrp = _display displayCtrl IDC_ARTILLERY_LOCATION;
private _ctrl = _ctrlGrp controlsGroupCtrl IDC_ARTILLERY_LOCATION_EAST;
private _value = ctrlText _ctrl;
HASH_SET(_newHash,"east",_value);
private _ctrl = _ctrlGrp controlsGroupCtrl IDC_ARTILLERY_LOCATION_NORTH;
private _value = ctrlText _ctrl;
HASH_SET(_newHash,"north",_value);
private _ctrl = _ctrlGrp controlsGroupCtrl IDC_ARTILLERY_LOCATION_ALT;
private _value = ctrlText _ctrl;
HASH_SET(_newHash,"altitude",_value);
private _ctrlGrp = _display displayCtrl IDC_ARTILLERY_PARAMS;
private _ctrl = _ctrlGrp controlsGroupCtrl IDC_ARTILLERY_PARAMS_MILS;
private _value = ctrlText _ctrl;
HASH_SET(_newHash,"mils",_value);
private _ctrl = _ctrlGrp controlsGroupCtrl IDC_ARTILLERY_PARAMS_ELEVATION;
private _value = ctrlText _ctrl;
HASH_SET(_newHash,"elevation",_value);
private _ctrl = _ctrlGrp controlsGroupCtrl IDC_ARTILLERY_PARAMS_AMMO;
private _value = _ctrl lbData (lbCurSel _ctrl);
HASH_SET(_newHash,"ammo",_value);
private _ctrl = _ctrlGrp controlsGroupCtrl IDC_ARTILLERY_PARAMS_CHARGE;
private _value = _ctrl lbValue (lbCurSel _ctrl);
HASH_SET(_newHash,"charge",_value);
private _ctrl = _ctrlGrp controlsGroupCtrl IDC_ARTILLERY_PARAMS_FUZE;
private _value = _ctrl lbValue (lbCurSel _ctrl);
HASH_SET(_newHash,"fuze",_value);
private _ctrl = _ctrlGrp controlsGroupCtrl IDC_ARTILLERY_PARAMS_TTS;
private _value = ctrlText _ctrl;
HASH_SET(_newHash,"tts",_value);

[] call FUNC(showOrder);

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
#define INCLUDE_GUI
#include "script_component.hpp"

private _display = uiNamespace getVariable [QEGVAR(gui_Echidna,dialog),(findDisplay IDD_ECHIDNA_MAIN)];
private _ctrlGrp = _display displayCtrl IDC_ARTILLERY_NETWORK;
private _orderlist = _ctrlGrp controlsGroupCtrl IDC_ARTILLERY_NETWORK_ORDERLIST;

private _allHashes = _orderlist getVariable [QGVAR(orders),[]];
CHECK(_allHashes isEqualTo [])
private _curHash = lnbCurSelRow _orderlist;
CHECK(_curHash < 0)

_curHash = _allHashes select _curHash;


private _ctrlGrp = _display displayCtrl IDC_ARTILLERY_LOCATION;
private _ctrl = _ctrlGrp controlsGroupCtrl IDC_ARTILLERY_LOCATION_EAST;
private _value = ctrlSetText HASH_GET(_newHash,"east");
HASH_SET(_newHash,"east",_value);

private _ctrl = _ctrlGrp controlsGroupCtrl IDC_ARTILLERY_LOCATION_NORTH;
private _value = ctrlSetText HASH_GET(_newHash,"north");
private _value = ctrlText _ctrl;
HASH_SET(_newHash,"north",_value);

private _ctrl = _ctrlGrp controlsGroupCtrl IDC_ARTILLERY_LOCATION_ALT;
private _value = ctrlText _ctrl;
private _value = ctrlSetText HASH_GET(_newHash,"altitude");
HASH_SET(_newHash,"altitude",_value);


private _ctrlGrp = _display displayCtrl IDC_ARTILLERY_PARAMS;
private _ctrl = _ctrlGrp controlsGroupCtrl IDC_ARTILLERY_PARAMS_MILS;
private _value = ctrlSetText HASH_GET(_newHash,"mils");

private _ctrl = _ctrlGrp controlsGroupCtrl IDC_ARTILLERY_PARAMS_ELEVATION;
private _value = ctrlSetText HASH_GET(_newHash,"elevation");

private _ctrl = _ctrlGrp controlsGroupCtrl IDC_ARTILLERY_PARAMS_AMMO;
private _value = ctrlSetText HASH_GET(_newHash,"ammo");
private _values = _ctrl getVariable ["values"];
private _index = _values find _value;
private _value = _ctrl lbSetCurSel _index;

private _ctrl = _ctrlGrp controlsGroupCtrl IDC_ARTILLERY_PARAMS_CHARGE;
private _value = ctrlSetText HASH_GET(_newHash,"charge");
private _values = _ctrl getVariable ["values"];
private _index = _values find _value;
private _value = _ctrl lbSetCurSel _index;

private _ctrl = _ctrlGrp controlsGroupCtrl IDC_ARTILLERY_PARAMS_FUZE;
private _value = ctrlSetText HASH_GET(_newHash,"fuze");
private _values = _ctrl getVariable ["values"];
private _index = _values find _value;
private _value = _ctrl lbSetCurSel _index;

private _ctrl = _ctrlGrp controlsGroupCtrl IDC_ARTILLERY_PARAMS_TTS;
private _value = ctrlSetText HASH_GET(_newHash,"tts");

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

private _display = uiNamespace getVariable [QEGVAR(gui_Echidna,dialog),(findDisplay IDD_ECHIDNA_MAIN)];
private _ctrlGrp = _display displayCtrl IDC_ARTILLERY_NETWORK;
private _orderlist = _ctrlGrp controlsGroupCtrl IDC_ARTILLERY_NETWORK_ORDERLIST;

private _allHashes = _orderlist getVariable [QGVAR(orders),[]];
CHECK(_allHashes isEqualTo [])
private _curHash = lnbCurSelRow _orderlist;
CHECK(_curHash < 0)

_curHash = _allHashes select _curHash;
TRACE("settingValues");

private _ctrlGrp = _display displayCtrl IDC_ARTILLERY_LOCATION;
private _ctrl = _ctrlGrp controlsGroupCtrl IDC_ARTILLERY_LOCATION_USECURRENT;
_ctrl cbSetChecked false;
[_ctrl] call FUNC(onCheckedChangedLoc);

private _ctrl = _ctrlGrp controlsGroupCtrl IDC_ARTILLERY_LOCATION_EAST;
_ctrl ctrlSetText HASH_GET(_curHash,"east");
private _ctrl = _ctrlGrp controlsGroupCtrl IDC_ARTILLERY_LOCATION_NORTH;
_ctrl ctrlSetText HASH_GET(_curHash,"north");
private _ctrl = _ctrlGrp controlsGroupCtrl IDC_ARTILLERY_LOCATION_ALT;
_ctrl ctrlSetText HASH_GET(_curHash,"altitude");


private _ctrlGrp = _display displayCtrl IDC_ARTILLERY_PARAMS;
private _ctrl = _ctrlGrp controlsGroupCtrl IDC_ARTILLERY_PARAMS_MILS;
_ctrl ctrlSetText HASH_GET(_curHash,"mils");

private _ctrl = _ctrlGrp controlsGroupCtrl IDC_ARTILLERY_PARAMS_ELEVATION;
_ctrl ctrlSetText HASH_GET(_curHash,"elevation");

private _ctrl = _ctrlGrp controlsGroupCtrl IDC_ARTILLERY_PARAMS_AMMO;
private _value = HASH_GET(_curHash,"ammo");
private _values = _ctrl getVariable "values";
private _index = _values find HASH_GET(_curHash,"ammo");
_ctrl lbSetCurSel _index;
TRACEV_3(_values,_value,_index);
[] call FUNC(showFuze);

private _ctrl = _ctrlGrp controlsGroupCtrl IDC_ARTILLERY_PARAMS_CHARGE;
private _values = _ctrl getVariable "values";
private _index = _values find HASH_GET(_curHash,"charge");
_ctrl lbSetCurSel _index;

private _ctrl = _ctrlGrp controlsGroupCtrl IDC_ARTILLERY_PARAMS_FUZE;
private _values = _ctrl getVariable "values";
private _index = _values find HASH_GET(_curHash,"fuze");
_ctrl lbSetCurSel _index;

private _ctrl = _ctrlGrp controlsGroupCtrl IDC_ARTILLERY_PARAMS_TTS;
_ctrl ctrlSetText HASH_GET_DEF(_curHash,"tts","");

[] call FUNC(checkInput);
_display setVariable ["ismodified",false];

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

private _localHashes = GVAR(curArtillery) getVariable [QGVAR(localorders),[]];
if !(_curHash in _localHashes) exitWith {};

_localHashes = _localHashes - [_curHash];
GVAR(curArtillery) setVariable [QGVAR(localorders),_localHashes];

/*
 *  Author: Dorbedo
 *
 *  Description:
 *      centers the backgroundmap at a definied position
 *      TODO: Center the shown Map -> eg. right side or left side or all
 *
 *  Parameter(s):
 *      0 : ARRAY - the position to center the map at
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_centerposition",[],[[]],[2,3]]];

CHECK(_centerposition isEqualTo [])

private _display = uiNamespace getVariable [QEGVAR(gui_Echidna,dialog),(findDisplay IDD_ECHIDNA_MAIN)];
private _mapCtrl = _display displayCtrl IDC_FDC_MAP;

_mapCtrl ctrlMapAnimAdd [0.5, 0.1, _centerposition];
ctrlMapAnimCommit _mapCtrl;

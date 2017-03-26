/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Displays the right background for the echidna display
 *
 *  Parameter(s):
 *      0 : CONTROL - the control of the background
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#define INCLUDE_GUI
#include "script_component.hpp"

disableSerialization;
_this params [["_display",controlNull]];
TRACEV_1(_display);
private _ctrl = _display displayCtrl IDC_ECHIDNA_BACKGROUND_DEVICE;

If (vehicle ace_player == ace_player) then {
    _ctrl ctrlSetText QEPAAPATH(echidna,background_tablet);
    _ctrl ctrlSetPosition [
        GUI_ECHIDNA_X - GUI_ECHIDNA_W * 6.92,
        GUI_ECHIDNA_Y - GUI_ECHIDNA_H * 11.92,
        GUI_ECHIDNA_WAbs + GUI_ECHIDNA_W * 13.9,
        GUI_ECHIDNA_HAbs + GUI_ECHIDNA_H * 23.85
    ];
    _ctrl ctrlSetBackgroundColor [1,1,1,0];
    _ctrl ctrlSetTextColor [1,1,1,1];
}else{
    _ctrl ctrlSetText QEPAAPATH(echidna,background_vehicle);
    _ctrl ctrlSetPosition [
        GUI_ECHIDNA_X - GUI_ECHIDNA_W * 3.35,
        GUI_ECHIDNA_Y - GUI_ECHIDNA_H * 8.4,
        GUI_ECHIDNA_WAbs + GUI_ECHIDNA_W * 6.7,
        GUI_ECHIDNA_HAbs + GUI_ECHIDNA_H * 16.78
    ];
    _ctrl ctrlSetBackgroundColor [1,1,1,0];
    _ctrl ctrlSetTextColor [1,1,1,1];
};
_ctrl ctrlCommit 0;

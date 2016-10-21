/*
 *  Author: Dorbedo
 *
 *  Description:
 *      adds a Message to the Message-Log
 *
 *  Parameter(s):
 *      0 : STRING - Header
 *      1 : STRING - Header
 *      2 : ARRAY - Color
 *
 *  Returns:
 *      none
 *
 */
#define INCLUDE_GUI
#include "script_component.hpp"

_this params [["_header","",[""]],["_content","",[""]],["_color",[RAL10001,1],[[]],[4]],["_dialog",false,[true]]];
GVAR(newMessage) = _dialog;
// TODO playSound
GVAR(allMessages) pushBack [_header,_content,_color,_dialog];

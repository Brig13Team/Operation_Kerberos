/*
 *  Author: Dorbedo
 *
 *  Description:
 *      start downloading
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

[QEGVAR(gui,message),LSTRING(OBJ_DATATERMINAL_DOWNLOAD_MSG_TITLE),LSTRING(OBJ_DATATERMINAL_DOWNLOAD_MSG)] call CBA_fnc_localEvent;

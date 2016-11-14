/*
 *  Author: DOrbedo
 *
 *  Description:
 *      removes a notification
 *
 *  Parameter(s):
 *      0 : STRING - notificationID
 *
 *  Returns:
 *      none
 *
 */
#include "script_component.hpp"
_this params [["_ID","",["",0]]];

If !(IS_STRING(_ID)) then {
    _ID = format ["%1",_ID];
};

CHECK(_ID isEqualTo "")

HASH_REM(GVAR(notifications),_ID);

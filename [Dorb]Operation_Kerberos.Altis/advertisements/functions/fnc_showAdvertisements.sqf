/*
 *  Author: Dorbedo
 *
 *  Description:
 *      shows the adverts
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      none
 *
 */
#include "script_component.hpp"
{
    _x params [["_header","",[""]],["_content","",[""]]];
    [
        _header,
        _content
    ] call EFUNC(gui,message);
    uisleep 30;
} forEach GVAR(advertisements);

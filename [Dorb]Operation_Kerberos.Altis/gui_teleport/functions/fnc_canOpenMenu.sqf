/*
 *  Author: Dorbedo
 *
 *  Description:
 *      User can open the Menu
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      BOOL - isallowed to open the Menu
 *
 */
#include "script_component.hpp"

((
    {
        (player distance _x) < 7
    } count GVAR(teleporterlogics)
)>0)

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
        (ace_player distance _x) < 12
    } count GVAR(teleporterlogics)
)>0)

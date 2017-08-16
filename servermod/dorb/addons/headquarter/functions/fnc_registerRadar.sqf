/**
 *  Author: Dorbedo
 *
 *  Description:
 *      registers a radar
 *
 *  Parameter(s):
 *      0 : OBJECT - the redar to register
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_radar",objNull,[objNull]]];
CHECK(isNull _radar)

HASH_GET(GVAR(radars),"objects") pushBackUnique _radar;

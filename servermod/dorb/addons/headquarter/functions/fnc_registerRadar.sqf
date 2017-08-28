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

private _radarposition = getPosASL _radar;
private _height = ((boundingBox _radar) select 1) select 2;
_radarposition set [2,(_radarposition + _height + 0.3)];

_radar setVariable [QGVAR(radarpos),_radarposition];

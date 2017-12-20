/*
 *  Author: Dorbedo
 *
 *  Description:
 *      returns the nearest waypoint
 *
 *  Parameter(s):
 *      0 : ARRAY - the position
 *
 *  Returns:
 *      STRING - the waypoint key
 *
 */
#include "script_component.hpp"

_this params[
    ["_position",[],[[]]]
    ];
TRACEV_1(_position);
private _raster = getNumber(ConfigFile >> "CfgKerberos" >> "worlds" >> worldName >> "wayoints" >> "raster");

TRACEV_1(_raster);
private _keyX = round(((_position select 0)-_raster*0.5)/_raster)*(_raster/10);
private _keyY = round(((_position select 1)-_raster*0.5)/_raster)*(_raster/10);


format["%1_%2",_keyX,_keyY];

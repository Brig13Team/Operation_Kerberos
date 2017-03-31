/*
 *  Author: Dorbedo
 *
 *  Description:
 *      [Description]
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

_this params [["_position",[],[[]],[2,3]],["_text","",[""]],["_color","ColorRed",[""]],["_type","mil_box",[""]]];

if !(isClass(configFile >> "CfgMarkerColors" >> _color)) then {_color = "ColorBlack";};
if !(isClass(configFile >> "CfgMarkers" >> _type)) then {_type = "mil_box";};

private _mark = createMarkerLocal [format[QGVAR(tempMarker_%1),count GVAR(tempMarker)],_position];
GVAR(tempMarker) pushBack _mark;
_mark setMarkerShapeLocal "ICON";
_mark setMarkerTypeLocal _type;
_mark setMarkerColorLocal _color;
_mark setMarkerTextLocal _text;
_mark;

/*
 *  Author: Dorbedo
 *
 *  Description:
 *      creates a tracking marker
 *
 *  Parameter(s):
 *      0 : GROUP - GroupID
 *
 *  Returns:
 *      none
 *
 */
#include "script_component.hpp"

_this params [["_group",grpNull,[grpNull]]];
If ((isNull _group)||(!alive(leader _group))) exitWith {""};

private _groupID = groupID _group;

private _position = HASH_GET(_groupHash,"positions") select 0;
private _symbolpost = HASH_GET(_groupHash,"symbol") select 0;
private _symbol = HASH_GET(_grouphash,"prefix") + _symbolpost;
private _size = HASH_GET(_groupHash,"size") select 0;

private _markername = format[QGVAR(%1_%2),side _group,_groupID];
private _marker1 = createMarkerLocal [_markername,_position];
HASH_SET(_groupHash,"marker1",_markername);
GVAR(allMarker) pushBack _marker1;

private _markername = format[QGVAR(%1_%2_size),side _group,_groupID];
private _marker2 = createMarkerLocal [_markername,_position];
HASH_SET(_groupHash,"marker2",_markername);
GVAR(allMarker) pushBack _marker2;

_marker1 setMarkerShapeLocal "ICON";
_marker1 setMarkerColorLocal HASH_GET(_groupHash,"color");
_marker2 setMarkerShapeLocal "ICON";
_marker2 setMarkerColorLocal "ColorBlack";

If (_position isEqualTo [0,0,0]) exitWith {};

_marker1 setMarkerTypeLocal _symbol;
_marker1 setMarkerTextLocal _groupID;
_marker2 setMarkerTypeLocal _size;

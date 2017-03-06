/*
 *  Author: Dorbedo
 *
 *  Description:
 *      deletes a groupmarker
 *
 *  Parameter(s):
 *      0 : HASH - grouphash
 *
 *  Returns:
 *      none
 *
 */
#include "script_component.hpp"

_this params ["_groupHash"];

private _marker1 = HASH_GET_DEF(_groupHash,"marker1","");
private _marker2 = HASH_GET_DEF(_groupHash,"marker2","");

deleteMarkerLocal _marker1;
deleteMarkerLocal _marker2;

GVAR(allMarker) = GVAR(allMarker) - [_marker1];
GVAR(allMarker) = GVAR(allMarker) - [_marker2];

HASH_SET(_groupHash,"marker1",nil);
HASH_SET(_groupHash,"marker2",nil);

/*
    Author: Dorbedo

    Description:
        deletes the debug_markers
    
*/
#include "script_component.hpp"
ISNILS(GVARMAIN(debug_marker),[]);
private _remove = GVARMAIN(debug_marker);
GVARMAIN(debug_marker) = [];
{deleteMarkerLocal _x} count _remove;
nil;
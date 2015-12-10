/*
	Author: Dorbedo

	Description:
		deletes the debug_markers
	
*/
#include "script_component.hpp"
SCRIPT(debug_marker_create);

ISNILS(GVARMAIN(debug_marker),[]);
private _remove = GVARMAIN(debug_marker);
GVARMAIN(debug_marker) = [];
_remove TILGE;

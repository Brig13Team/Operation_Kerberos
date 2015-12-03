/*
	Author: Dorbedo
	
	Description:
		test waypoints
	
	Parameter(s):
		none

	Returns:
		none
*/
#include "script_component.hpp"
SCRIPT(waypoints_test);

ISNILS(GVARMAIN(debug_marker),[]);
ISNILS(GVAR(waypoints),[]);
if (isNil QGVAR(definitions)) then {
	[] call EFUNC(ai,init);
};

GVAR(centerpos) = getMarkerPos "testmarker";

[] call EFUNC(common,debug_marker_clean);
GVAR(waypoints) TILGE;

hint "wegpunkte geloescht";

_script = [] execVM "ai\functions\waypoints_create.sqf"; //FUNC(waypoints_create);

Waituntil {scriptDone _script};
hint "wegpunkte fertig"

_script = [] execVM "ai\functions\waypoints_generate.sqf";

Waituntil {scriptDone _script};
hint "Weight fertig"
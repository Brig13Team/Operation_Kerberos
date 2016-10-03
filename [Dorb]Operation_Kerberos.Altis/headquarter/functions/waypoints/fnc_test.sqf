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

ISNILS(GVARMAIN(debug_marker),[]);
ISNILS(GVAR(waypoints),[]);
if (isNil QGVAR(definitions)) then {
    [] call FUNC(init);
};

GVAR(centerpos) = getMarkerPos "testmarker";

[] call EFUNC(common,debug_marker_clean);
GVAR(waypoints) TILGE;

hint "wegpunkte geloescht";

//_script = [] execVM "ai\functions\waypoints_create.sqf"; //FUNC(waypoints_create);

//Waituntil {scriptDone _script};
hint "wegpunkte fertig";

{
    HASH_SET(GVAR(waypoints),_x,2);
}forEach ["1450_1550","1450_1600","1450_1650","1450_1700","1500_1700","1550_1700","1600_1700","1600_1600","1600_1650"];

{
    HASH_SET(GVAR(waypoints),_x,4);
}forEach ["1500_1600","1500_1650","1550_1600","1550_1650"];


_script = [getMarkerPos "startmarker",getMarkerPos "zielmarker",true] execVM "ai\functions\fnc_waypoints_generate.sqf";

hint "Weight fertig";
_script;

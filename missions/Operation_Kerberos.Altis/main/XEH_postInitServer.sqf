/*
 *  Author: Dorbedo
 *
 *  Description:
 *      server post-init
 *
 */
#include "script_component.hpp"

// prevent some crashes
If (isNil QGVARMAIN(respawnmarker)||{(getMarkerPos GVARMAIN(respawnmarker)) isEqualTo [0,0,0]}) then {
    ERROR("No respawn placed");
    GVARMAIN(respawnmarker) = QGVAR(crashmarker1);
    createMarkerLocal [GVARMAIN(respawnmarker), [-10000,-10000]];
};
If (isNil QGVARMAIN(rescuemarker)||{(getMarkerPos GVARMAIN(rescuemarker)) isEqualTo [0,0,0]}) then {
    ERROR("No rescuemarker placed");
    GVARMAIN(rescuemarker) = QGVAR(crashmarker3);
    createMarkerLocal [GVARMAIN(rescuemarker), [-10000,-10000]];
};
If (isNil QGVARMAIN(side)) then {
    GVARMAIN(playerside) = west;
    GVARMAIN(side) = east;
};

GVARMAIN(missionkey) = format ["Missionkey:%1",random(100000)];
publicVariable QGVARMAIN(missionkey);

/*
 *  Author: Dorbedo
 *
 *  Description:
 *      server post-init
 *
 */
#include "script_component.hpp"

setTimeMultiplier 2;
// prevent some crashes
If (isNil QGVARMAIN(respawnmarker)||{(getMarkerPos GVARMAIN(respawnmarker)) isEqualTo [0,0,0]}) then {
    ERROR("No respawn placed");
    GVARMAIN(respawnmarker) = QGVAR(crashmarker1);
    createMarkerLocal [GVARMAIN(respawnmarker), [-10000,-10000]];
};
If (isNil QGVARMAIN(AIRFIELD)||{(getMarkerPos GVARMAIN(AIRFIELD)) isEqualTo [0,0,0]}) then {
    ERROR("No airfield placed");
    GVARMAIN(AIRFIELD) = QGVAR(crashmarker2);
    createMarkerLocal [GVARMAIN(AIRFIELD), [-10000,-10000]];
};
If (isNil QGVARMAIN(rescuemarker)||{(getMarkerPos GVARMAIN(rescuemarker)) isEqualTo [0,0,0]}) then {
    ERROR("No rescuemarker placed");
    GVARMAIN(rescuemarker) = QGVAR(crashmarker3);
    createMarkerLocal [GVARMAIN(rescuemarker), [-10000,-10000]];
};

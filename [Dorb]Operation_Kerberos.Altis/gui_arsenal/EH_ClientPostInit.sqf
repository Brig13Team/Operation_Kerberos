/*
    Author: Dorbedo

    Description:
        postinit client
*/
#include "script_component.hpp"

CHECK(!hasInterface)

/*
 *  Set the Variables
 *  In addition to the arsenals added via FUNC(addArsenal)
 */

GVAR(fullArsenal) = false;
/*
 *  0 - full Arsenal (default)
 *  1 - Restricted Arsenal
 *  2 - Side restricted Arsenal
 *
 */
GVAR(level) = 2;
GVAR(allowedradius) = 12;

GVAR(allowedPositions) = [
    getMarkerPos "arsenalTest",
    getmarkerpos GVARMAIN(RESPAWNMARKER)
];


/*
 *  no edit below needed
 *
 */
If !(IS_ARRAY(GVAR(allowedPositions))) then {
    GVAR(allowedPositions) = [];
};
IF !(IS_SCALAR(GVAR(allowedradius))) then {
    GVAR(allowedradius) = 5;
};
If !(IS_SCALAR(GVAR(fullArsenal))) then {
    GVAR(fullArsenal) = 0;
};
GVAR(arsenal_boxes) = [];

[
    localize "str_a3_cfghints_learn_arsenal0",
    {[] spawn FUNC(OpenMenu);},
    {[ace_player] call FUNC(canOpenMenu);},
    "\A3\ui_f\data\logos\arsenal_1024_ca.paa",
    2
] call EFUNC(gui_echidna,addApp);

[
    QGVAR(Arsenal),
    "\A3\ui_f\data\logos\arsenal_1024_ca.paa",
    {[ace_player] call FUNC(canOpenMenu);},
    []
] call EFUNC(gui,addNotification);

GVAR(postInit) = true;

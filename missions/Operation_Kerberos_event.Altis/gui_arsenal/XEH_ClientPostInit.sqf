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

/*
 *  0 - full Arsenal (default)
 *  1 - Restricted Arsenal
 *  2 - Side restricted Arsenal (exept Weapons)
 *  3 - Side restricted Arsenal
 *
 */
GVAR(level) = 0;
GVAR(allowedradius) = 25;

{
    [getMarkerPos _x] call FUNC(addArsenalArea);
} forEach ([side player] call BIS_fnc_getRespawnMarkers);


/*
 *  no edit below needed
 *
 */

GVAR(isPreloaded) = false;
GVAR(fullArsenal) = false;

IF !(IS_SCALAR(GVAR(allowedradius))) then {
    GVAR(allowedradius) = 15;
};
GVAR(fullArsenal) = GVAR(level) isEqualTo 0;

[
    localize "str_a3_cfghints_learn_arsenal0",
    "NONE",
    "\A3\ui_f\data\logos\arsenal_1024_ca.paa",
    {[false] spawn FUNC(OpenMenu);},
    {[ace_player] call FUNC(canOpenMenu);},
    []
] call EFUNC(gui_main,addApp);

[
    localize LSTRING(FASTARSENAL),
    "NONE",
    "\A3\ui_f\data\logos\arsenal_1024_ca.paa",
    {[true] spawn FUNC(OpenMenu);},
    {[ace_player] call FUNC(canOpenMenu);},
    []
] call EFUNC(gui_main,addApp);


[
    QGVAR(Arsenal),
    "\A3\ui_f\data\logos\arsenal_1024_ca.paa",
    {[ace_player] call FUNC(canOpenMenu);},
    []
] call EFUNC(gui,addNotification);

[
    QGVARMAIN(arsenalOpened),
    {
        ace_player setVariable [QGVAR(ArsenalIsOpened),true,true];
        [
            {
                isNull (uiNamespace getVariable ["BIS_fnc_arsenal_cam", objNull])
            },
            {
                [FUNC(cleanPlayer),[ace_player]] call CBA_fnc_directCall;
                ace_player setVariable [QGVAR(ArsenalIsOpened),false,true];
            }
        ] call CBA_fnc_waitUntilAndExecute;
    }
] call CBA_fnc_addEventHandler;

[
    QGVAR(cleanCargo),
    LINKFUNC(cleanCargo)
] call CBA_fnc_addEventHandler;


GVAR(postInit) = true;

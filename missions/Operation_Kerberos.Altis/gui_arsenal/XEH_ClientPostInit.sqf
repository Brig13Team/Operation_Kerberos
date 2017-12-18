/*
    Author: Dorbedo

    Description:
        postinit client
*/
#include "script_component.hpp"

CHECK(!hasInterface)

{
    [getMarkerPos _x] call FUNC(addArsenalArea);
} forEach ([side player] call BIS_fnc_getRespawnMarkers);


/*
 *  no edit below needed
 *
 */

GVAR(isPreloaded) = false;

IF !(IS_SCALAR(GVAR(allowedradius))) then {
    GVAR(allowedradius) = 15;
};

[
    localize "str_a3_cfghints_learn_arsenal0",
    "NONE",
    "\A3\ui_f\data\logos\arsenal_1024_ca.paa",
    {[false] spawn FUNC(OpenMenu);},
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
    "ace_arsenal_displayOpened",
    {
        ace_player setVariable [QGVAR(ArsenalIsOpened), true, true];
    }
] call CBA_fnc_addEventHandler;

[
    "ace_arsenal_displayClosed",
    {
        [{
            [FUNC(cleanPlayer),[ace_player]] call CBA_fnc_directCall;
            ace_player setVariable [QGVAR(ArsenalIsOpened), false, true];
        }] call CBA_fnc_execNextFrame;
    }
] call CBA_fnc_addEventHandler;

[
    QGVAR(cleanCargo),
    LINKFUNC(cleanCargo)
] call CBA_fnc_addEventHandler;

GVAR(postInit) = true;

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
GVAR(allowedradius) = 25;

[getmarkerpos GVARMAIN(RESPAWNMARKER)] call FUNC(addArsenalArea);
If (((getMarkerpos "respawn_west_tonos") distance2D [0,0,0])>100) then {
    [getmarkerpos "respawn_west_tonos"] call FUNC(addArsenalArea);
};


/*
 *  no edit below needed
 *
 */

GVAR(isPreloaded) = false;

IF !(IS_SCALAR(GVAR(allowedradius))) then {
    GVAR(allowedradius) = 5;
};
If !(IS_SCALAR(GVAR(fullArsenal))) then {
    GVAR(fullArsenal) = 0;
};

[
    localize "str_a3_cfghints_learn_arsenal0",
    {[false] spawn FUNC(OpenMenu);},
    {[ace_player] call FUNC(canOpenMenu);},
    "\A3\ui_f\data\logos\arsenal_1024_ca.paa",
    2
] call EFUNC(gui_echidna,addApp);

[
    localize LSTRING(FASTARSENAL),
    {[true] spawn FUNC(OpenMenu);},
    {[ace_player] call FUNC(canOpenMenu);},
    "\A3\ui_f\data\logos\arsenal_1024_ca.paa",
    1
] call EFUNC(gui_echidna,addApp);


[
    QGVAR(Arsenal),
    "\A3\ui_f\data\logos\arsenal_1024_ca.paa",
    {[ace_player] call FUNC(canOpenMenu);},
    []
] call EFUNC(gui,addNotification);


[
    QGVAR(debugArsenal),
    "CHECKBOX",
    [localize LSTRING(DEBUGARSENAL), localize LSTRING(DEBUGARSENAL_TOOLTIP)],
    localize ELSTRING(main,name),
    false,
    0
] call cba_settings_fnc_init;

[
    QGVAR(forceReload),
    "CHECKBOX",
    [localize LSTRING(forceReload), localize LSTRING(forceReload_TOOLTIP)],
    localize ELSTRING(main,name),
    false,
    0
] call cba_settings_fnc_init;

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

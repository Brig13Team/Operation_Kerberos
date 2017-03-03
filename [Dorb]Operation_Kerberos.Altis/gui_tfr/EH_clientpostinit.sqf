/*
    Author: Dorbedo

    Description:
        postinit client
*/
#define INCLUDE_GUI
#include "script_component.hpp"
CHECK(!hasInterface)
[
    [
        "<t color='#FFFF00'>"+localize ELSTRING(GUI_TFR,SHORT)+"</t>",
        {[]call EFUNC(gui_tfr,OpenMenu);},
        [],
        0.5,
        false,
        true,
        "",
        "alive _target"
    ]
] call CBA_fnc_addPlayerAction;

[
    localize (ELSTRING(GUI_TFR,SHORT)),
    {[]call EFUNC(gui_tfr,OpenMenu);},
    {true},
    "\A3\ui_f\data\igui\cfg\simpleTasks\types\radio_ca.paa",
    3
] call EFUNC(gui_echidna,addApp);

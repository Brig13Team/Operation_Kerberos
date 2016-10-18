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

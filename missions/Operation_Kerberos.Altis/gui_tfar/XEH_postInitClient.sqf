/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Post-Init
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

GVAR(sides) = [GVARMAIN(playerside)];

[
    localize LSTRING(HEADER),
    "NONE",
    getText(configfile >> "CfgMods" >> "tfar" >> "picture"),
    {[] spawn FUNC(OpenMenu);},
    {[ace_player] call FUNC(canOpenMenu);},
    []
] call EFUNC(gui_main,addApp);

[
    localize ELSTRING(main,name),
    QGVAR(keybind_openMenu),
    [localize LSTRING(KEYBIND), localize LSTRING(KEYBIND_TOOLTIP)],
    {if ([] call FUNC(canOpenMenu)) then {[] spawn FUNC(openMenu)};},
    {false}, [-1, [false, false, false]],
    false
] call CBA_fnc_addKeybind;

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
GVAR(tempPropertiesRadio) = locationNull;
GVAR(tempProperties) = [];

[] call FUNC(createRadioList);

[
    localize LSTRING(HEADER),
    {[] spawn FUNC(OpenMenu);},
    {[ace_player] call FUNC(canOpenMenu);},
    getText(configfile >> "CfgMods" >> "ACRE2" >> "picture"),
    3
] call EFUNC(gui_echidna,addApp);

[
    localize ELSTRING(main,name),
    QGVAR(keybind_openMenu),
    [localize LSTRING(KEYBIND), localize LSTRING(KEYBIND_TOOLTIP)],
    {if ([] call FUNC(canOpenMenu)) then {[] spawn FUNC(openMenu)};},
    {false}, [-1, [false, false, false]],
    false
] call CBA_fnc_addKeybind;

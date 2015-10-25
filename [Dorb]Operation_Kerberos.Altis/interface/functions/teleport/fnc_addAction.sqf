/*
    Author: Dorbedo

    Description:
        Adds Action to Teleporter

*/
#include "script_component.hpp"
SCRIPT(addAction);
CHECK(!hasInterface)
[["<t size='1.5' shadow='2' color='#F9FE44'>" +localize LSTRING(TELEPORT) +"</t>", {createDialog QGVAR(teleporter);}, [], 5, false, true, "","alive _target and (getposatl player distance getposatl teleporter) < 6"]] call CBA_fnc_addPlayerAction;
[["<t size='1.5' shadow='2' color='#F9FE44'>" +localize LSTRING(TELEPORT) +"</t>", {createDialog QGVAR(teleporter);}, [], 5, false, true, "","alive _target and (getposatl player distance getposatl teleporter2) < 6"]] call CBA_fnc_addPlayerAction;
[["<t size='1.5' shadow='2' color='#F9FE44'>" +localize LSTRING(TELEPORT) +"</t>", {createDialog QGVAR(teleporter);}, [], 5, false, true, "","alive _target and (getposatl player distance getposatl teleporter3) < 6"]] call CBA_fnc_addPlayerAction;
[["<t size='1.5' shadow='2' color='#F9FE44'>" +localize LSTRING(TELEPORT) +"</t>", {createDialog QGVAR(teleporter);}, [], 5, false, true, "","alive _target and (getposatl player distance getposatl teleporter4) < 6"]] call CBA_fnc_addPlayerAction;
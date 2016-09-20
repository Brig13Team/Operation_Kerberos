/*
 * Author: Dorbedo
 *
 */
 #include "script_component.hpp"

[
    QGVARMAIN(arsenalClosed),
    {[FUNC(checkRadio),_this] call CBA_fnc_directCall;}
] call CBA_fnc_addEventHandler;

#include "MissionSettings.sqf"

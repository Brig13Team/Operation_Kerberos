/*
 * Author: Dorbedo
 *
 */
 #include "script_component.hpp"
If (!hasInterface) then {
    [
        QGVARMAIN(arsenalClosed),
        {[FUNC(checkRadio),_this] call CBA_fnc_directCall;}
    ] call CBA_fnc_addEventHandler;
};

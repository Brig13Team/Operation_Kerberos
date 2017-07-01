/*
 *  Author: Dorbedo
 *
 *  Description:
 *      adds the init Eventhandler
 *
 */
#include "script_component.hpp"

["ReammoBox_F", "init", {
    [QGVAR(setContainerWeight),_this] call CBA_fnc_localEvent;
},true,[],true] call CBA_fnc_addClassEventHandler;

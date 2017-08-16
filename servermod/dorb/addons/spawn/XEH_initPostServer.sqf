/*
 *  Author: Dorbedo
 *
 *  Description:
 *      adds the init Eventhandler
 *
 */
#include "script_component.hpp"

["CAManBase", "initpost", {
    _this spawn FUNC(addNVG);
},true,[],true] call CBA_fnc_addClassEventHandler;

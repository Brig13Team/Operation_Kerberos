/*
 *  Author: Dorbedo
 *
 *  Description:
 *      adds the killed Eventhandler
 *
 */
#include "script_component.hpp"

CHECK(!isServer)

["CAManBase", "killed", {
    _this call FUNC(onkilled);
},true,[],true] call CBA_fnc_addClassEventHandler;

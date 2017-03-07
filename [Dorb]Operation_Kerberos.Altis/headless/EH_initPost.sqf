/*
 *  Author: Dorbedo
 *
 *  Description:
 *      adds the initpost Eventhandler
 *
 */
#include "script_component.hpp"

["AllVehicles", "initPost", {
    _this call FUNC(initPost);
},true,[],true] call CBA_fnc_addClassEventHandler;

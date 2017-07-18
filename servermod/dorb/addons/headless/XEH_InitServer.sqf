/*
 *  Author: Dorbedo
 *
 *  Description:
 *      adds the initpost Eventhandler
 *
 */
#include "script_component.hpp"
If (!isServer) exitWith {};

["AllVehicles", "init", {
    _this spawn FUNC(onInit);
},true,[],true] call CBA_fnc_addClassEventHandler;

/*
 *  Author: Dorbedo
 *
 *  Description:
 *      adds the hit Eventhandler
 *
 */
#include "script_component.hpp"

["LandVehicle", "hit", {
    _this call FUNC(onhit);
},true,[],true] call CBA_fnc_addClassEventHandler;

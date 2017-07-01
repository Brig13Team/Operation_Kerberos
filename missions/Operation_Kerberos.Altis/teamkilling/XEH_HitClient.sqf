/*
 *  Author: Dorbedo
 *
 *  Description:
 *      adds the killed Eventhandler
 *
 */
#include "script_component.hpp"

If (hasInterface) then {
    ["CAManBase", "Hit", {
        _this call FUNC(onHit);
    },true,[],true] call CBA_fnc_addClassEventHandler;
};

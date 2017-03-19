/*
 *  Author: Dorbedo
 *
 *  Description:
 *      adds the killed Eventhandler
 *
 */
#include "script_component.hpp"

If (hasInterface) then {
    ["CAManBase", "killed", {
        _this call FUNC(onkilled);
    },true,[],true] call CBA_fnc_addClassEventHandler;
};

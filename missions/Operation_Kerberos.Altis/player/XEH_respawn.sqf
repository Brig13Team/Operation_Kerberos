/*
 *  Author: Dorbedo
 *
 *  Description:
 *      adds the respawn Eventhandler
 *
 */
#include "script_component.hpp"

If (hasInterface) then {
    ["CAManBase", "respawn", {
        _this call FUNC(onrespawn);
    },true,[],true] call CBA_fnc_addClassEventHandler;
};

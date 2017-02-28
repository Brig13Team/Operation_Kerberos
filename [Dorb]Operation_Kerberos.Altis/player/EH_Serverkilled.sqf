/*
 *  Author: Dorbedo
 *
 *  Description:
 *      adds the killed Eventhandler
 *
 */
#include "script_component.hpp"

If (!hasInterface) then {

    GVAR(stats) = HASH_CREATE;
    ["CAManBase", "killed", {
        _this call FUNC(onkilledStats);
    },true,[],true] call CBA_fnc_addClassEventHandler;
    [
        LINKFUNC(handleStats),
        (60*15),
        []
    ] call CBA_fnc_addPerFrameHandler;

};

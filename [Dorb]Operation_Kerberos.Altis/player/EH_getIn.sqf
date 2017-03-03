/*
 *  Author: Dorbedo
 *
 *  Description:
 *      adds the getIn Eventhandler
 *
 */
#include "script_component.hpp"

If (!hasInterface) then {
    ["Air", "getIn", {
        ['pilotcheck',_this,(_this select 2)] call CBA_fnc_targetEvent;
    },true,[],true] call CBA_fnc_addClassEventHandler;
};

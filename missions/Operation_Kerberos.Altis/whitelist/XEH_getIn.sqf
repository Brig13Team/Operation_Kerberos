/*
 *  Author: Dorbedo
 *
 *  Description:
 *      adds the getIn Eventhandler
 *
 */
#include "script_component.hpp"

If (hasInterface) then {
    ["CAManBase", "GetInMan", {
        ["pilotcheck",_this,(_this select 0)] call CBA_fnc_targetEvent;
    },true,[],true] call CBA_fnc_addClassEventHandler;
};

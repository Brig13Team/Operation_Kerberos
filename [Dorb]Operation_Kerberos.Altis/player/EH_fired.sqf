/*
 *  Author: Dorbedo
 *
 *  Description:
 *      adds the fired Eventhandler
 *
 */
#include "script_component.hpp"

If (!hasInterface) then {
    ["CAManBase", "fired", {
        If (local (_this select 0)) then {
            _this spawn FUNC(onfired);
        };
        If ((hasinterface)&&(GVAR(suppression_active))) then {
            _this spawn FUNC(suppression_onfired);
        };
    },true,[],true] call CBA_fnc_addClassEventHandler;
};

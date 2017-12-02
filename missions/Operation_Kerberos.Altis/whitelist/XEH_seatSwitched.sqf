/*
 *  Author: Dorbedo
 *
 *  Description:
 *      adds the hit Eventhandler
 *
 */
#include "script_component.hpp"

If (!((getMissionConfigValue ["isKerberos", 0]) > 0)) exitWith {};

If (hasInterface) then {
    ["Air", "SeatSwitchedMan", {
        If !(missionNamespace getVariable [QGVAR(onlyPilotsFly),true]) exitWith {};
        _this call FUNC(onseatswitched);
    },true,[],true] call CBA_fnc_addClassEventHandler;
};

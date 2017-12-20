/*
 *  Author: Dorbedo
 *
 *  Description:
 *      adds the getIn Eventhandler
 *
 */
#include "script_component.hpp"

If (!((getMissionConfigValue ["isKerberos", 0]) > 0)) exitWith {};

If (hasInterface) then {
    ["CAManBase", "GetInMan", {
        If ((!(missionNamespace getVariable [QGVAR(onlyPilotsFly), true])) || {!local(_this select 0)}) exitWith {};
        [QGVAR(pilotcheck), _this, _this select 0] call CBA_fnc_targetEvent;
    }, true, [], true] call CBA_fnc_addClassEventHandler;
};

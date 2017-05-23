/*
 *  Author: iJesuz, Dorbedo
 *
 *  Description:
 *      handles the drones
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

CHECK(!(GVAR(active) && GVAR(drones_isActive)))


private _requests = missionNamespace getVariable [QGVAR(drones_requestedAirstrikes),[]];
private _leftrequests = [];
for "_i" from 0 to (count _requests - 1) do {
    if ((_requests select _i select 1) <= CBA_missiontime) then {
        if (count (missionNamespace getVariable [QGVAR(drones_availableAttackDrones),[]]) > 0) then {
            [_requests select _i select 0] spawn FUNC(drones_doAirstrike);
        } else {
            _leftrequests pushBack _requests;
        };
    };
};
GVAR(drones_requestedAirstrikes) = _leftrequests;


_requests = missionNamespace getVariable [QGVAR(drones_requestedReconnaissances),[]];
_leftrequests = [];
for "_i" from 0 to (count _requests - 1) do {
    if ((_requests select _i select 1) <= CBA_missiontime) then {
        if (count (missionNamespace getVariable [QGVAR(drones_availableReconDrones),[]]) > 0) then {
            [_requests select _i select 0, _requests select _i select 2, _requests select _i select 3] spawn FUNC(drones_doReconnaissance);
        } else {
            _leftrequests pushBack _requests;
        };
    };
};
GVAR(drones_requestedReconnaissances) = _leftrequests;

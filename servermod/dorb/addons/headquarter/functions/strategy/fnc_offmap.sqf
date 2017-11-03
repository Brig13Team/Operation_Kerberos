/**
 * Author: Dorbedo
 * call in offmap-support
 *
 * Arguments:
 * 0: <LOCATION> the attacklocation
 * 1: <LOCATION> the strategy
 * 2: <ARRAY> parameter
 *
 * Return Value:
 * <TYPENAME> return name
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_attackLoc","_strategy","_params"];

private _position = locationPosition _attackLoc;
_params params ["_type"];

switch _type do {
    case "helicopter" : {
        [_position,"helicopter"] call EFUNC(spawn,offmap_airsupport);
    };
    case "airinterception" : {
        [_position,"helicopter"] call EFUNC(spawn,offmap_airsupport);
    };
    case "dronestrike" : {
        private _nearPlayers = allPlayers select { ((_x distance _position)<600) && {!((vehicle _x) isKindOf "Air")} && {side _x == GVARMAIN(playerside)} && {(GVARMAIN(side) knowsAbout _x) > 1.5} };
        private _nearVehicles = _nearPlayers select {!((vehicle _x) == _x)};
        If !(_nearVehicles isEqualTo []) then {
            [selectRandom _nearVehicles,"dronestrike"] call EFUNC(spawn,offmap_airsupport);
        } else {
            If !(_nearPlayers isEqualTo []) then {
                [selectRandom _nearPlayers,"dronestrike"] call EFUNC(spawn,offmap_airsupport);
            };
        };
    };
    case "gunrun" : {
        private _nearPlayers = allPlayers select { ((_x distance _position)<600) && {!((vehicle _x) isKindOf "Air")} && {side _x == GVARMAIN(playerside)} && {(GVARMAIN(side) knowsAbout _x) > 1.5} };
        If !(_nearPlayers isEqualTo []) then {
            [selectRandom _nearPlayers,"plane_gunrun"] call EFUNC(spawn,offmap_airsupport);
        } else {
            [_position,"plane_gunrun"] call EFUNC(spawn,offmap_airsupport);
        };
    };
    case "missiles" : {
        private _nearPlayers = allPlayers select { ((_x distance _position)<600) && {!((vehicle _x) isKindOf "Air")} && {side _x == GVARMAIN(playerside)} && {(GVARMAIN(side) knowsAbout _x) > 1.5} };
        private _nearVehicles = _nearPlayers select {!((vehicle _x) == _x)};
        If !(_nearVehicles isEqualTo []) then {
            [selectRandom _nearVehicles,"plane_missiles"] call EFUNC(spawn,offmap_airsupport);
        } else {
            If !(_nearPlayers isEqualTo []) then {
                [selectRandom _nearPlayers,"plane_missiles"] call EFUNC(spawn,offmap_airsupport);
            } else {
                [_position,"plane_missiles"] call EFUNC(spawn,offmap_airsupport);
            };
        };
    };
    case "cluster" : {
        private _nearPlayers = allPlayers select { ((_x distance _position)<600) && {!((vehicle _x) isKindOf "Air")} && {side _x == GVARMAIN(playerside)} && {(GVARMAIN(side) knowsAbout _x) > 1.5} };
        If !(_nearPlayers isEqualTo []) then {
            [selectRandom _nearPlayers,"plane_bomb"] call EFUNC(spawn,offmap_airsupport);
        } else {
            [_position,"plane_bomb"] call EFUNC(spawn,offmap_airsupport);
        };
        HASH_SET(_ressourcesHash,"nextexecution",CBA_missiontime + GVAR(ressources_CallInreplenish_airinterception));
    };
};

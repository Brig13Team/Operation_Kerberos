/**
 * Author: Dorbedo
 * the user is allowed to open the spawn menu
 *
 * Arguments:
 * 0: <OBJECT> the player
 * 1: <STRING> the spawnID
 *
 * Return Value:
 * <BOOL> the user can open the menu
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params [
    ["_target", objNull, [objNull]],
    ["_player", objNull, [objNull]],
    ["_spawnID", "",[""]]
];

if ((isNull player)||{_spawnID isEqualTo ""}||(!(_player == vehicle ace_player))) exitWith {false};

if (GVAR(restrictAccess) && {!((_player call ace_common_fnc_isEngineer) && {_player getVariable [QGVARMAIN(isLogistician), false]})} ) exitWith {false};

private _spawnArray = GVAR(spawns) getVariable [_spawnID, []];

if (_spawnArray isEqualTo []) exitWith {false};

private _distance = (getPosASL _player) distance (_spawnArray select 1);

if ((_distance > CHECK_RADIUS_MAX)||{_distance < CHECK_RADIUS_MIN}) exitWith {false};

true

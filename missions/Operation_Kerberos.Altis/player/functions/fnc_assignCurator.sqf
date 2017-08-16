/*
 * Author: Dorbedo
 * Assigns the curator to a unit
 *
 * Arguments:
 * 0: player <OBJECT>
 *
 * Return Value:
 * none
 *
 * Example:
 * [player] call dorb_player_fnc_assignCurator;
 *
 * Public: Yes
 */
#include "script_component.hpp"
_this params [["_player",objNull,[objNull]]];

If !((isNull _player)||{isPlayer _player}) exitWith {};
If !(serverCommandAvailable "#shutdown") exitWith {};

[
    QGVAR(curator),
    [player]
] call CBA_fnc_serverEvent;

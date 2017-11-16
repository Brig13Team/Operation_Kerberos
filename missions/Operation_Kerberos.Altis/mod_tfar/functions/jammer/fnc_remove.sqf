/**
 * Author: Dorbedo
 * removes a jammer
 *
 * Arguments:
 * 0: <OBJECT> the object to be removed
 *
 * Return Value:
 * Nothing
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

If (!isServer) exitWith {
    [QGVAR(removeJammer),_this] call CBA_fnc_serverEvent;
};

params [["_jammer",objNull,[objNull]]];

If (GVAR(jammer) isEqualTo []) exitWith {};

GVAR(jammer) = GVAR(jammer) select {!((_x select 0) in [_jammer,objNull])};
publicVariable QGVAR(jammer);

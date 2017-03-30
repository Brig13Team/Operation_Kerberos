/*
 *  Author: Dorbedo
 *
 *  Description:
 *      removes a jammer
 *
 *  Parameter(s):
 *      0 : OBJECT - the jammer
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

If (!isServer) exitWith {
    [QGVAR(removeJammer),_this] call CBA_fnc_serverEvent;
};


_this params [["_jammer",objNull,[objNull]]];

CHECK(GVAR(jammer) isEqualTo [])

GVAR(jammer) = GVAR(jammer) select {!((_x select 0) in [_jammer,objNull])};
publicVariable QGVAR(jammer);

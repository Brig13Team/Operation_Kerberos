#include "script_component.hpp"
/**
 * Author: Dorbedo
 * registers the HC to the server
 *
 * Arguments:
 * Nothing
 *
 * Return Value:
 * Nothing
 *
 */

If (isServer||(!GVAR(HC_enabled))||hasInterface) exitWith {};

[QGVAR(HCjoined),[player]] call CBA_fnc_serverEvent;

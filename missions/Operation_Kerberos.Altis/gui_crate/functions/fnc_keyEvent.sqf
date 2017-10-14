/**
 * Author: Dorbedo
 * handle the key Event
 *
 * Arguments:
 * 0: <SCALAR> the key
 * 1: <BOOL> isPushed
 *
 * Return Value:
 * Nothing
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_key","_pushed"];
TRACEV_2(_key,_pushed);

If (!_pushed) exitWith {
    GVAR(multiplicator) = 1;
};

if (GVAR(multiplicator) > 1) exitWith {};

switch (_key) do {
    case 42 : {GVAR(multiplicator) = 10;};
    case 56 : {GVAR(multiplicator) = 100;};
};

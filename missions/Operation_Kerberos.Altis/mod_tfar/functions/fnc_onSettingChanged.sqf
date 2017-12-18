/**
 * Author: Dorbedo
 * initializes/deinitializes the AI-Hearing
 *
 * Arguments:
 * 0: <BOOL> initialize / deinitialize the setting
 *
 * Return Value:
 * Nothing
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

if !(hasInterface) exitWith {};

if (_this) then {
    if !(isNil QGVAR(HandlerID)) exitWith {};
    GVAR(HandlerID) = ["TFAR_event_OnSpeak", FUNC(onSpeak)] call CBA_fnc_addEventHandler;
} else {
    if (isNil QGVAR(HandlerID)) exitWith {};
    ["TFAR_event_OnSpeak", GVAR(HandlerID)] call CBA_fnc_removeEventHandler;
    GVAR(HandlerID) = nil;
};

/*
 *  Author: Dorbedo
 *
 *  Description:
 *      adds babbel custom mudles to ares
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

[
    "Babbel",
    "Add English",
    {
        _this params ["_position",["_unitUnderCursor",objNull,[objNull]]];
        If (isNull _unitUnderCursor) exitWith {
            hint "Fehler: No Unit";
        };
        [
            QGVAR(addLanguage),
            ["english"],
            _unitUnderCursor
        ] call CBA_fnc_targetEvent;
    }
] call ares_fnc_RegisterCustomModule;

[
    "Babbel",
    "Remove English",
    {
        _this params ["_position",["_unitUnderCursor",objNull,[objNull]]];
        If (isNull _unitUnderCursor) exitWith {
            hint "Fehler: No Unit";
        };
        [
            QGVAR(removeLanguage),
            ["english"],
            _unitUnderCursor
        ] call CBA_fnc_targetEvent;
    }
] call ares_fnc_RegisterCustomModule;

[
    "Babbel",
    "Add Arabic",
    {
        _this params ["_position",["_unitUnderCursor",objNull,[objNull]]];
        If (isNull _unitUnderCursor) exitWith {
            hint "Fehler: No Unit";
        };
        [
            QGVAR(addLanguage),
            ["arab"],
            _unitUnderCursor
        ] call CBA_fnc_targetEvent;
    }
] call ares_fnc_RegisterCustomModule;

[
    "Babbel",
    "Remove Arabic",
    {
        _this params ["_position",["_unitUnderCursor",objNull,[objNull]]];
        If (isNull _unitUnderCursor) exitWith {
            hint "Fehler: No Unit";
        };
        [
            QGVAR(removeLanguage),
            ["arab"],
            _unitUnderCursor
        ] call CBA_fnc_targetEvent;
    }
] call ares_fnc_RegisterCustomModule;

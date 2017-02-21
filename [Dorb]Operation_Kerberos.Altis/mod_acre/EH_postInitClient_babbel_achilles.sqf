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
            ["en"],
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
            ["en"],
            _unitUnderCursor
        ] call CBA_fnc_targetEvent;
    }
] call ares_fnc_RegisterCustomModule;

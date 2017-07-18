/*
 *  Author: Dorbedo
 *
 *  Description:
 *      onCameraChanged Event
 *
 *  Parameter(s):
 *      0 : STRING - CmaeraView
 *      1 : STRING - CameraOn
 *
 *  Returns:
 *      none
 *
 */
#include "script_component.hpp"

_this params ["_CameraView","_vehicle"];

if (! ([_CameraView, _vehicle] call FUNC(canChangeCamera))) exitWith {};

If (GVAR(forcealwaysFirst)) exitWith {
    _vehicle switchCamera "INTERNAL";
};

If (_vehicle isKindOf "CAManBase") exitWith {
    If (GVAR(forcefoot)) then {
        _vehicle switchCamera "INTERNAL";
    };
};

If (_vehicle isKindOf "LandVehicle") exitWith {
    If (GVAR(forcevehicle)) then {
        _vehicle switchCamera "INTERNAL";
    };
};

If (_vehicle isKindOf "Air") exitWith {
    If (GVAR(forceair)) then {
        _vehicle switchCamera "INTERNAL";
    };
};

If (_vehicle isKindOf "Ship") exitWith {
    If (GVAR(forceship)) then {
        _vehicle switchCamera "INTERNAL";
    };
};

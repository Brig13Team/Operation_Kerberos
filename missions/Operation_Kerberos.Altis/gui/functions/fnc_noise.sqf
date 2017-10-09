/*
 *  Author: Dorbedo
 *
 *  Description:
 *      creates the noise trough the noise controls Group
 *      creates the stripes
 *
 *  Parameter(s):
 *      0 : DISPLAY - The display where to create the noise
 *
 *  Returns:
 *      none
 *
 */
#define INCLUDE_GUI
#include "script_component.hpp"

disableSerialization;
params [["_display",displayNull,[displayNull]]];

CHECK(isNull _display)

private _noise = _display displayCtrl IDC_LOADING_NOISE;

CHECK(isNull _noise)

[
    {
        disableSerialization;
        (_this select 0) params [["_controlsGrp",controlNull,[controlNull]]];
        If (isNull _controlsGrp) exitWith {
            [(_this select 1)] call CBA_fnc_removePerFrameHandler;
        };
        for "_i" from 0 to 35 do {
            private _ctrl = _controlsGrp controlsGroupCtrl (IDC_LOADING_NOISE1 + _i);
            _ctrl ctrlSetPosition [0,random(safeZoneH),safezoneWAbs,0.004];
            _ctrl ctrlCommit 0;
        };
    },
    0.12,
    [_noise]
] call CBA_fnc_addPerFrameHandler;

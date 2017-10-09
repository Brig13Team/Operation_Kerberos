/**
 * Author: Dorbedo
 * shows the square noise
 *
 * Arguments:
 * 0: <DISPLAY> the noise display
 *
 * Return Value:
 * Nothing
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

#define ALPHA_MAX 0.3
#define ALPHA_INTERVALL 0.001

#define COLOR 0.1294117,0.1294117,0.1294117

disableSerialization;
params [["_display",displayNull,[displayNull]]];

If (isNull _display) exitWith {};

private _noise = _display displayCtrl IDC_LOADING_NOISE;

If (isNull _noise) exitWith {};

// init

for "_i" from 0 to 5 do {
    for "_j" from 0 to 5 do {
        private _ctrl = _noise controlsGroupCtrl (IDC_LOADING_NOISE1 + (_i * 6) + _j);
        _ctrl ctrlSetPosition [_i * (safeZoneWAbs /6),_j * (safeZoneH /6),safezoneWAbs / 6,safeZoneH / 6];
        _ctrl ctrlSetBackgroundColor [1,1,1,ALPHA_MAX];
        _ctrl ctrlCommit 0;
    };
};


GVAR(loading_alpha) = - ALPHA_MAX;
GVAR(loading_alpha2) = - (ALPHA_MAX /3);
GVAR(loading_alpha3) = 0;
GVAR(loading_alpha4) = (2*ALPHA_MAX / 3);

[
    {
        disableSerialization;
        (_this select 0) params [["_controlsGrp",controlNull,[controlNull]]];
        If (isNull _controlsGrp) exitWith {
            [(_this select 1)] call CBA_fnc_removePerFrameHandler;
        };
        GVAR(loading_alpha) = GVAR(loading_alpha) + ALPHA_INTERVALL;
        GVAR(loading_alpha2) = GVAR(loading_alpha2) + ALPHA_INTERVALL;
        GVAR(loading_alpha3) = GVAR(loading_alpha3) + ALPHA_INTERVALL;
        GVAR(loading_alpha4) = GVAR(loading_alpha4) + ALPHA_INTERVALL;
        If (GVAR(loading_alpha)>ALPHA_MAX) then {GVAR(loading_alpha) = - ALPHA_MAX;};
        If (GVAR(loading_alpha2)>ALPHA_MAX) then {GVAR(loading_alpha2) = - ALPHA_MAX;};
        If (GVAR(loading_alpha3)>ALPHA_MAX) then {GVAR(loading_alpha3) = - ALPHA_MAX;};
        If (GVAR(loading_alpha4)>ALPHA_MAX) then {GVAR(loading_alpha4) = - ALPHA_MAX;};

        for "_i" from 0 to 35 do {

            private _ctrl = _controlsGrp controlsGroupCtrl (IDC_LOADING_NOISE1 + _i);

            switch (_i mod 4) do {
                case 2 : { _ctrl ctrlSetBackgroundColor [COLOR, abs GVAR(loading_alpha4)];};
                case 1 : { _ctrl ctrlSetBackgroundColor [COLOR, abs GVAR(loading_alpha3)];};
                case 0 : { _ctrl ctrlSetBackgroundColor [COLOR, abs GVAR(loading_alpha2)];};
                default { _ctrl ctrlSetBackgroundColor [COLOR, abs GVAR(loading_alpha)];};
            };
            _ctrl ctrlCommit 0;
        };
    },
    0,
    [_noise]
] call CBA_fnc_addPerFrameHandler;

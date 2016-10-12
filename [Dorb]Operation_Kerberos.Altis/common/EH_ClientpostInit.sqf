#include "script_component.hpp"
CHECK(!hasInterface)
GVAR(lastCamWasArsenal) = false;
["ace_activeCameraChanged",
    {
        _this params ["_player","_isNotPlayerCam"];
        if (_isNotPlayerCam) then {
            GVAR(lastCamWasArsenal) = !(isNull (uiNamespace getVariable ["BIS_fnc_arsenal_cam", objNull])); // Arsenal
            If (GVAR(lastCamWasArsenal)) then {[QGVARMAIN(arsenalOpened),[_player]] call CBA_fnc_localEvent;};
        }else{
            If (GVAR(lastCamWasArsenal)) then {
                [QGVARMAIN(arsenalClosed),[_player]] call CBA_fnc_localEvent;
            };
        };
    }
] call CBA_fnc_addEventHandler;

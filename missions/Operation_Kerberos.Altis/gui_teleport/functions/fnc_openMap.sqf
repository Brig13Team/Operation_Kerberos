/*
 *  Author: Dorbedo
 *
 *  Description:
 *      opens the strategic map with the teleport Targets
 *
 *  Parameter(s):
 *      0 : STRING - teleport type
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"


_this params ["_type"];
TRACEV_1(_type);

private _teleportTargets = missionNamespace getVariable [(format[QGVAR(%1),_type]),[]];
private _fakeMissions = [];

If ((GVAR(to_lead_active))&&{_type == "infanterie"}) then {
    _fakeMissions pushBack [
        (getPos (leader ace_player)),
        {[] call FUNC(lead)},
        (localize LSTRING(LEAD)),
        name ace_player,
        localize LSTRING(MAP_DESCRIPTION),
        "",
        1,
        []
    ];
};


{
    _x params ["_position","_targetName","_condition","_params"];
    If (_params call _condition) then {
        _fakeMissions pushBack [
            _position,
            {(_this select 9) call FUNC(teleport)},
            _targetName,
            name ace_player,
            localize LSTRING(MAP_DESCRIPTION),
            "",
            1,
            [_type,_forEachIndex]
        ];
    };
} forEach _teleportTargets;


CHECK(_fakeMissions isEqualTo [])
closeDialog IDD_GUI_TELEPORT;

[
    [] call bis_fnc_displayMission,
    getPos ace_player,
    _fakeMissions,
    [],  // ORBAT
    [], // Marker
    [], // Images
    1,  // Overcast
    false,  //NightVision
    1, //Scale
    true, // enabledSimulation
    localize LSTRING(MAP_SELECTPOSITION), // Button Bar name
    true // Icon Label
] spawn BIS_fnc_StrategicMapOpen

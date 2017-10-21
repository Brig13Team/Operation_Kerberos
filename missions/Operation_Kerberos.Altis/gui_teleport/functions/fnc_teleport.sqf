/*
 *  Author: Dorbedo
 *
 *  Description:
 *      teleports a player to a position
 *
 *  Parameter(s):
 *      0 : ARRAY - Targetposition
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"
TRACEV_1(_this);
_this params ["_type","_index"];

((missionNamespace getVariable (format[QGVAR(%1),_type])) select _index) params ["_position","_targetName","_condition","_params"];
_position = + _position;
If ((isNil "_position")||{!(_params call _condition)}) exitWith {
    [localize LSTRING(TELEPORT),localize LSTRING(DEACTIVATED),"red"] call EFUNC(gui,message);
};

closeDialog IDD_GUI_TELEPORT;

If (IS_CODE(_position)) then {
    _position = _params call _position;
};

switch (true) do {
    case ((vehicle ace_player) == ace_player) : {/*nothing*/};
    case ((vehicle ace_player) isKindof "Air") : {
        _targetPos set[2,
            (((ATLtoASL[_position select 0, _position select 1,0])select 2) max 0) + 300 + random 1000
        ];
    };
    case ((vehicle ace_player) isKindof "Ship") : {
        _position = [_position, 0, 100, 3, 1, 0.5, 0, [], [_position getPos[random 75,random 360],_position getPos[random 75,random 360]]] call BIS_fnc_findSafePos;
        _position set[2,0];
    };
    default {
        _position = [_position, 0, 100, 3, 0, 0.5, 0, [], [_position getPos[random 75,random 360],_position getPos[random 75,random 360]]] call BIS_fnc_findSafePos;
        _position set[2,0];
        _position = ATLtoASL _position;
    };
};

(vehicle player) setPosASL _position;

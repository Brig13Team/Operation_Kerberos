/*
 *  Author: Dorbedo
 *
 *  Description:
 *      adds an Arsenal to an area
 *
 *  Parameter(s):
 *      0 : ARRAY/STRING/OBJECT - adds an arsenal to an area
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_position",[],[[],objNull,""],[2,3]]];

If (IS_OBJECT(_position)) then {_position = getPos _position;};
If (IS_STRING(_position)) then {_position = getMarkerPos _position;};

GVAR(allowedPositions) pushBack _position;
CHECK(!isServer)
If !(missionNamespace getVariable [QGVAR(ArsenalIsTransmitting),false]) then {
    GVAR(ArsenalIsTransmitting) = true;
    [
        {
            GVAR(ArsenalIsTransmitting) = false;
            publicvariable QGVAR(arsenal_boxes);
            publicvariable QGVAR(allowedPositions);
        },
        [],
        5
    ] call CBA_fnc_waitAndExecute;
};
